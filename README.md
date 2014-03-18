# emacs-setup

A basic emacs24 setup, customized for my needs.

### Getting started
#### Installation
- cd to ~/.emacs.d and ensure ~/emacs does not exist
- Clone this repository
- git submodule init
- git submodule update
- M-x package-list-packages and install pkg-info
- Install exuberant-ctags for generating TAGS files (e.g. sudo apt-get install exuberant-ctags)

#### Configuration
##### IRC
- Customize znc connection settings with M-x customize-group znc RET
- Customize IRC (ERC) alerts and channels

##### w3m browser
- Install w3m: sudo apt-get install w3m / yum -y install w3m

##### LaTeX
- Ensure that auctex is installed, do M-x package-install auctex -- I had some issues with this and had to install from http://www.gnu.org/software/auctex/download.html
- Customize LaTeX compilation command

##### Org-mode
- I had some issues with org-mode (especially export), which seem to be fixed in version 8. Still seems like version 7.9 is shipped with emacs 24, though, so install the new version via M-x package-list-packages, search for org
- NOTE: org has some issues if not installed in a "clean" emacs session (that is, org-mode must not be loaded when installing the new version). This config does some org initialization on startup, so start emacs with "emacs -q" and install org, that seems to do the trick

##### Python
- Get EIN (emacs-ipython-notebook) via M-x package-install ein or via M-x package-list-packages
- Get Jedi via M-x package-install jedi
- Get epc via M-x package-install epc
- Install python modules via pip install epc jedi or cd ~/.emacs.d/elpa/jedi-* && make requirements
- sudo apt-get install pep8 pyflakes

#### Running
- For best experience, always start emacs with emacsclient -c -a "" (bind it to a hotkey!)
- Oh, and for better performance C-u 0 M-x byte-recompile-directory RET ~/.emacs.d/ RET (you might have to delete lib/auctex/preview/prv-xemacs.el if this gives you issues)
- For better theme when running with no window, you may wanna add this to your .bashrc: `export TERM=xterm-256color`

#### Issues
- Magit control characters instead of colors - do "git config --global --edit" and set color.diff to auto

#### Includes
- nXhtml mode: http://ourcomments.org/Emacs/nXhtml/doc/nxhtml.html
- zenburn theme
- dired+ and some dired customization 
- Some autocompletion/semantics
- breadcrumbs
- Some css-related commands
- Mode for Blackfin assembly (based on generic mode)
- Mode for MATLAB: http://www.emacswiki.org/MatlabMode
- Some configuration for LaTeX (not quite finished)
- Magit git plugin
- In-emacs browser (w3m, requires w3m to be installed)
- js2-mode
- Minor eshell customization
- IRC using ERC and ZNC + desktop notifications for IRC
- yasnippet
- emacs-for-python
- autopair (proper auto-insert parenthesis etc.)

...and some more stuff I forgot

#### Some of the added hotkeys
- Inserting braces
- Comment/uncomment region
- Indenting
- Toggling line truncation
- Opening ansi-term in buffer: http://www.enigmacurry.com/page/4/
- Toggle a few modes (auto-complete, autopair, flyspell, ..)
- Mark word under pointer

...etc.
