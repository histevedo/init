
;;https://tam5917.hatenablog.com/entry/2022/01/24/113009
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'c-mode-common-hook 'company-mode) 
(setq company-minimum-prefix-length 2)

;; キー設定
(define-key company-active-map (kbd "TAB") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "M-n") nil)
(define-key company-active-map (kbd "M-p") nil)
(define-key company-active-map (kbd "C-m") 'company-complete-selection)

(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "M-n") nil)
(define-key company-search-map (kbd "M-p") nil)


;; 候補に番号を付け、
;; M-1やM-2などM-をつけて押すことで候補選択をショートカットできる
(setq company-show-numbers t)

;; 候補の一番下でさらに下に行こうとすると一番上に戻る
(setq company-selection-wrap-around t)

;; ツールチップ上の候補を右揃え
(setq company-tooltip-align-annotations t)

;; 参考 https://qiita.com/zk_phi/items/9dc373e734d20cd31641
;; シンボルの途中部分を補完する
;; → company にはこの挙動が実装されておらず、カーソルの直後に (空白以外
;; の) 文字がある場合は補完が始まらないため

;; 参考 https://qiita.com/zk_phi/items/9dc373e734d20cd31641
;; company-require-match
;; - never: 補完候補の選択を開始後、補完候補にない文字も打てる
(setq company-require-match 'never)

;; 参考 https://qiita.com/zk_phi/items/9dc373e734d20cd31641
;; 『これは「現在編集中のバッファ、またはそのバッファと同じメジャーモー
;; ドになっているバッファ」から補完候補を探してきてくれるものです。』
(setq company-backends
      `(
        company-capf
        company-dabbrev
        company-semantic
        company-cmake
        company-clang
        company-files
        company-keywords
        company-yasnippet 

        ;; https://qiita.com/zk_phi/items/9dc373e734d20cd31641
        ;; 「組み込みのキーワードも words-in-same-mode-buffers
        ;; の候補もみんないっしょくたに出てくる」
        ;; (company-keywords :with company-same-mode-buffers)

        (company-dabbrev-code company-gtags company-etags
                              company-keywords)
        company-oddmuse
        company-bbdb
        ,@(unless (version< "24.3.51" emacs-version)
            (list 'company-elisp))
        ,@(unless (version<= "26" emacs-version)
            (list 'company-nxml))
        ,@(unless (version<= "26" emacs-version)
            (list 'company-css))
        ))
(push 'company-same-mode-buffers company-backends) ;先頭に追加

;; lowercaseのみで補完されるのを抑制する(case sensitive)
(eval-when-compile (require 'company-dabbrev))
(setq company-dabbrev-downcase nil)

;; 参考 https://shwaka.github.io/2017/05/03/company-dabbrev-japanese.html
;; company-dabbrevで日本語文字が補完候補に含まれないようにする
(defun edit-category-table-for-company-dabbrev (&optional table)
  (define-category ?s "word constituents for company-dabbrev" table)
  (let ((i 0))
    (while (< i 128)
      (if (equal ?w (char-syntax i))
          (modify-category-entry i ?s table)
        (modify-category-entry i ?s table t))
      (setq i (1+ i)))))
(edit-category-table-for-company-dabbrev)
(setq company-dabbrev-char-regexp "\\cs")

;; company-same-mode-buffers.elにおいて "\\sw"が使用されている箇所を "\\cs"に変更する
;; →日本語文字が補完候補に含まれることを抑制する効果
(defun company-same-mode-buffers-query-construct-any-followed-by (str)
  (cons "\\(?:\\cs\\|\\s_\\)*?" (regexp-quote str)))
(defun company-same-mode-buffers-query-construct-any-word-followed-by (str)
  (cons "\\cs*?" (regexp-quote str)))
(defun company-same-mode-buffers-query-to-regex (lst)
  "Make a regex from a query (list of `query-construct-*' s)."
  (concat "\\_<"
          (mapconcat (lambda (pair) (concat (car pair) "\\(" (cdr pair) "\\)")) lst "")
          "\\(?:\\s_\\|\\cs\\)*"))
(defun company-same-mode-buffers-update-cache (&optional buffer)
  "Put all symbols in the buffer into
`company-same-mode-buffers-cache'."
  (with-current-buffer (or buffer (current-buffer))
    (when (and company-same-mode-buffers-cache-is-dirty
               (derived-mode-p 'prog-mode))
      (let ((tree (gethash major-mode company-same-mode-buffers-cache))
            (symbols (company-same-mode-buffers-search-current-buffer
                      (concat "\\(:?+\\cs\\|\\s_\\)\\{"
                              (number-to-string company-same-mode-buffers-minimum-word-length)
                              ","
                              (number-to-string company-same-mode-buffers-maximum-word-length)
                              "\\}"))))
        (dolist (s symbols)
          (setq tree (company-same-mode-buffers-tree-insert tree s)))
        (puthash major-mode tree company-same-mode-buffers-cache)
        (setq company-same-mode-buffers-cache-is-dirty nil)))))

;; 参考 https://qiita.com/sune2/items/b73037f9e85962f5afb7#company-transformers
;; 補完候補のソート。nilが辞書順
;; (setq company-transformers
;;       '(company-sort-by-occurrence company-sort-by-backend-importance))

;; prescientのアルゴリズム
;; - 直近の選択を上位に移すソーティング
;; - 直近の選択を履歴として保存する
;; →company-transformersに prescient由来のものを追加

;; wordfreq -> MELPAからダウンロード
;; 専用の単語辞書をダウンロード
;; M-x company-wordfreq-download-list
(add-hook 'text-mode-hook (lambda ()
                            (setq-local company-backends
                                        '(company-wordfreq
                                          company-dabbrev
                                          company-capf))
                            (setq-local company-transformers nil)))

;; irony C/C++
(setq company-backends (append company-backends '(company-irony-c-headers)))
(setq company-backends (append company-backends '(company-irony)))
(setq company-backends (append company-backends '(company-reftex-labels)))
(setq company-backends (append company-backends '(company-reftex-citations)))


(provide 'init-company2) 
;;; init-company.el ends here

