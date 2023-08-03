
;;disable theme background color in terminal
(defun on-after-init ()
    (unless (display-graphic-p (selected-frame))
          (set-face-background 'default "unspecified-bg" (selected-frame))))

(add-hook 'window-setup-hook 'on-after-init)

  (setq default-frame-alist '((width . 90)
                              (height . 50)
                              (alpha-background . 80)))
;; Set transparency for default theme
;;mouse 
(unless (display-graphic-p)
    (xterm-mouse-mode 1))

(setq inhibit-startup-message t)

;; use standard keys for undo cut copy paste
(cua-mode 1)
;; C-x j, which is bound to kanji entering, is too close to dired's C-x C-j
(global-unset-key "\C-xj")

(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
(show-paren-mode t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room
(menu-bar-mode -1)            ; Disable the menu bar
(transient-mark-mode -1) 
 (defalias 'y-or-n-p 'yes-or-no-p)
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
                    :foreground "#1ed4bb"
                    :height 105
                    :weight 'normal
                    :width 'normal)



 (set-face-attribute 'font-lock-comment-face nil :foreground "#5B6268" :slant 'italic)
(set-face-attribute 'font-lock-function-name-face nil :foreground "#c678dd" :slant 'italic)
(set-face-attribute 'font-lock-variable-name-face nil :foreground "#dcaeea" :slant 'italic)   
(provide 'init-basica) 
