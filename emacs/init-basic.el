
;;(set-frame-parameter (selected-frame) 'alpha '(95 . 60))
;;(add-to-list 'default-frame-alist '(alpha . (95 . 60)))
;;(add-to-list 'default-frame-alist '(alpha 85 85))
;;(set-face-attribute 'default nil :background nil)
(set-frame-parameter (selected-frame) 'alpha-background 85)
(add-to-list 'default-frame-alist '(alpha-background . 85))
(add-to-list 'default-frame-alist '(background-color . "nil")) 
(setq inhibit-startup-message t)

(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar
;; remove backup files (e.g. README.md~)
(setq make-backup-files nil)
;; Shift-arrow to swith windows
(windmove-default-keybindings)
;; (global-unset-key (kbd "C-x C-c"))
;; (global-unset-key (kbd "M-`")) ; not v

(global-auto-revert-mode t)

 (add-hook 'text-mode-hook 'turn-on-auto-fill):
;; Disable auto-fill-mode in programming mode
(add-hook 'prog-mode-hook (lambda () (auto-fill-mode -1)))
(save-place-mode)

;; Auto revert mode
(global-auto-revert-mode 1)
;; Keep track of loading time
(defconst emacs-start-time (current-time))
;; Search only visible 
(setq column-number-mode t)
(setq x-select-enable-clipboard t)
;; (desktop-save-mode 1)
; end file with new line ("\n")
(setq mode-require-final-newline t)

;;Line Numbers
(column-number-mode)
(global-display-line-numbers-mode t)
;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
		vterm-mode-hook 
                dired-mode-hook
                eshell-mode-hook))
(add-hook mode (lambda () (display-line-numbers-mode 0))))


;; Set default font
(set-face-attribute 'default nil
                    :family "MonoLisa"
                    :foreground "#92e58d"
                    :height 105
                    :weight 'normal
                    :width 'normal)


(add-hook 'text-mode-hook 'turn-on-auto-fill)

(set-face-attribute 'font-lock-comment-face nil :foreground "#5B6268" :slant 'italic)
(set-face-attribute 'font-lock-function-name-face nil :foreground "#c678dd" :slant 'italic)
(set-face-attribute 'font-lock-variable-name-face nil :foreground "#dcaeea" :slant 'italic)   
;; ivy 

(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "<f2> j") 'counsel-set-variable)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-c v") 'ivy-push-view)
(global-set-key (kbd "C-c V") 'ivy-pop-view)))

(provide 'init-basic) 
