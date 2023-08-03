



;; Or if you have use-package installed
(use-package kaolin-themes
  :config
  (load-theme 'kaolin-aurora t)
  (kaolin-treemacs-theme))

;; The following set to t by default                               
(setq kaolin-themes-bold t       ; If nil, disable the bold style.        
      kaolin-themes-italic t     ; If nil, disable the italic style.      
      kaolin-themes-underline t) ; If nil, disable the underline style.

;; If you want to disable mode-line border, set kaolin-themes-modeline-border to nil
(setq kaolin-themes-modeline-border nil)
   
;; If you want to use flat underline style instead of wave 
;; set kaolin-themes-underline-wave to nil
(setq kaolin-themes-underline-wave nil)

;; If you want to use the same color for comments and metadata keys 
;; (e.g. for org-mode tags such as #+TITLE, #+STARTUP and etc)
;; you can disable kaolin-themes-distinct-metakeys.
(setq kaolin-themes-distinct-metakeys nil) 

(provide 'init-kaolin-themes) 
