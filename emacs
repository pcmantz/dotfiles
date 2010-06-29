;; emacs
;; written by Paul Mantz
;;
;; Emacs customization for the consummate Perl-programming polyglot.
;; Written for Emacs 23+.

; Emacs server start
(server-start)

;;
;; useful functions
;;

;;
;; global configuration
;;

;; enable global syntax highlighting
(require 'font-lock)
(global-font-lock-mode t)

(defalias 'yes-or-no-p 'y-or-n-p)

;;prints the full path to the minibuffer
(defun msg-buffer-filename() (interactive)
  (message (buffer-file-name)))

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;; built-in package configuration

; uniquify: unique buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;; ibuffer: better buffer listings
(require 'ibuffer)
(setq ibuffer-default-sorting-mode 'major-mode)
(setq ibuffer-always-show-last-buffer t)
(setq ibuffer-view-ibuffer t)
(global-set-key (kbd "C-x C-b") 'ibuffer-other-window)

;; Whitespace Nuke
(autoload 'nuke-trailing-whitespace "whitespace" nil t)
(add-hook 'mail-send-hook 'nuke-trailing-whitespace)
;; (add-hook 'write-file-hooks 'nuke-trailing-whitespace)

;;; This was installed by package-install.el.  This provides support
;;; for the package system and interfacing with ELPA, the package
;;; archive.  Move this code earlier if you want to reference packages
;;; in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;; cc-mode
(setq-default c-basic-offset 4)
(setq c-default-style "k&r")

;; PDE (Perl) Bindings
(add-to-list 'load-path "~/.emacs.d/pde")
(load "pde-load")

;; CPerl configuration
(defalias 'perl-mode 'cperl-mode)
(setq cperl-electric-keywords nil)
(setq cperl-auto-newline nil)
(setq cperl-indent-parens-as-block t
      cperl-close-paren-offset -4)

;; org-mode: productivity lists!  (bonus: see if you can plug bugzilla
;; into this bitch)
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-agenda-files (list
                        "~/org/emacs.org"
                        "~/org/home.org"
                        ))

;; Add user lisp folders to load-path
(add-to-list 'load-path "~/elisp")
(add-to-list 'load-path "~/.emacs.d")
