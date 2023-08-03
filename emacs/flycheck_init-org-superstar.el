


(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
 (setq org-superstar-headline-bullets-list '(?\s))
;; Set different bullets, with one getting a terminal fallback.
(setq org-superstar-headline-bullets-list
      '("◉" ("🞛" ?◈) "○" "▷"))
;; Stop cycling bullets to emphasize hierarchy of headlines.
(setq org-superstar-cycle-headline-bullets nil)
;; Hide away leading stars on terminal.
(setq org-superstar-leading-fallback ?\s)

;; This is usually the default, but keep in mind it must be nil
(setq org-hide-leading-stars nil)
;; This line is necessary.
(setq org-superstar-leading-bullet ?\s)
;; If you use Org Indent you also need to add this, otherwise the
;; above has no effect while Indent is enabled.
(setq org-indent-mode-turns-on-hiding-stars nil)
(provide 'init-org-superstar) 
