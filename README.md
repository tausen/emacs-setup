# emacs23-setup

A basic emacs23 (now mostly emacs24, actually) setup, customized for my needs.

Initial setup based on emacs-starter-kit: https://github.com/technomancy/emacs-starter-kit/

### Getting started
#### Installation
- cd to ~/.emacs.d and ensure ~/emacs does not exist
- Clone this repository
- git submodule init
- git submodule update

#### Configuration
##### IRC
- Customize znc connection settings with M-x customize-group znc RET
- Customize IRC (ERC) alerts and channels

##### w3m browser
- Install w3m: sudo apt-get install w3m / yum -y install w3m

##### LaTeX
- Ensure that auctex is installed, do M-x package-install auctex -- I had some issues with this and had to install from http://www.gnu.org/software/auctex/download.html
- Customize LaTeX compilation command

##### Python
- Get EIN (emacs-ipython-notebook) via M-x package-install ein or via M-x package-list-packages
- Get Jedi via M-x package-install jedi
- Get epc via M-x package-install epc
- Install python modules via pip install epc jedi or cd ~/.emacs.d/elpa/jedi-* && make requirements

#### Running
- For best experience, always start emacs with emacsclient -c -a "" (bind it to a hotkey!)
- Oh, and for better performance C-u 0 M-x byte-recompile-directory RET ~/.emacs.d/ RET

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
