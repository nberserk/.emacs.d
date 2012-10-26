;; hide toolbar/scrollbar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq inhibit-startup-message t)

;; proxy setting
(setq need-proxy (not (equal (getenv "COMPUTERNAME") "DARREN-HOME")))
(when need-proxy (setq url-proxy-services '( ("http" . "168.219.61.252:8080"))))

;; titlebar
(setq frame-title-format '("emacs - " buffer-file-name))
;; (setq frame-title-format '(buffer-name "%f" ("%b")))

;; Set path to .emacs.d
(setq dotfiles-dir (file-name-directory
		    (or (buffer-file-name) load-file-name)))

;; Set path to dependencies
(setq site-lisp-dir (expand-file-name "site-lisp" dotfiles-dir))

;; Set up load path
(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path site-lisp-dir)

;; Add external projects to load path
(dolist (project (directory-files site-lisp-dir t "\\w+"))
    (when (file-directory-p project)
          (add-to-list 'load-path project)))

;; darren variable
;;(setq darren-site-lisp (replace-regexp-in-string "bin" "site-lisp" invocation-directory))

; backup
(setq make-backup-files nil) ; stop creating those backup~ files 
(setq auto-save-default nil) ; stop creating those #auto-save# files
;; (setq backup-directory-alist `(("" . "~/.emacs.d/backup/")))

;; auto indent
(define-key global-map (kbd "RET") 'newline-and-indent)

;; package
(require 'setup-package)

;; Install extensions if they're missing
(defun init--install-packages ()
  (packages-install
;   (cons 'exec-path-from-shell melpa)
   (cons 'magit melpa)
   (cons 'yasnippet melpa)
   (cons 'ace-jump-mode melpa)
   (cons 'jump-char melpa)
   (cons 'expand-region melpa)
   (cons 'wgrep melpa)
   (cons 'mark-multiple melpa)
   (cons 'multiple-cursors melpa)
;   (cons 'paredit melpa)
      ))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" dotfiles-dir))

;; auto pair
;; (electric-pair-mode)

;; powershell-mode
(autoload 'powershell-mode "powershell-mode" "A editing mode for Microsoft PowerShell." t)
(add-to-list 'auto-mode-alist '("\\.ps1\\'" . powershell-mode)) ; PowerShell script

;;yasnippet from http://xahlee.org/emacs/emacs_templates.html
(require 'setup-yasnippet) ;; not yasnippet-bundle
;; Develop in ~/emacs.d/snippets, but also
;; include snippets that come with yasnippet
;;(setq yas/root-directory `(,(expand-file-name "snippets" dotfiles-dir)))
;;			   ,(expand-file-name "yasnippet/snippets" site-lisp-dir)))
;;(mapc 'yas/load-directory yas/root-directory)
(yas/global-mode 1)

;; show column number
(setq column-number-mode t)

;; ;; winner mode
;; (when (fboundp 'winner-mode) (winner-mode 1))

(global-set-key (kbd "<f5>"    ) 'revert-buffer)

;; (defun p4-edit ()
;;   "edit thisfile from depot, revert buffer to unlock readonly state"
;;   (interactive)
;;   (call-process "p4.exe"  nil "*p4*" nil "-d" default-directory "edit" (buffer-file-name))
;;   (revert-buffer nil t))

;; ;; ;; auto-complete
;; ;; (require 'auto-complete-config)
;; ;; (add-to-list 'ac-dictionary-directories "d:/Dropbox/emacs-23.2/site-lisp//ac-dict")
;; ;; (ac-config-default)


;; ;; p4
;; ;;(load-library "p4")
;; ;; elscreen
;; ;; http://emacs-fu.blogspot.com/2009/07/keeping-related-buffers-together-with.html
;;  ;; (add-to-list 'load-path "d:/Dropbox/emacs-23.2/site-lisp/apel")
;;  ;; (load "elscreen" "ElScreen" ) 
;;  ;; ;; F9 creates a new elscreen, shift-F9 kills it
;;  ;; (global-set-key (kbd "<f9>"    ) 'elscreen-create)
;;  ;; (global-set-key (kbd "S-<f9>"  ) 'elscreen-kill)  

;;  ;; ;; Windowskey+PgUP/PgDown switches between elscreens
;;  ;; (global-set-key (kbd "<C-prior>") 'elscreen-previous) 
;;  ;; (global-set-key (kbd "<C-next>")  'elscreen-next) 

;; ; autosave each bookmark change
;; ; http://emacs-fu.blogspot.com/2009/11/bookmarks.html
;; (setq bookmark-save-flag 1)				

;; ; auto-fill
;; ;(setq fill-column 100)
;; (add-hook 'text-mode-hook
;; 		  (lambda () (auto-fill-mode 1)
;; 			(setq fill-column 100)))

; tab
(setq-default tab-width 4)
;(setq c-basic-offset 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 48 56 64 72))
;; i wonder below line is necessary. not enough tab-width ?
(add-hook 'cmake-mode-hook 
  (lambda () 
	(setq cmake-tab-width 4)))

;; ;; highlighting TODO FIXME ...
;; ;; http://emacs-fu.blogspot.com/2008/12/highlighting-todo-fixme-and-friends.html
;; (add-hook 'c-mode-common-hook
;; 	(lambda ()
;; 	  (font-lock-add-keywords nil
;; 	  '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))))


(global-set-key [(control f4)] 'kill-this-buffer)

;; (savehist-mode t)
(defalias 'yes-or-no-p 'y-or-n-p)

;; ;; autoload powershell interactive shell
;; (autoload 'powershell "powershell" "interactive shell of PowerShell." t)
;; ;; cmake-mode
;; (autoload 'cmake-mode "cmake-mode" "CMake Mode." t)
;; (add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-mode))
;; (add-to-list 'auto-mode-alist '("\\.cmake\\'" . cmake-mode))

;; ;; nsis mode
;; (autoload 'nsis-mode "nsis-mode" "NSIS mode" t)
;; (add-to-list 'auto-mode-alist '("\\.\\([Nn][Ss][Ii]\\)$" . nsis-mode))

;; ;; dos-mode
;; (autoload 'dos-mode "dos-mode" "A editing mode for Dos." t)
;; (add-to-list 'auto-mode-alist '("\\.bat\\'" . dos-mode))
;; (add-to-list 'auto-mode-alist '("\\.cmd\\'" . dos-mode))

;; org
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sh . true) (python . true)))
;; (setq org-log-done 'time)
;; (add-hook 'org-mode-hook 
;;   (lambda () 
;; 	(setq org-hide-leading-stars t)
;; 	(setq org-indent-mode t)))

;; ;; window navigation helper key
;; (global-set-key (kbd "C-x <up>") 'windmove-up) 
;; (global-set-key (kbd "C-x <down>") 'windmove-down) 
;; (global-set-key (kbd "C-x <right>") 'windmove-right) 
;; (global-set-key (kbd "C-x <left>") 'windmove-left)

;; ido makes competing buffers and finding files easier
;; http://www.emacswiki.org/cgi-bin/wiki/InteractivelyDoThings
(setq 
  ido-save-directory-list-file "~/.emacs.d/ido.last"

  ido-ignore-buffers ;; ignore these guys
 '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "^\*trace"
     "^\*compilation" "^\*GTAGS" "^session\.*" "^\*")
;;  ido-work-directory-list '("/WSs/OspdScripts/")
  ido-case-fold  t                 ; be case-insensitive

  ido-enable-last-directory-history t ; remember last used dirs
  ido-max-work-directory-list 30   ; should be enough
  ido-max-work-file-list      50   ; remember many
  ido-use-filename-at-point 'guess
  ;; ido-use-url-at-point nil         ; don't use url at point (annoying)
  ido-everywhere t				   ; ??
  ido-enable-flex-matching t     ; don't try to be too smart
  ido-max-prospects 15              ; don't spam my minibuffer
  ido-confirm-unique-completion t) ; wait for RET, even with unique completion
;; Display ido results vertically, rather than horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-trucation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)
;; when using ido, the confirmation is rather annoying...
(setq confirm-nonexistent-file-or-buffer nil)
(ido-mode 1) ;; for buffers and files

;; recentf
;; get rid of `find-file-read-only' and replace it with something
;; more useful.
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)
;; enable recent files mode.
(recentf-mode t)
(setq recentf-max-saved-items 50)		; 50 files ought to be enough.

(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

;; ;; abbrev
;; ;; stop asking whether to save newly added abbrev when quitting emacs
;; (setq save-abbrevs nil)
;; (setq abbrev-file-name "d:/Dropbox/emacs-23.2/site-lisp/abbrev_defs.el")
;; ;; always on
;; (setq default-abbrev-mode t)

;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (c-set-style "stroustrup")))

;; smart scan start
;; from http://www.masteringemacs.org/articles/2011/01/14/effective-editing-movement/
(defvar smart-use-extended-syntax nil
  "If t the smart symbol functionality will consider extended
syntax in finding matches, if such matches exist.")
 
(defvar smart-last-symbol-name ""
  "Contains the current symbol name.
 
This is only refreshed when `last-command' does not contain
either `smart-symbol-go-forward' or `smart-symbol-go-backward'")
 
(make-local-variable 'smart-use-extended-syntax)
 
(defvar smart-symbol-old-pt nil
  "Contains the location of the old point")
 
(defun smart-symbol-goto (name direction)
  "Jumps to the next NAME in DIRECTION in the current buffer.
 
DIRECTION must be either `forward' or `backward'; no other option
is valid."
 
  ;; if `last-command' did not contain
  ;; `smart-symbol-go-forward/backward' then we assume it's a
  ;; brand-new command and we re-set the search term.
  (unless (memq last-command '(smart-symbol-go-forward
                               smart-symbol-go-backward))
    (setq smart-last-symbol-name name))
  (setq smart-symbol-old-pt (point))
  (message (format "%s scan for symbol \"%s\""
                   (capitalize (symbol-name direction))
                   smart-last-symbol-name))
  (unless (catch 'done
            (while (funcall (cond
                             ((eq direction 'forward) ; forward
                              'search-forward)
                             ((eq direction 'backward) ; backward
                              'search-backward)
                             (t (error "Invalid direction"))) ; all others
                            smart-last-symbol-name nil t)
              (unless (memq (syntax-ppss-context
                             (syntax-ppss (point))) '(string comment))
                (throw 'done t))))
    (goto-char smart-symbol-old-pt)))
 
(defun smart-symbol-go-forward ()
  "Jumps forward to the next symbol at point"
  (interactive)
  (smart-symbol-goto (smart-symbol-at-pt 'end) 'forward))
 
(defun smart-symbol-go-backward ()
  "Jumps backward to the previous symbol at point"
  (interactive)
  (smart-symbol-goto (smart-symbol-at-pt 'beginning) 'backward))
 
(defun smart-symbol-at-pt (&optional dir)
  "Returns the symbol at point and moves point to DIR (either `beginning' or `end') of the symbol.
 
If `smart-use-extended-syntax' is t then that symbol is returned
instead."
  (with-syntax-table (make-syntax-table)
    (if smart-use-extended-syntax
        (modify-syntax-entry ?. "w"))
    (modify-syntax-entry ?_ "w")
    (modify-syntax-entry ?- "w")
    ;; grab the word and return it
    (let ((word (thing-at-point 'word))
          (bounds (bounds-of-thing-at-point 'word)))
      (if word
          (progn
            (cond
             ((eq dir 'beginning) (goto-char (car bounds)))
             ((eq dir 'end) (goto-char (cdr bounds)))
             (t (error "Invalid direction")))
            word)
        (error "No symbol found")))))
 
(global-set-key (kbd "M-n") 'smart-symbol-go-forward)
(global-set-key (kbd "M-p") 'smart-symbol-go-backward)
;; smart scan end

;; http://www.masteringemacs.org/articles/2011/01/14/effective-editing-movement/
(defun ido-goto-symbol (&optional symbol-list)
  "Refresh imenu and jump to a place in the buffer using Ido."
  (interactive)
  (unless (featurep 'imenu)
	(require 'imenu nil t))
  (cond
   ((not symbol-list)
	(let ((ido-mode ido-mode)
		  (ido-enable-flex-matching
		   (if (boundp 'ido-enable-flex-matching)
			   ido-enable-flex-matching t))
		  name-and-pos symbol-names position)
	  (unless ido-mode
		(ido-mode 1)
		(setq ido-enable-flex-matching t))
	  (while (progn
			   (imenu--cleanup)
			   (setq imenu--index-alist nil)
			   (ido-goto-symbol (imenu--make-index-alist))
			   (setq selected-symbol
					 (ido-completing-read "Symbol? " symbol-names))
			   (string= (car imenu--rescan-item) selected-symbol)))
	  (unless (and (boundp 'mark-active) mark-active)
		(push-mark nil t nil))
	  (setq position (cdr (assoc selected-symbol name-and-pos)))
	  (cond
	   ((overlayp position)
		(goto-char (overlay-start position)))
	   (t
		(goto-char position)))))
   ((listp symbol-list)
	(dolist (symbol symbol-list)
	  (let (name position)
		(cond
		 ((and (listp symbol) (imenu--subalist-p symbol))
		  (ido-goto-symbol symbol))
		 ((listp symbol)
		  (setq name (car symbol))
		  (setq position (cdr symbol)))
		 ((stringp symbol)
		  (setq name symbol)
		  (setq position
				(get-text-property 1 'org-imenu-marker symbol))))
		(unless (or (null position) (null name)
					(string= (car imenu--rescan-item) name))
		  (add-to-list 'symbol-names name)
		  (add-to-list 'name-and-pos (cons name position))))))))
(global-set-key (kbd "M-i") 'ido-goto-symbol)

;; ;; http://www.masteringemacs.org/articles/2010/12/22/fixing-mark-commands-transient-mark-mode/
;; (defun push-mark-no-activate ()
;;   "Pushes `point' to `mark-ring' and does not activate the region
;; Equivalent to \\[set-mark-command] when \\[transient-mark-mode] is disabled"
;;   (interactive)
;;   (push-mark (point) t nil)
;;   (message "Pushed mark to ring"))
;; (global-set-key (kbd "C-`") 'push-mark-no-activate)

;; (defun jump-to-mark ()
;;   "Jumps to the local mark, respecting the `mark-ring' order.
;; This is the same as using \\[set-mark-command] with the prefix argument."
;;   (interactive)
;;   (set-mark-command 1))
;; (global-set-key (kbd "M-`") 'jump-to-mark)

;; copy-line del-line 
;; http://xahlee.org/emacs/emacs_copy_cut_current_line.html
(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy the current line."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (progn
       (message "Current line is copied.")
       (list (line-beginning-position) (line-beginning-position 2)) ) ) ))

(defadvice kill-region (before slick-copy activate compile)
  "When called interactively with no active region, cut the current line."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (progn
       (list (line-beginning-position) (line-beginning-position 2)) ) ) ))

;; org-mode set lines to wrap
;; https://plus.google.com/113859563190964307534/posts/RVBN7KvQtB7
(add-hook 'org-mode-hook 'soft-wrap-lines)


(defun soft-wrap-lines ()
  "Make lines wrap at window edge and on word boundary,
in current buffer."
  (interactive)
  (setq truncate-lines nil)
  (setq word-wrap t)
  )

;; ;; http://www.emacswiki.org/emacs/download/key-chord.el
;; (require 'key-chord)
;; (key-chord-mode 1)
;; (key-chord-define-global "fg" "\M-m")
;; (key-chord-define-global "fg" "\C-e;")

;; browse-kill-ring+
;; http://www.emacswiki.org/emacs/BrowseKillRing
;;(require 'browse-kill-ring+)

;; jump-char
;; http://emacsrocks.com/e04.
(require 'jump-char)
(global-set-key [(meta m)] 'jump-char-forward)
(global-set-key [(shift meta m)] 'jump-char-backward)

;; ace jump
;; http://www.emacswiki.org/emacs/AceJump
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(require 'expand-region)
(global-set-key (kbd "C-c e") 'er/expand-region)

;; magit
(require 'magit)

;; are we on windows?
(setq is-nt (equal system-type 'windows-nt))
(when is-nt (require 'windows))

;; highlight the current line; set a custom face, so we can
;; recognize from the normal marking (selection)
;; ;; http://emacs-fu.blogspot.com/2008/12/highlighting-current-line.html
;; (defface hl-line '((t (:background "black")))
;;   "Face to use for `hl-line-face'." :group 'hl-line)
;; (setq hl-line-face 'hl-line)
;; (global-hl-line-mode t) ; turn it on for all modes by default

;; (desktop-save-mode 1)
(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line."
  (interactive)
  (let ((oldpos (point)))
	(back-to-indentation)
	(and (= oldpos (point))
		 (beginning-of-line))))

(global-set-key (kbd "C-a") 'smart-beginning-of-line)
(global-set-key [home] 'smart-beginning-of-line)

;; change default buffer mgmt to ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; (require 'inline-string-rectangle)
;; (global-set-key (kbd "C-x r t") 'inline-string-rectangle)

;; (require 'rename-sgml-tag)
;; (define-key sgml-mode-map (kbd "C-c C-r") 'rename-sgml-tag)

;; (require 'js2-rename-var)
;; (define-key js2-mode-map (kbd "C-c C-r") 'js2-rename-var)

(require 'wgrep)

;; (if (eq system-uses-terminfo t)
;; 	(progn                              ;; PuTTY hack - needs to be in SCO mode
;; 	  (define-key input-decode-map "\eOn" [C->])))


;; multiple-cursor
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-<") 'mc/mark-prev-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c C-M-.") 'mc/mark-all-like-this)
;;[(shift meta m)] 'jump-char-backward)

(defun darren-org-export-as-html ()
  "override org-export-as-html with bodyonly option"
  (interactive)
  (org-export-as-html nil nil nil nil t nil))
