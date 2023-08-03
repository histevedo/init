(add-hook 'c-mode-hook 'rtags-start-process-unless-running)
(add-hook 'c++-mode-hook 'rtags-start-process-unless-running)

(use-package rtags
  :ensure t
  :hook (c++-mode . rtags-start-process-unless-running)
  mpany-rtags company-backends)
  :config (setq rtags-completions-enabled t
		rtags-path "/home/cck1/.emacs.d/elpa-28.2/rtages-20220818.1535/rtags.el"
		rtags-rc-binary-name "/home/cck1/rtags/bin/rc"
		rtags-rdm-binary-name "/home/cck1/rtags/bin/rdm")
(use-package company-irony
	     :ensure t
	     :config
	     (add-to-list (make-local-variable 'company-backends)
			  '(company-irony company-irony-c-headers)))
(use-package flycheck-irony
	     :ensure t
	     :config
	     (add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
(use-package irony-eldoc
	     :ensure t
	     :config
	     (add-hook 'irony-mode-hook #'irony-eldoc))



(setq rtags-autostart-diagnostics t)
(rtags-diagnostics)
(setq rtags-completions-enabled t)
(push 'company-rtags company-backends)
(global-company-mode)
(provide  'init-rtags) 
