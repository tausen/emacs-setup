;; Using generic mode for blackfin assembly
(require 'generic-x)

;; Bfin assembly mode
(define-generic-mode 
    'bfin-mode                          ; name of the mode to create
  '(("#")
    ("//"))                             ; comments start with '#' or '//'
  '("LSETUP" "RTS" "LINK")              ; some keywords
  '(("=" . 'font-lock-operator)         ; '=' is an operator
    (";" . 'font-lock-builtin)          ; ';' is a built-in
    ("\\(^\s*\\.[a-zA-Z0-9_]+:?\\)" . 'font-lock-keyword-face) ; labels: .something:
    ("\\(\s+0[xX][0-9a-fA-F]+\\)" . 'font-lock-variable-name-face) ; hex numbers
    ("\\(\s+[0-9a-f]+\\)" . 'font-lock-variable-name-face) ; decimal numbers
    ("\\(^\s*_[a-zA-Z0-9]+:?\\)" . 'font-lock-function-name-face)) ; symbols: _something:
  '("\\.s$")                        ; files for which to activate this mode 
  nil                               ; other functions to call
  "A mode for bfin assembly"        ; doc string for this mode
  )
(eval-after-load 'bfin 
  '(define-key bfin-mode [(tab)] 'c-indent-line-or-region))
