; add the .emacs.d directory if we are in version 23. We
; have a version 23 compatible package.el in that directory 
; to support package management for emacs <= 23.
(if (= 23 emacs-major-version)
    (add-to-list 'load-path "~/.emacs.d"))

; formatting options
(setq js-indent-level 2) ; javascript indents

; melpa package support
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

; disable backup files
(setq make-backup-files nil)

; markdown-mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

; auto-complete-mode
(require 'auto-complete-config)
(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))
(global-auto-complete-mode t)
(setq ac-auto-start 2)
(setq ac-ignore-case nil)

; js-comint support
(require 'js-comint)
(setq inferior-js-program-command "node")
(setq inferior-js-mode-hook
      (lambda ()
        ;; We like nice colors
        (ansi-color-for-comint-mode-on)
        ;; Deal with some prompt nonsense
        (add-to-list 'comint-preoutput-filter-functions
                     (lambda (output)
                       (replace-regexp-in-string ".*1G\.\.\..*5G" "..."
                     (replace-regexp-in-string ".*1G.*3G" "&gt;" output))))))

; hooks
; org-mode auto-fill on
(add-hook 'org-mode-hook 'turn-on-auto-fill) 
; automatically fill comments in programming modes:
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (auto-fill-mode 1)
	    (set (make-local-variable 'fill-nobreak-predicate)
		 (lambda ()
		   (not (eq (get-text-property (point) 'face)
			    'font-lock-comment-face))))))

; key bindings
(global-set-key (kbd "C-c q") 'auto-fill-mode)
