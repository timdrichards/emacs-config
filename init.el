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

; flymake-jslint/jshint setup.
; see the documentation of the package via the package manager.
;(require 'flymake-jslint)
;(add-hook 'js-mode-hook 'flymake-jslint-load)

(require 'flymake-jshint)
(setq jshint-configuration-path "~/.emacs.d/jshint-config.json")
(add-hook 'js-mode-hook 'flymake-jshint-load)


; org-mode
; setup the agenda files:
(setq org-agenda-files (list "~/Dropbox/org/upc/upc.org"
			     "~/Dropbox/org/230/"
			     "~/Dropbox/org/326/"
			     "~/Dropbox/org/recs/"))
; setup keys:
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

; indentation
(global-set-key (kbd "RET") 'newline-and-indent)

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/Dropbox/org/230/230.org" "~/Dropbox/org/upc/upc.org"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
