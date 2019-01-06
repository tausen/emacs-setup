# emacs-setup

#### Emacs server
Copy `emacs.service` to `~/.config/systemd/user/` and do `systemctl --user enable emacs` to enable the server on boot. Start it manually with `systemctl --user start emacs`. Then use `emacsclient -c` instead of `emacs` when editing files. Use `-nw` to not open a GUI.

#### Installation
- Ensure ~/.emacs does not exist
- Clone this repository into ~/.emacs.d
- `git submodule init`
- `git submodule update`
- Install GNU Global from http://www.gnu.org/software/global/
- Install pep8 and pyflakes (e.g. `sudo apt-get install pep8 pyflakes`)
- To use pdf-tools, do M-x pdf-tools-install
- To use mu4e to read mail, follow the directions in init-mu4e.el

#### Configuration
- For a slightly more emacsy experience, dont load init-godmode.el in init.el

#### Running
- For faster loading, do `C-u 0 C-c M-x byte-recompile-directory RET ~/.emacs.d/ RET` (if this config has not been loaded, omit `C-c`)
- For best experience, always start emacs with `emacsclient -c -a ""` (bind it to a hotkey!)
- For better theme when running with no window, you may wanna add this to your .bashrc: `export TERM=xterm-256color`

#### Usage
- Check init-c.el for details on completion in C
- In Python mode, do
  - `C-c C-r` to execute the selected region
  - `C-c C-z` to open a python shell for the current buffer.
  - `C-c C-c` to run the current buffer - with prefix (`C-u`) to also execute code in `__name__ == "__main__"` block
- In any mode, open magit status buffer with `C-x g`
- With init-godmode.el loaded, use `RET` to toggle god-mode. Use `F7` to toggle between `RET` sending newline and toggling god-mode. In god-mode:
  - press `<key>` to send `C-<key>`
  - press `SPC <key>` to send `<key>`
  - press `g <key>` to send `M-<key>`
  - press `z` to re-send previous command
- Projectile:
  - `C-c p p` to switch project
  - `C-c p f` to find file in project
  - `C-c p c` to compile project (with prefix `C-u` to set compile command)
- Non-standard navigation bindings:
  - `M-n` and `M-p` to move up/down in smaller steps than `C-v` and `M-v` without moving point
  - `C-S-n` and `C-S-p` to move point up/down a few lines

#### Issues
- Magit control characters instead of colors - do `git config --global --edit` and set `color.diff` to auto

