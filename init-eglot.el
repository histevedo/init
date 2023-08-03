
(use-package eglot
  :ensure t
  :bind (:map eglot-mode-map
              ("C-c l a" . eglot-code-actions)
              ("C-c l r" . eglot-rename)
              ("C-c l f" . eglot-format)
              ("C-c l d" . eldoc))
  :custom 
  (customize-set-variable 'eglot-autoshutdown t)
  (customize-set-variable 'eglot-extend-to-xref t)
  (customize-set-variable 'eglot-ignored-server-capabilities
  (quote (:documentFormattingProvider :documentRangeFormattingProvider)))
  (with-eval-after-load 'eglot
  (setq completion-category-defaults nil)
  (add-to-list 'eglot-server-programs
    '(c-mode c++-mode
	 . ("clangd"
	       "-j=4"
	       "--malloc-trim"
	       "--log=error"
	       "--background-index"
	       "--clang-tidy"
	       "--cross-file-rename"
	       "--completion-style=detailed"
	       "--pch-storage=memory"
	       "--header-insertion=never"
	       "--header-insertion-decorators=0"))))
  :config
  (add-hook 'c-mode-hook 'company-mode)
  (add-hook 'c++-mode-hook 'company-mode)
  (add-hook 'python-mode-hook 'company-mode)
  (add-to-list 'eglot-server-programs '(c mode c++-mode . ("clangd13")))
  (add-to-list 'eglot-server-programs '(python-mode . ("pylsp")))
  (add-hook 'c-mode-hook 'eglot-ensure) 
  (add-hook 'c++-mode-hook 'eglot-ensure)
  (add-hook 'python-mode-hook 'eglot-enure))
(provide 'init-eglot) 
