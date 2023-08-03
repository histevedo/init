;;; init-projectile.el --- Use Projectile for navigation within projects -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(use-package projectile
  :diminish projectile-mode)

(when (maybe-require-package 'projectile)
  (add-hook 'after-init-hook 'projectile-mode)

  ;; Shorter modeline
  (setq-default projectile-mode-line-prefix " Proj")

  (when (executable-find "rg")
    (setq-default projectile-generic-command "rg --files --hidden"))

  (with-eval-after-load 'projectile
    (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))
    (projectile-mode +1)

    (setq projectile-completion-system 'default)
    (maybe-require-package 'ibuffer-projectile))

(setq projectile-completion-system 'default) 
;;using empty projectile file 
(setq projectile-indexing-method 'native)
(provide 'init-projectile)
;;; init-projectile.el ends here
