(use-package yasnippet
	     :ensure t
	     :config
	     (setq yas-snippet-dirs '("~/.emacs.d/snippets"
				      "~/.emacs.d/snippets-master"))

	     :diminish yas-minor-mode
	     :init (yas-global-mode)
	     :config

	     (setq yas-prompt-functions '(yas-x-prompt yas-dropdown-prompt)))

(use-package yasnippet-snippets
	     :ensure t
	     :after yasnippet)
(provide 'init-yasnippet)
