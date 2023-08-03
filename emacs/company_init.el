(use-package company
  :diminish company-mode
  :init (global-company-mode 1)) 
(require 'company)

(defun set-company-tab ()
  (define-key company-active-map [tab] 'company-select-next-if-tooltip-visible-or-complete-selection)
  (define-key company-active-map (kbd "TAB") 'company-select-next-if-tooltip-visible-or-complete-selection)
  (define-key company-active-map (kbd "TAB") 'company-select-next)
  )

(set-company-tab)

(define-key company-active-map (kbd "<backtab>") 'company-select-previous)
(define-key company-active-map (kbd "S-TAB") 'company-select-previous)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)
(setq company-show-numbers t)
(setq company-minimum-prefix-length 2)
(setq  company-tooltip-align-annotation t) 
(setq company-frontends
      '(company-pseudo-tooltip-unless-just-one-frontend
;;        company-preview-frontend
        company-echo-metadata-frontend))


(defun advice-only-show-tooltip-when-invoked (orig-fun command)
  "原始的 company-pseudo-tooltip-unless-just-one-frontend-with-delay, 它一直会显示
candidates tooltip, 除非只有一个候选结果时，此时，它会不显示, 这个 advice 则是让其
完全不显示, 但是同时仍旧保持 inline 提示, 类似于 auto-complete 当中, 设定
ac-auto-show-menu 为 nil 的情形, 这种模式比较适合在 yasnippet 正在 expanding 时使用。"
  (when (company-explicit-action-p)
    (apply orig-fun command)))

(defun advice-always-trigger-yas (orig-fun &rest command)
  (interactive)
  (unless (ignore-errors (yas-expand))
    (apply orig-fun command)))

(with-eval-after-load 'yasnippet
  (defun yas/disable-company-tooltip ()
    (interactive)
    (advice-add #'company-pseudo-tooltip-unless-just-one-frontend :around #'advice-only-show-tooltip-when-invoked)
    (define-key company-active-map [tab] 'yas-next-field-or-maybe-expand)
    (define-key company-active-map (kbd "TAB") 'yas-next-field-or-maybe-expand)
    )
  (defun yas/restore-company-tooltip ()
    (interactive)
    (advice-remove #'company-pseudo-tooltip-unless-just-one-frontend #'advice-only-show-tooltip-when-invoked)
    (set-company-tab)
    )
  (add-hook 'yas-before-expand-snippet-hook 'yas/disable-company-tooltip)
  (add-hook 'yas-after-exit-snippet-hook 'yas/restore-company-tooltip)

  ;; 这个可以确保，如果当前 key 是一个 snippet, 则一定展开 snippet,
  ;; 而忽略掉正常的 company 完成。
  (advice-add #'company-select-next-if-tooltip-visible-or-complete-selection :around #'advice-always-trigger-yas)
  (advice-add #'company-complete-common :around #'advice-always-trigger-yas)
  (advice-add #'company-complete-common-or-cycle :around #'advice-always-trigger-yas)
  )

(setq company-dabbrev-downcase nil)
(setq company-auto-commit t)
;; 32 空格, 41 右圆括号, 46 是 dot 字符
;; 这里我们移除空格，添加逗号(44), 分号(59)
;; 注意： C-x = 用来检测光标下字符的数字，(insert 数字) 用来测试数字对应的字符。
(setq company-auto-commit-chars '(41 46 44 59))
(add-hook 'after-init-hook 'global-company-mode)


(setq company-transformers '(company-sort-by-occurrence)) 
(setq company-backends
        '((company-files
	    company-dabbrev-code 
            company-semantic
            company-keywords
            company-yasnippet
	    company-abbrev 
	    company-wordfreq
	    company-gtags 
	    company-irony
	    company-clang
	    company-rtags
	    company-capf
           )))
;;; init-company.el ends here

;; Show quick tooltip
(use-package  company-posframe
  :ensure nil
  :init
  :diminish company-posframe-mode  
  :config
  (company-posframe-mode +1))

(use-package company-quickhelp
      :defines company-quickhelp-delay
      :bind (:map company-active-map
                  ("M-h" . company-quickhelp-manual-begin))
      :hook (global-company-mode . company-quickhelp-mode)
      :custom (company-quickhelp-delay -1.8))
(add-to-list 'company-backends 'company-c-headers)

;; Using digits to select company-mode candidates
(let ((map company-active-map))
  (mapc
   (lambda (x)
     (define-key map (format "%d" x) 'ora-company-number))
   (number-sequence 0 9))
  (define-key map " " (lambda ()
                        (interactive)
                        (company-abort)
                        (self-insert-command 1)))
  (define-key map (kbd "<return>") nil))

;;company number 
(defun ora-company-number ()
  "Forward to `company-complete-number'.

Unless the number is potentially part of the candidate.
In that case, insert the number."
  (interactive)
  (let* ((k (this-command-keys))
         (re (concat "^" company-prefix k)))
    (if (cl-find-if (lambda (s) (string-match re s))
                    company-candidates)
        (self-insert-command 1)
      (company-complete-number (string-to-number k)))))
(defun my-company-yasnippet-disable-inline (fun command &optional arg &rest _ignore)
      "Enable yasnippet but disable it inline."
      (if (eq command 'prefix)
          (when-let ((prefix (funcall fun 'prefix)))
            (unless (memq (char-before (- (point) (length prefix))) '(?. ?> ?\())
              prefix))
        (funcall fun command arg)))
(advice-add #'company-yasnippet :around #'my-company-yasnippet-disable-inline)

(require 'color)
(let ((bg (face-attribute 'default :background)))
  (custom-set-faces
    '(company-scrollbar-bg       ((t (:background "#000000"))))
    '(company-scrollbar-fg       ((t (:background "#555555"))))
    '(company-tooltip            ((t (:inherit default :background "#000000"))))
    '(company-tooltip-common     ((t (:inherit font-lock-constant-face))))
    '(company-tooltip-annotation ((t (:inherit font-lock-builtin-face))))
    '(company-tooltip-selection  ((t (:inherit highlight))))))
(provide 'company_init)

;;; company_init.el ends here
