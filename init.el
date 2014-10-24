(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(setq backup-directory-alist `(("." . "~/.saves")))

(defun require-package (package &optional min-version no-refresh)
  "Ask elpa to install given PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

;; Auto-install missing packages:
(require-package 'yasnippet)
(require-package 'auto-complete)
(require-package 'ac-dabbrev)
(require-package 'magit)
(require-package 'smartparens)
(require-package 'markdown-mode)
(require-package 'markdown-mode+)
(require-package 'scala-mode2)
(require-package 'lorem-ipsum)
(require-package 'go-mode)
(require-package 'go-snippets)
(require-package 'go-autocomplete)
(require-package 'go-direx)
(require-package 'go-eldoc)
(require-package 'go-errcheck)

;;; yasnippet
;;; should be loaded before auto complete so that they can work together
(require 'yasnippet)
(yas-global-mode 1)

;;; auto complete mod
;;; should be loaded after yasnippet so that they can work together
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(require 'auto-complete-config)
(ac-config-default)

;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

;;; JavaScript Setup
(setq js-indent-level 2)

;;; Go Setup
(add-hook 'before-save-hook 'gofmt-before-save)
