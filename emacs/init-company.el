;;; init-company.el --- Completion with company -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; WAITING: haskell-mode sets tags-table-list globally, breaks tags-completion-at-point-function
;; TODO Default sort order should place [a-z] before punctuation

(use-package company-irony-c-headers
	       :after irony)

(use-package company-irony
	       :after (irony company-irony-c-headers)
	         :config
		   (add-to-list 'company-backends '(company-irony-c-headers company-irony))
 		    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))
(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

  (add-hook 'after-init-hook 'global-company-mode)
  (add-hook 'c-mode-common-hook 'company-mode)
  (with-eval-after-load 'company
    (diminish 'company-mode)
    (define-key company-mode-map (kbd "M-/") 'Company-complete)
    (define-key company-mode-map [remap completion-at-point] 'company-complete)
    (define-key company-mode-map [remap indent-for-tab-command] 'company-indent-or-complete-common)
    (define-key company-active-map (kbd "M-/") 'company-other-backend)
    (define-key company-active-map (kbd "TAB") 'company-select-next)
    
    (define-key company-active-map (kbd "C-p") 'company-select-previous)
    (define-key company-active-map (kbd "C-d") 'company-show-doc-buffer)
    (define-key company-active-map (kbd "M-.") 'company-show-location)
    (setq-default company-dabbrev-other-buffers 'all
                  company-tooltip-align-annotations t))
  (global-set-key (kbd "M-C-/") 'company-complete)
  (setq company-dabbrev-downcase nil)
  (setq company-show-numbers t)
  (setq company-minimum-prefix-length 2)
  ;;sort choice by  frequency 
  (setq company-transformers '(company-sort-by-occurrence)) 
  (setq company-backends
        '((company-files
	    company-dabbrev
            company-semantic
            company-keywords
            company-yasnippet
	    company-wordfreq
	    company-gtags 
	    company-capf
           )
          (company-abbrev company-dabbrev)))
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


(provide 'init-company)
;;; init-company.el ends here

