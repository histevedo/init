
;;; Use Miminish minor modes to change the mode line


(use-package diminish
  :ensure t
  :demand t
  :diminish hs-minor-mode
  :diminish abbrev-mode
  :diminish auto-revert-mode
  :diminish auto-fill-function
  :diminish mail-abbrevs-mode
  :diminish highlight-indentation-mode
  :diminish subword-mode)

;;; Stolen From https://github.com/hrs/dotfiles/blob/master/emacs.d/configuration.org
(defmacro diminish-minor-mode (filename mode &optional abbrev)
  "Macro for diminish minor mode with FILENAME MODE and ABBREV."
  `(eval-after-load (symbol-name ,filename)
     '(diminish ,mode ,abbrev)))

(display-time-mode 1)
(defmacro diminish-major-mode (mode-hook abbrev)
  "Macro for diminish major mode with MODE-HOOK and ABBREV."
  `(add-hook ,mode-hook
             (lambda () (setq mode-name ,abbrev))))
(diminish-minor-mode 'highlight-indentation 'highlight-indentation-mode )
(diminish-minor-mode 'mail-abbrevs 'mail-abbrevs-mode )
(diminish-minor-mode 'auto-revert 'auto-revert-mode)
(diminish-minor-mode 'simple 'auto-fill-function )
(diminish-minor-mode 'eldoc 'eldoc-mode)
(diminish-major-mode 'emacs-lisp-mode-hook "Elisp")
(diminish-major-mode 'lisp-interaction-mode-hook "λ")
(diminish-major-mode 'python-mode-hook "Py")

(set-face-attribute 'mode-line           nil :background "black")
(set-face-attribute 'mode-line-buffer-id nil :background "pink" :foreground "black")
(defface mode-line-directory
  '((t :background "blue" :foreground "grey"))
  "Face used for buffer identification parts of the mode line."
  :group 'mode-line-faces
  :group 'basic-faces)
(set-face-attribute 'mode-line-highlight nil :box nil :background "deep sky blue")
(set-face-attribute 'mode-line-inactive  nil :inherit 'default)

(setq mode-line-percent-position '(-3 "%p"))

;;remove all the trailing dashes in the mode line 
(setq-default mode-line-end-spaces nil)
(setq-default mode-line-mule-info nil) 
(setq-default mode-line-frame-identification nil) 
(provide 'init-mode-lineb) 
