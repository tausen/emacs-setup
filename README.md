# emacs-setup

A basic emacs24 setup, customized for my needs.

### Getting started
#### Installation
- Ensure ~/emacs does not exist
- Clone this repository into ~/.emacs.d
- cd into lib/powerlinefonts and do ./install.sh
- git submodule init
- git submodule update
- cd into lib/helm and run make
- M-x package-list-packages and install pkg-info
- M-x package-list-packages and install fringe-helper (for git-gutter)
- cd into lib/magit and do make lisp
- For better performance, do C-u 0 C-c M-x byte-recompile-directory RET ~/.emacs.d/ RET (if this config has not been loaded, omit C-c)
  - You might have to delete lib/auctex/preview/prv-xemacs.el if this gives you issues

##### TAGS
- Install exuberant-ctags for generating TAGS files (e.g. sudo apt-get install exuberant-ctags)
- For gtags, install GNU Global from http://www.gnu.org/software/global/ and the pygments plugin parser from https://github.com/yoshizow/global-pygments-plugin

##### IRC
- Customize znc connection settings with M-x customize-group znc RET
- Customize IRC (ERC) alerts and channels

##### w3m browser
- Install w3m: sudo apt-get install w3m / yum -y install w3m

##### LaTeX
- Ensure that auctex is installed
  - cd into lib/auctex and do
    - ./configure
    - make
    - make install
  - or do M-x package-install auctex or install from http://www.gnu.org/software/auctex/download.html
- Customize LaTeX compilation command in init-latex.el (includes examples)

##### Org-mode
- I had some issues with org-mode (especially export), which seem to be fixed in version 8. Still seems like version 7.9 is shipped with emacs 24, though, so install the new version via M-x package-list-packages, search for org
- NOTE: org has some issues if not installed in a "clean" emacs session (that is, org-mode must not be loaded when installing the new version). This config does some org initialization on startup, so start emacs with "emacs -q" and install org, that seems to do the trick

##### Python
- Get EIN (emacs-ipython-notebook) via M-x package-install ein or via M-x package-list-packages
- Get Jedi via M-x package-install jedi
- Get epc via M-x package-install epc
- Install python modules via pip install epc jedi or cd ~/.emacs.d/elpa/jedi-* && make requirements
- sudo apt-get install pep8 pyflakes

##### Javascript
- For completion in js2-mode using tern, cd into lib/tern and do sudo npm install

##### TypeScript
- Get the tss package via M-x package-install tss
- Install [typescript-tools](https://github.com/clausreinke/typescript-tools) via: npm install -g typescript-tools

#### Running
- For best experience, always start emacs with emacsclient -c -a "" (bind it to a hotkey!)
- Oh, and for better performance C-u 0 C-c M-x byte-recompile-directory RET ~/.emacs.d/ RET (you might have to delete lib/auctex/preview/prv-xemacs.el if this gives you issues)
- For better theme when running with no window, you may wanna add this to your .bashrc: `export TERM=xterm-256color`

#### Issues
- Magit control characters instead of colors - do "git config --global --edit" and set color.diff to auto
