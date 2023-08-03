(use-package swiper
  ;; 快捷搜索
  :ensure nil
  :bind (("C-s" . swiper)))

(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
     ("C-x C-f" . counsel-find-file)
     ("C-c  t" . counsel-load-theme)
     ("C-c  b" . counsel-bookmark)
     ("C-c  r" . counsel-rg)
     ("C-c  f" . counsel-fzf)
     ("C-c  g" . counsel-git)))

(provide 'init-counsel) 
