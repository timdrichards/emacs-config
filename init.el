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

