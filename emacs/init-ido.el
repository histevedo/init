
(ido-mode t)  ; use 'buffer rather than t to use only buffer switching
(ido-everywhere 1)
(ido-vertical-mode 1) 
(require 'ido-completing-read+)
(require 'flx-ido)
(setq ido-enable-flex-matching t)
(setq ido-use-virtual-buffers t)
(setq ido-create-new-buffer 'always)
(setq ido-auto-merge-work-directories-length nil) 
(setq ido-use-filename-at-point 'guess) 
;; use current pane for newly opened file
(setq ido-default-file-method 'selected-window)

(setq ido-file-extensions-order
      '(".org" ".txt" ".pm" ".pl" ".clj" ".emacs" ".xml" ".el"))

;;; Allow spaces when using ido-find-file
(add-hook 'ido-make-file-list-hook
         (lambda ()
            (define-key ido-file-dir-completion-map (kbd "SPC") 'self-insert-command)))


;; Allow the same buffer to be open in different frames
(setq ido-default-buffer-method 'selected-window)


(provide 'init-ido)
