;; emacs
;; written by Paul Mantz
;;
;; Emacs customization for the consummate Perl-programming polyglot.
;; Written for Emacs 23+.

;; Emacs server start
(server-start)

;;
;; useful functions
;;

(defun msg-buffer-filename () (interactive)
  (message (buffer-file-name)))

(defun untabify-buffer () (interactive)
  (untabify (point-min) (point-max)))

;;
;; global configuration
;;

(require 'font-lock)
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq menu-bar-mode nil)
(setq tool-bar-mode nil)
(setq scroll-bar-mode nil)

(column-number-mode t)
(show-paren-mode t)
(transient-mark-mode t)

(setq-default fill-column 78)

;;
;; appearance for graphical mode
;;
(when window-system
  (set-foreground-color "white")
  (set-background-color "black")
  (set-cursor-color "green"))

;;
;; built-in package configuration
;;

;; uniquify: unique buffer names
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

;; cc-mode
(setq-default c-basic-offset 4)
(setq c-default-style "k&r")

;; cperl-mode
(require 'cperl-mode)
(add-to-list 'auto-mode-alist '("\\.t$" . cperl-mode))
(mapc
 (lambda (pair)
   (if (eq (cdr pair) 'perl-mode)
       (setcdr pair 'cperl-mode)))
 (append auto-mode-alist interpreter-mode-alist))

(setq cperl-electric-keywords nil)
(setq cperl-auto-newline nil)
(setq cperl-indent-parens-as-block  t
      cperl-tab-always-indent       t
      cperl-indent-level            4
      cperl-close-paren-offset     -4)

;; org-mode
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-agenda-files (list
                        "~/org/emacs.org"
                        "~/org/home.org"
                        ))

;;
;; Other user configuration paths
;;

;; Add user lisp folders to load-path
(add-to-list 'load-path "~/elisp")
(add-to-list 'load-path "~/.emacs.d")
