#!/usr/bin/env python
"""A hacked up version of the multiple-Python checkers script from EmacsWiki.

 - Simplified & faster
 - Extended with pep8.py
 - Extended with pydo (http://www.lunaryorn.de/code/pydo.html)
 - pylint & pychecker removed

Drop something like this in your .emacs:

(when (load "flymake" t)
  (defun flymake-pycheckers-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "/path/to/this/file" (list local-file))))


You may also need to set up your path up in the __main__ function at the
bottom of the file and change the #! line above to an appropriate interpreter.

==============================================================================

This code is made available by Jason Kirtland <jek@discorporate.us> under the
Creative Commons Share Alike 1.0 license:
http://creativecommons.org/licenses/sa/1.0/

Original work taken from http://www.emacswiki.org/emacs/PythonMode, author
unknown.

"""


## Customization ##

# Checkers to run be default, when no --checkers options are supplied.
# One or more of pydo, pep8 or pyflakes, separated by commas
#default_checkers = 'pep8, pyflakes, epylint'
#default_checkers = 'pep8, pyflakes,pylint'
#default_checkers = 'pylint'
default_checkers = 'pep8, pyflakes'

# A list of error codes to ignore.
# default_ignore_codes = ['E225', 'W114']
default_ignore_codes = []
# E501 = line too long
# E221 = multiple spaces before operator
default_ignore_codes = ['E501']



## End of customization ##

import os
from os import path
import re
import sys

from subprocess import Popen, PIPE


class LintRunner(object):
    """Base class provides common functionality to run python code checkers."""

    output_format = ("%(level)s %(error_type)s%(error_number)s:"
                     "%(description)s at %(filename)s line %(line_number)s.")

    output_template = dict.fromkeys(
        ('level', 'error_type', 'error_number', 'description',
         'filename', 'line_number'), '')

    output_matcher = None

    sane_default_ignore_codes = set([])

    command = None

    run_flags = ()

    def __init__(self, ignore_codes=(), use_sane_defaults=True):
        self.ignore_codes = set(ignore_codes)
        if use_sane_defaults:
            self.ignore_codes ^= self.sane_default_ignore_codes

    def fixup_data(self, line, data):
        return data

    def process_output(self, line):
        m = self.output_matcher.match(line)
        if m:
            return m.groupdict()

    def run(self, filename):
        args = [self.command]
        args.extend(self.run_flags)
        args.append(filename)
        process = Popen(args, stdout=PIPE, stderr=PIPE)

        for line in process.stdout:
            match = self.process_output(line)
            if match:
                tokens = dict(self.output_template)
                tokens.update(self.fixup_data(line, match))
                print self.output_format % tokens

        for line in process.stderr:
            match = self.process_output(line)
            if match:
                tokens = dict(self.output_template)
                tokens.update(self.fixup_data(line, match))
                print self.output_format % tokens


class PyflakesRunner(LintRunner):
    """Run pyflakes, producing flymake readable output.

    The raw output looks like:
      tests/test_richtypes.py:4: 'doom' imported but unused
      tests/test_richtypes.py:33: undefined name 'undefined'
    or:
      tests/test_richtypes.py:40: could not compile
             deth
            ^
    """

    command = 'pyflakes'

    output_matcher = re.compile(
        r'(?P<filename>[^:]+):'
        r'(?P<line_number>[^:]+):'
        r'(?P<description>.+)$')

    @classmethod
    def fixup_data(cls, line, data):
        if 'imported but unused' in data['description']:
            data['level'] = 'WARNING'
        elif 'redefinition of unused' in data['description']:
            data['level'] = 'WARNING'
        else:
            data['level'] = 'ERROR'
        data['error_type'] = 'PY'
        data['error_number'] = 'F'

        return data

class EpylintRunner(LintRunner):
    """Run epylint, producing flymake readable output.

    The raw output looks like:
src/subscription_manager/managercli.py:465: Warning (W): TODO remove the username/password
src/subscription_manager/managercli.py:791: Warning (W): TODO:  Something about these magic numbers!
src/subscription_manager/managercli.py:24: Warning (W): Relative import 'constants', should be 'subscription_manager.constants'
"""

    command = 'epylint'

    output_matcher = re.compile(
        r'(?P<filename>[^:]+):'
        r'(?P<line_number>[^:]+):'
        r'\s+(?P<level>.*)\s+\((?P<error_type>.+)(?P<error_number>\d\d\d\d).*\):'
        r'(?P<description>.+)$')

    @classmethod
    def fixup_data(cls, line, data):
        if data['level'] == "Warning":
            data['level'] = 'WARNING'
        if data['level'] == 'Error':
            data['level'] =  'ERROR'

        return data


