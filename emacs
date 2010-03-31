;; dotemacs.el
;; written by Paul Mantz
;; customization for the consummate Perl-programming polyglot

; Emacs server start
(server-start)

;; Add local lisp folder to load-path
(add-to-list 'load-path "~/elisp")

;; Basic configuration stuff
(global-font-lock-mode 1)
(setq fill-column 78)

;;answer with y or n instead of yes or no
(defalias 'yes-or-no-p 'y-or-n-p)

;;prints the full path to the minibuffer
(defun msg-buffer-filename() (interactive)
  (message (buffer-file-name)))

;; bind C-c C-l (think of as lookup) to rgrep
(global-set-key [(control ?c) (control ?l)] 'rgrep)

;; NOTE: this is going to get me in trouble.  quit it.
;; set +x on all files that begin with '#!'
;; (add-hook 'after-save-hook
;;           '(lambda ()
;;              (progn
;;                (and (save-excursion
;;                       (save-restriction
;;                         (widen)
;;                         (goto-char (point-min))
;;                         (save-match-data
;;                           (looking-at "^#!"))))
;;                     (shell-command (concat "chmod u+x "
;; 					   buffer-file-name))
;;                     (message (concat "Saved as script: "
;; 				     buffer-file-name))))))

; Uniquify: unique buffer names
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

;; C stuff.  Still trying to figure this out.
(setq-default c-basic-offset 4)
(setq c-default-style "k&r")

;; Stuff for finding tag files by recurring up the directory tree
(defun jds-find-tags-file ()
  "recursively searches each parent directory for a file named
`tags' and returns the path to that file or nil if a tags file is
not found. Returns nil if the buffer is not visiting a file"
  (labels
      ((find-tags-file-r (path)
                         (let* ((parent (file-name-directory path))
                                (possible-tags-file (concat parent "tags")))
                           (cond
                            ((file-exists-p possible-tags-file) (throw 'found-it possible-tags-file))
                            ((string= "/tags" possible-tags-file) (error "no tags file found"))
                            (t (find-tags-file-r (directory-file-name parent)))))))

    (if (buffer-file-name)
        (catch 'found-it
          (find-tags-file-r (buffer-file-name)))
      (error "buffer is not visiting a file"))))

(defun jds-set-tags-file-path ()
  "calls `jds-find-tags-file' to recursively search up the
directory tree to find a file named `tags'. If found, calls
`vtags-set-tags-file' with that path as an argument otherwise
raises an error."
  (interactive)
  (vtags-set-tagfile (jds-find-tags-file)))


;; PDE (Perl) Bindings
(add-to-list 'load-path "~/elisp/pde/lisp")
(load "pde-load")
(defalias 'perl-mode 'cperl-mode)

;; the following are more trouble than they're worth
(setq cperl-electric-keywords nil)
(setq cperl-auto-newline nil)

;; org-mode: productivity lists!  (bonus: see if you can plug bugzilla
;; into this bitch)
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-agenda-files (list "~/org/zmanda/amanda.org"
                             "~/org/zmanda/benefits.org"
                             "~/org/finances.org"
                             "~/org/emacs.org"
                             "~/org/home.org"
                             ))


;; Processing mode
;; (add-to-list 'load-path "/path/to/processing-emacs/") ;; don't need
(autoload 'processing-mode "processing-mode" "Processing mode" t)
(add-to-list 'auto-mode-alist '("\\.pde$" . processing-mode))
(setq processing-location "/opt/processing-1.0.3")

;; Python Mode
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
				   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)


;; ;; SLIME Mode (lisp, clisp)
;; (add-to-list 'load-path "~/elisp/slime/") ; your SLIME directory
;; (setq inferior-lisp-program "/usr/bin/clisp") ; your Lisp system
;; (require 'slime)
;; (slime-setup)

;; RPM Spec Mode
(autoload 'rpm-spec-mode "rpm-spec-mode.el" "RPM spec mode." t)
(setq auto-mode-alist (append '(("\\.spec" . rpm-spec-mode))
                              auto-mode-alist))

;; Relax NG Compact Mode
(autoload 'rnc-mode "rnc-mode")
(setq auto-mode-alist
      (cons '("\\.rnc\\'" . rnc-mode) auto-mode-alist))

;; Twitter Mode
(autoload 'twitter-get-friends-timeline "twitter" nil t)
(autoload 'twitter-status-edit "twitter" nil t)
(global-set-key "\C-xt" 'twitter-get-friends-timeline)
(add-hook 'twitter-status-edit-mode-hook 'longlines-mode)

;; VHDL Mode
(add-to-list 'load-path "~/elisp/vhdl-mode")

;; Git Mode
(add-to-list 'load-path "~/elisp/git")
(require 'git)
(autoload 'git-blame-mode "git-blame"
  "Minor mode for incremental blame for Git." t)

;; Gnus configuration
(add-to-list 'load-path "~/.gnus")

;; haskell stuff
(add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)
(require 'inf-haskell)
(setq haskell-program-name (executable-find "ghci"))


;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))
