;; -*- mode: Emacs-Lisp -*-
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

(menu-bar-mode nil)
(tool-bar-mode nil)
(scroll-bar-mode nil)

(column-number-mode t)
(show-paren-mode t)
(transient-mark-mode t)

(setq-default fill-column 78)

;; use these variables in other modes to control tabbing
(setq-default indent-tabs-mode nil)
(setq tab-width 4)

(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;;keybindings for common functions
(define-key global-map (kbd "C-z") nil)   ;; don't accidentally stop emacs
(define-key global-map (kbd "C-x r") 'revert-buffer)

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
(setq c-basic-offset tab-width)
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
(setq cperl-indent-parens-as-block t
      cperl-indent-level           tab-width
      cperl-close-paren-offset     (- tab-width))

;; org-mode
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(eval-after-load "org"
  '(progn
     (define-prefix-command 'org-todo-state-map)
     
     (define-key org-mode-map "\C-cx" 'org-todo-state-map)
     
     (define-key org-todo-state-map "x"
       #'(lambda nil (interactive) (org-todo "CANCELLED")))
     (define-key org-todo-state-map "d"
       #'(lambda nil (interactive) (org-todo "DONE")))
     (define-key org-todo-state-map "f"
       #'(lambda nil (interactive) (org-todo "DEFERRED")))
     (define-key org-todo-state-map "l"
       #'(lambda nil (interactive) (org-todo "DELEGATED")))
     (define-key org-todo-state-map "s"
       #'(lambda nil (interactive) (org-todo "STARTED")))
     (define-key org-todo-state-map "w"
       #'(lambda nil (interactive) (org-todo "WAITING")))))

(eval-after-load "org-agenda"
  '(progn
     (define-key org-agenda-mode-map "\C-n" 'next-line)
     (define-key org-agenda-keymap "\C-n" 'next-line)
     (define-key org-agenda-mode-map "\C-p" 'previous-line)
     (define-key org-agenda-keymap "\C-p" 'previous-line)))

;; remember mode.  makes entering org mode stuff easier
(require 'remember)

(add-hook 'remember-mode-hook 'org-remember-apply-template)
(define-key global-map [(control meta ?r)] 'remember)

(custom-set-variables
 '(org-agenda-files (quote ("~/org/todo.org")))
 '(org-agenda-include-diary t)
 '(org-default-notes-file "~/org/notes.org")
 '(org-agenda-ndays 14)
 '(org-deadline-warning-days 14)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-start-on-weekday nil)
 '(org-reverse-note-order t)
 '(org-fast-tag-selection-single-key (quote expert))
 '(org-agenda-custom-commands
   (quote (("d" todo "DELEGATED" nil)
           ("c" todo "DONE|DEFERRED|CANCELLED" nil)
           ("w" todo "WAITING" nil)
           ("W" agenda "" ((org-agenda-ndays 21)))
           ("A" agenda ""
            ((org-agenda-skip-function
              (lambda nil
                (org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]")))
             (org-agenda-ndays 1)
             (org-agenda-overriding-header "Today's Priority #A tasks: ")))
           ("u" alltodo ""
            ((org-agenda-skip-function
              (lambda nil
                (org-agenda-skip-entry-if (quote scheduled) (quote deadline)
                                          (quote regexp) "<[^>\n]+>")))
             (org-agenda-overriding-header "Unscheduled TODO entries: "))))))
 '(org-remember-store-without-prompt t)
 '(org-remember-templates
   '(("Todo" ?t "* TODO %?\n  %u" "~/org/todo.org"  "Tasks")
     ("Note" ?n "* %u %?"         "~/org/notes.org" "Notes")))
 '(remember-annotation-functions (quote (org-remember-annotation)))
 '(remember-handler-functions (quote (org-remember-handler))))

;;
;; include additional libraries
;;

;; add ELPA or other program-added packages to the load path
(add-to-list 'load-path "~/.emacs.d")

;; include all the subdirectories found in ~/elisp
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "~/elisp/")
           (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)
      (byte-recompile-directory my-lisp-dir 0)))

;; initialize all the packages in the elisp directory
(if (file-exists-p "~/elisp/init.el")
    (load-file "~/elisp/init.el"))
