;;; Code:
(require 'icomplete)

;; (setq icomplete-max-delay-chars 3)
(setq icomplete-delay-completions-threshold 2000)
(setq icomplete-compute-delay 0)
(setq icomplete-show-matches-on-no-input t)
(setq icomplete-hide-common-prefix nil)
(setq icomplete-in-buffer t)
(setq icomplete-tidy-shadowed-file-names t)
(setq icomplete-prospects-height 2)
;; (concat
;;                                      (propertize "\n" 'face '(:height 1))
;;                                      (propertize " " 'face '(:inherit vertical-border :underline t :height 1)
;;                                                  'display '(space :align-to right))
;;                                      (propertize "\n" 'face '(:height 1)))
(setq icomplete-separator (propertize " ☚ " 'face  '(foreground-color . "lightgreen")))

(setq completion-styles '(basic partial-completion substring initials  flex))

(when (require 'orderless nil t)
  (setq completion-styles '(basic partial-completion initials orderless))
  ;; 默认按空格开隔的每个关键字支持regexp/literal/initialism 3种算法
  (setq orderless-matching-styles '(orderless-regexp orderless-literal orderless-initialism ))
    ;; Recognizes the following patterns:
  ;; * ;flex flex;
  ;; * =literal literal=
  ;; * `initialism initialism`
  ;; * !without-literal without-literal!
  ;; * .ext (file extension)
  ;; * regexp$ (regexp matching at end)
  (defun vmacs-orderless-dispatch (pattern _index _total)
    (cond
     ;; Ensure that $ works with Consult commands, which add disambiguation suffixes
     ((string-suffix-p "$" pattern) `(orderless-regexp . ,(concat (substring pattern 0 -1) "[\x100000-\x10FFFD]*$")))
     ;; File extensions
     ((string-match-p "\\`\\.." pattern) `(orderless-regexp . ,(concat "\\." (substring pattern 1) "[\x100000-\x10FFFD]*$")))
     ;; Ignore single !
     ((string= "!" pattern) `(orderless-literal . ""))
     ;; Without literal
     ((string-prefix-p "!" pattern) `(orderless-without-literal . ,(substring pattern 1)))
     ((string-suffix-p "!" pattern) `(orderless-without-literal . ,(substring pattern 0 -1)))
     ((string-prefix-p "@" pattern) `(orderless-without-literal . ,(substring pattern 1)))
     ((string-suffix-p "@" pattern) `(orderless-without-literal . ,(substring pattern 0 -1)))
     ;; Initialism matching
     ((string-prefix-p "`" pattern) `(orderless-initialism . ,(substring pattern 1)))
     ((string-suffix-p "`" pattern) `(orderless-initialism . ,(substring pattern 0 -1)))
     ;; Literal matching
     ((string-prefix-p "=" pattern) `(orderless-literal . ,(substring pattern 1)))
     ((string-suffix-p "=" pattern) `(orderless-literal . ,(substring pattern 0 -1)))
     ((string-prefix-p "," pattern) `(orderless-literal . ,(substring pattern 1)))
     ((string-suffix-p "," pattern) `(orderless-literal . ,(substring pattern 0 -1)))
     ;; Flex matching
     ((string-prefix-p ";" pattern) `(orderless-flex . ,(substring pattern 1)))
     ((string-suffix-p ";" pattern) `(orderless-flex . ,(substring pattern 0 -1)))))
 (setq orderless-style-dispatchers '(vmacs-orderless-dispatch)))




;; (setq icomplete-scroll t)

(define-key icomplete-minibuffer-map (kbd "RET") 'icomplete-fido-ret)
(define-key icomplete-minibuffer-map (kbd "C-m") 'icomplete-fido-ret)
(define-key icomplete-minibuffer-map (kbd "C-n") #'icomplete-forward-completions)
(define-key icomplete-minibuffer-map (kbd "C-p") #'icomplete-backward-completions)
(define-key icomplete-minibuffer-map (kbd "C-s") #'icomplete-forward-completions)
(define-key icomplete-minibuffer-map (kbd "C-r") #'icomplete-backward-completions)
(define-key icomplete-minibuffer-map (kbd "C-.") 'next-history-element)
(define-key icomplete-minibuffer-map (kbd "C-l") #'icomplete-fido-backward-updir)
(define-key icomplete-minibuffer-map (kbd "C-e") #'(lambda(&optional argv)(interactive)(if (eolp) (call-interactively #'icomplete-fido-exit) (end-of-line))) )





(provide 'init-icomplete)

;; Local Variables:
;; coding: utf-8
;; End:

;;; conf-icomplete.el ends here.
