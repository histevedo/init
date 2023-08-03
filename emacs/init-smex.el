
; Enhance M-x to allow easier execution of commands
(use-package smex
  :ensure t
  ;; Using counsel-M-x for now. Remove this permanently if counsel-M-x works better.
  :disabled t
  :config
  (setq smex-save-file (concat user-emacs-directory ".smex-items"))
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
 (smex-initialize)
 :bind ("M-x" . smex))


;;Hyphen on Space

(defadvice smex (around space-inserts-hyphen activate compile)
(let ((ido-cannot-complete-command 
       `(lambda ()
	  (interactive)
	  (if (string= " " (this-command-keys))
	      (insert ?-)
	    (funcall ,ido-cannot-complete-command)))))
  ad-do-it))

  (provide 'init-smex)
  ;;; init-smex.el ends here
