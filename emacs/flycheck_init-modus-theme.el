




(use-package modus-theme 
  :ensure
  :init
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs t
        modus-themes-region '(bg-only no-extend))
  ;; Load the theme files before enabling a them
  (modus-themes-load-themes)
  (modus-themes-load-vivendi))

(provide 'init-modus-theme) 
