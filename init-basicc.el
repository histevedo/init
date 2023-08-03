


;;disable theme background color in terminal
(defun on-after-init ()
    (unless (display-graphic-p (selected-frame))
          (set-face-background 'default "unspecified-bg" (selected-frame))))

(add-hook 'window-setup-hook 'on-after-init)

  (setq default-frame-alist '((width . 90)
                              (height . 50)
                              (alpha-background . 80)))
;;mouse 
(unless (display-graphic-p)
    (xterm-mouse-mode 1))

(setq inhibit-startup-message t)








(setq inhibit-startup-message t)




(provide 'init-basicc) 
