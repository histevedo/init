


(use-package tex 
  :ensure auctex 
  :defer t) 

(load "auctex.el" nil t t)

;; AucTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(setq TeX-output-view-style (quote (("^pdf$" "." "zathura %o %(outpage)"))))

(add-hook 'LaTeX-mode-hook
(lambda()
(add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
(setq TeX-command-default "XeLaTeX")))
(setq LaTeX-item-indent 0)
 (provide 'init-auctex) 
