;;https://github.com/manateelazycat/lazycat-emacs/blob/8f3dee8a6fe724ec52cd2b17155cfc2cefc8066b/site-lisp/config/init-company-mode.el
(add-to-list 'company-backends 'company-c-headers)
(add-hook 'prog-mode-hook
          #'(lambda ()
              (require 'lazy-load)
              (require 'company)
              (require 'company-yasnippet)
              (require 'company-dabbrev)
              (require 'company-files)
              (require 'company-tng)
              (require 'company-tabnine)

              ;; Config for company mode.
              (setq company-minimum-prefix-length 1) ; pop up a completion menu by tapping a character
              (setq company-show-numbers t) ; number the candidates (use M-1, M-2 etc to select completions).
              (setq company-require-match nil) ; allow input string that do not match candidate words
              (setq company-idle-delay 0) ; trigger completion immediately.

              ;; Don't downcase the returned candidates.
              (setq company-dabbrev-downcase nil)
              (setq company-dabbrev-ignore-case t)

              ;; Customize company backends.
              (setq company-backends
                    '(
                      (company-tabnine company-dabbrev company-keywords company-files company-capf)
                      ))

              ;; Add yasnippet support for all company backends.
              (defvar company-mode/enable-yas t
                "Enable yasnippet for all backends.")

              (defun company-mode/backend-with-yas (backend)
                (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
                    backend
                  (append (if (consp backend) backend (list backend))
                          '(:with company-yasnippet))))

              (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

              ;; Add `company-elisp' backend for elisp.
              (add-hook 'emacs-lisp-mode-hook
                        #'(lambda ()
                            (require 'company-elisp)
                            (push 'company-elisp company-backends)))

              ;; Enable global.
              (global-company-mode)

              ;; Key settings.
              (lazy-load-unset-keys
               '("TAB")
               company-mode-map)        ;unset default keys

              (lazy-load-unset-keys
               '("M-p" "M-n" "C-m")
               company-active-map)

              (lazy-load-set-keys
               '(
                 ("TAB" . company-complete-selection)
                 ("M-h" . company-complete-selection)
                 ("M-H" . company-complete-common)
                 ("M-w" . company-show-location)
                 ("M-s" . company-search-candidates)
                 ("M-S" . company-filter-candidates)
                 ("M-n" . company-select-next)
                 ("M-p" . company-select-previous)
                 ("M-i" . yas-expand)
                 )
               company-active-map)
              ))

;; The free version of TabNine is good enough,
;; and below code is recommended that TabNine not always
;; prompt me to purchase a paid version in a large project.
(defadvice company-echo-show (around disable-tabnine-upgrade-message activate)
  (let ((company-message-func (ad-get-arg 0)))
    (when (and company-message-func
               (stringp (funcall company-message-func)))
      (unless (string-match "The free version of TabNine only indexes up to" (funcall company-message-func))
        ad-do-it))))

(provide 'init-company3)

;;; init-company-mode.el ends here