class PylintRunner(LintRunner):
    """Run pylint, producing flymake readable output.

    The raw output looks like:
src/subscription_manager/managercli.py:798: [W0703, ListCommand._do_command] Catch "Exception"
src/subscription_manager/managercli.py:838: [C0111, ListCommand._format_name.add_line] Missing docstring
src/subscription_manager/managercli.py:828: [R0201, ListCommand._format_name] Method could be a function
src/subscription_manager/managercli.py:856: [C0111, CLI] Missing docstring
src/subscription_manager/managercli.py:861: [C0324, CLI.__init__] Comma not followed by a space

"""

    command = 'pylint'

    output_matcher = re.compile(
        r'(?P<filename>[^:]+):'
        r'(?P<line_number>[^:]+):'
        r'\s+\[(?P<error_type>.+)(?P<error_number>\d\d\d\d).*?\]'
        r'(?P<description>.*)')

    @classmethod
    def fixup_data(cls, line, data):
        # Refactor, Convention, Warning
        if data['error_type'] in ['R','C','W']:
            data['level'] = "WARNING"
        # Error, Fatal
        if data['error_type'] in ['E', 'F']:
            data['level'] = 'ERROR'

        return data

    @property
    def run_flags(self):
        return '--output-format=parseable','--include-ids=y','--reports=n'


class Pep8Runner(LintRunner):
    """Run pep8.py, producing flymake readable output.

    The raw output looks like:
      spiders/structs.py:3:80: E501 line too long (80 characters)
      spiders/structs.py:7:1: W291 trailing whitespace
      spiders/structs.py:25:33: W602 deprecated form of raising exception
      spiders/structs.py:51:9: E301 expected 1 blank line, found 0

    """

    command = 'pep8'

    output_matcher = re.compile(
        r'(?P<filename>[^:]+):'
        r'(?P<line_number>[^:]+):'
        r'[^:]+:'
        r' (?P<error_number>\w+) '
        r'(?P<description>.+)$')

    @classmethod
    def fixup_data(cls, line, data):
        data['level'] = 'WARNING'
        return data

    @property
    def run_flags(self):
        return '--repeat', '--ignore=' + ','.join(self.ignore_codes)


class PydoRunner(LintRunner):
    """Run pydo, producing flymake readable output.

    The raw output looks like:
      users.py:356:FIXME this will fail if None
      users.py:470:todo:rtf memcache this possibly?
      users.py:482:TODO This will need to trigger a history entry and

    """

    command = 'pydo'

    output_matcher = re.compile(
        r'(?P<filename>[^:]+):'
        r'(?P<line_number>[^:]+):'
        r'(?P<error_number>\w+)'
        r'(\W*|\s*)'
        r'(?P<description>.*)$')

    @classmethod
    def fixup_data(cls, line, data):
        number = data['error_number'] = data['error_number'].upper()
        if number == 'FIXME':
            data['level'] = 'ERROR'
        else:
            data['level'] = 'WARNING'
        return data


def croak(*msgs):
    for m in msgs:
        print >> sys.stderr, m.strip()
    sys.exit(1)


RUNNERS = {
    'pyflakes': PyflakesRunner,
    'pep8': Pep8Runner,
    'pydo': PydoRunner,
    'epylint': EpylintRunner,
    'pylint':PylintRunner,
    }


if __name__ == '__main__':
    # transparently add a virtualenv to the path when launched with a venv'd
    # python.
    os.environ['PATH'] = \
      path.dirname(sys.executable) + ':' + os.environ['PATH']

    if len(sys.argv) < 2:
        croak("Usage: %s [file]" % sys.argv[0])
    elif len(sys.argv) > 2:
        from optparse import OptionParser
        parser = OptionParser()
        parser.add_option("-i", "--ignore_codes", dest="ignore_codes",
                          default=[], action='append',
                          help="error codes to ignore")
        parser.add_option("-c", "--checkers", dest="checkers",
                          default='pep8,pyflakes',
                          help="comma separated list of checkers")
        options, args = parser.parse_args()
        if not args:
            croak("Usage: %s [file]" % sys.argv[0])
        if options.checkers:
            checkers = options.checkers
        else:
            checkers = default_checkers
        if options.ignore_codes:
            ignore_codes = options.ignore_codes
        else:
            ignore_codes = default_ignore_codes
        source_file = args[0]
    else:
        source_file = sys.argv[1]
        checkers = default_checkers
        ignore_codes = default_ignore_codes

    for checker in checkers.split(','):
        try:
            cls = RUNNERS[checker.strip()]
        except KeyError:
            croak(("Unknown checker %s" % checker),
                  ("Expected one of %s" % ', '.join(RUNNERS.keys())))
        runner = cls(ignore_codes=ignore_codes)
        runner.run(source_file)

    sys.exit(0)
