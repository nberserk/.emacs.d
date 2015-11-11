;; titlebar
(setq frame-title-format '("emacs - " buffer-file-name))
;; (setq frame-title-format '(buffer-name "%f" ("%b")))

;; hide toolbar/scrollbar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq inhibit-startup-message t)
(setq visible-bell 1)
(mouse-wheel-mode -1)

;; adjust screensize
(if window-system
    (if (string= system-name "iMacSDE.local")
        (set-frame-size (selected-frame) 198 93)
      (set-frame-size (selected-frame) 160 60)
        )    
  )

;; proxy setting
(defun darren-proxy ()
  "set proxy. must be called when in company"
  (interactive)
  (setq url-proxy-services '( ("http" . "168.219.61.252:8080")))
  )

;; load path
;; Set path to .emacs.d
(setq dotfiles-dir (file-name-directory
		    (or (buffer-file-name) load-file-name)))
;; Set path to dependencies
(setq site-lisp-dir (expand-file-name "site-lisp" dotfiles-dir))
(setq my-lisp-dir (expand-file-name "lisp" dotfiles-dir))

;; Set up load path
(add-to-list 'load-path site-lisp-dir)
(add-to-list 'load-path my-lisp-dir)

;; Add external projects to load path
(dolist (project (directory-files site-lisp-dir t "\\w+"))
    (when (file-directory-p project)
      (add-to-list 'load-path project)))

; backup
(setq make-backup-files nil) ; stop creating those backup~ files 
(setq auto-save-default nil) ; stop creating those #auto-save# files
;; (setq backup-directory-alist `(("" . "~/.emacs.d/backup/")))

;; auto indent
;;(define-key global-map (kbd "RET") 'newline-and-indent)

;;; Set localized PATH for OS X
(defun my-add-path (path-element)
  "Add the specified PATH-ELEMENT to the Emacs PATH."
  (interactive "DEnter directory to be added to path: ")
  (if (file-directory-p path-element)
     (progn
       (setenv "PATH" (concat (expand-file-name path-element) path-separator (getenv "PATH")))
       (add-to-list 'exec-path (expand-file-name path-element)))))

(if (fboundp 'my-add-path)
   (let ((my-paths (list "/opt/local/bin" "/usr/local/bin")))
      (dolist (path-to-add my-paths (getenv "PATH"))
         (my-add-path path-to-add))))

;; helm
;;(require 'helm-config)
;; (require 'helm-files)
;; (setq helm-idle-delay 0.1)
;; (setq helm-input-idle-delay 0.1)
;; (setq helm-c-locate-command "locate-with-mdfind %.0s %s")
;; ;; (loop for ext in '("\\.swf$" "\\.elc$" "\\.pyc$")
;; ;; 	        do (add-to-list 'helm-c-boring-file-regexp-list ext))
;(define-key global-map (kbd "M-t") 'helm-for-files)

;; package
(require 'setup-package)

;; Install extensions if they're missing
;; (defun init--install-packages ()
;;   (packages-install
;; ;   (cons 'exec-path-from-shell melpa)
;;    (cons 'magit melpa)
;;    ;(cons 'yasnippet melpa)
;;    (cons 'ace-jump-mode melpa)
;;    (cons 'jump-char melpa)
;;    (cons 'expand-region melpa)
;;    (cons 'wgrep melpa)
;;    (cons 'mark-multiple melpa)
;;    (cons 'multiple-cursors melpa)
;; ;   (cons 'paredit melpa)
;;       ))

;; (condition-case nil
;;     (init--install-packages)
;;   (error
;;    (package-refresh-contents)
;;    (init--install-packages)))

;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" dotfiles-dir))

;; auto pair
(electric-pair-mode)

;; powershell-mode
;; (autoload 'powershell-mode "powershell-mode" "A editing mode for Microsoft PowerShell." t)
;; (add-to-list 'auto-mode-alist '("\\.ps1\\'" . powershell-mode)) ; PowerShell script

;;yasnippet from http://xahlee.org/emacs/emacs_templates.html
(require 'setup-yasnippet) ;; not yasnippet-bundle
;; (setq yas/root-directory `(,(expand-file-name "snippets" dotfiles-dir)))
;; 			   ,(expand-file-name "yasnippet/snippets" site-lisp-dir)))
;; (mapc 'yas-load-directory yas/root-directory)
;; (yas/global-mode 1)

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
(setq-default indent-tabs-mode nil)
(setq tab-width 2) ; or any other preferred value
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

; c/cpp
;; (require 'cc-mode)
;; (setq-default tab-width 4
;;               c-basic-offset 4
;;               indent-tabs-mode nil)
;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (c-set-style "stroustrup")
;;              ))
;; (define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

;(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 48 56 64 72))
;; i wonder below line is necessary. not enough tab-width ?
;; (add-hook 'cmake-mode-hook 
;;   (lambda () 
;; 	(setq cmake-tab-width 4)))

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

;; org
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sh . true) (python . true)))
;; (setq org-log-done 'time)
;; (add-hook 'org-mode-hook 
;;   (lambda () 
;; 	(setq org-hide-leading-stars t)
;; 	(setq org-indent-mode t)))

;; window navigation helper key
(global-set-key (kbd "C-x <up>") 'windmove-up) 
(global-set-key (kbd "C-x <down>") 'windmove-down) 
(global-set-key (kbd "C-x <right>") 'windmove-right) 
(global-set-key (kbd "C-x <left>") 'windmove-left)

;; start helm
(require 'helm-config)
(helm-mode 1)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
;; end of helm

;; recentf
;; get rid of `find-file-read-only' and replace it with something
;; more useful.

;; enable recent files mode.
(recentf-mode t)
(setq recentf-max-saved-items 50)		; 50 files ought to be enough.
(global-set-key (kbd "C-x C-r") 'helm-recentf) ;; recentf

;; ;; abbrev
;; ;; stop asking whether to save newly added abbrev when quitting emacs
;; (setq save-abbrevs nil)
;; (setq abbrev-file-name "d:/Dropbox/emacs-23.2/site-lisp/abbrev_defs.el")
;; ;; always on
;; (setq default-abbrev-mode t)

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

;; http://www.masteringemacs.org/articles/2010/12/22/fixing-mark-commands-transient-mark-mode/
(defun push-mark-no-activate ()
  "Pushes `point' to `mark-ring' and does not activate the region
Equivalent to \\[set-mark-command] when \\[transient-mark-mode] is disabled"
  (interactive)
  (push-mark (point) t nil)
  (message "Pushed mark to ring"))
(global-set-key (kbd "C-`") 'push-mark-no-activate)

(defun jump-to-mark ()
  "Jumps to the local mark, respecting the `mark-ring' order.
This is the same as using \\[set-mark-command] with the prefix argument."
  (interactive)
  (set-mark-command 1))
(global-set-key (kbd "M-`") 'jump-to-mark)

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
;;http://www.emacswiki.org/emacs/AceJump
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(require 'expand-region)
(global-set-key (kbd "C-\\") 'er/expand-region)

;; magit
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

(autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurrence of CHAR.")
(global-set-key (kbd "M-z") 'zap-up-to-char)
(global-set-key (kbd "M-Z") 'zap-to-char)

;; are we on windows?
(setq is-nt (equal system-type 'windows-nt))
(when is-nt (require 'windows))

;; highlight the current line; set a custom face, so we can
;; recognize from the normal marking (selection)
;; ;; http://emacs-fu.blogspot.com/2008/12/highlighting-current-line.html
(defface hl-line '((t (:background "Gray10")))
  "Face to use for `hl-line-face'." :group 'hl-line)
(setq hl-line-face 'hl-line)
(global-hl-line-mode t) ; turn it on for all modes by default

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

(show-paren-mode 0)

;; c++
(setq-default c-basic-offset 4)

;; change default buffer mgmt to ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

(server-start)
;; (require 'inline-string-rectangle)
;; (global-set-key (kbd "C-x r t") 'inline-string-rectangle)

(require 'wgrep)

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

;; --------------------------------------------------------------------------
;; eshell
(defun eshell-here ()
  "Opens up a new shell in the directory associated with the current buffer's file."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (name (car (last (split-string parent "/" t)))))
    (split-window-vertically)
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)))

(defun delete-single-window (&optional window)
  "Remove WINDOW from the display.  Default is `selected-window'.
If WINDOW is the only one in its frame, then `delete-frame' too."
  (interactive)
  (save-current-buffer
    (setq window (or window (selected-window)))
    (select-window window)
    (kill-buffer)
    (if (one-window-p t)
        (delete-frame)
        (delete-window (selected-window)))))

(defun eshell/x ()
  (delete-single-window))
;; end of eshell
;; --------------------------------------------------------------------------


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (wombat)))
 '(js2-basic-offset 2)
 '(markdown-command "/usr/local/bin/markdown"))

;; delete text not kill into kill-ring
(defun my-delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times.
This command does not push erased text to kill-ring."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun my-backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument, do this that many times.
This command does not push erased text to kill-ring."
  (interactive "p")
  (my-delete-word (- arg)))

(defun my-delete-line ()
  "Delete text from current position to end of line char."
  (interactive)
  (delete-region
   (point)
   (save-excursion (move-end-of-line 1) (point)))
  (delete-char 1)
)

(defun my-delete-line-backward ()
  "Delete text between the beginning of the line to the cursor position."
  (interactive)
  (let (x1 x2)
    (setq x1 (point))
    (move-beginning-of-line 1)
    (setq x2 (point))
    (delete-region x1 x2)))

; Here's the code to bind them with emacs's default shortcut keys:

(global-set-key (kbd "M-d") 'my-delete-word)
(global-set-key (kbd "<M-backspace>") 'my-backward-delete-word)
;; (global-set-key (kbd "C-k") 'my-delete-line)
;; (global-set-key (kbd "C-S-k") 'my-delete-line-backward)


(global-set-key (kbd "C-x o") 'ace-window)

;; sbt 
(setq sbt:program-name "/usr/local/bin/sbt")
(add-hook 'scala-mode-hook '(lambda ()
   ;; sbt-find-definitions is a command that tries to find (with grep)
   ;; the definition of the thing at point.
   (local-set-key (kbd "M-.") 'sbt-find-definitions)

   ;; use sbt-run-previous-command to re-compile your code after changes
   (local-set-key (kbd "C-x '") 'sbt-run-previous-command)
   ;; Bind C-a to 'comint-bol when in sbt-mode. This will move the
   ;; cursor to just after prompt.
   (local-set-key (kbd "C-a") 'comint-bol)
))
;; end of sbt

;; <org2blog
(setq org2blog/wp-blog-alist
      '(("wordpress"
         :url "https://nberserk.wordpress.com/xmlrpc.php"
         :username "nberserk"
         :default-title "Hello"
         :default-categories ("org2blog" "emacs")
         :tags-as-categories nil)
        ))
(setq org2blog/wp-buffer-template
      "-----------------------
#+TITLE: %s
#+DATE: %s
-----------------------\n")
(defun my-format-function (format-string)
  (format format-string
          org2blog/wp-default-title
          (format-time-string "%d-%m-%Y" (current-time))))

(setq org2blog/wp-buffer-format-function 'my-format-function)


;; org2blog>


;; call python script
;; http://emacs.stackexchange.com/questions/13210/run-python-script-with-after-save-hook?newreg=0a9c59b401e04e70acb38a2e88685f2d
(setq org-publish-project-alist
           '(("orgfiles"
               :base-directory "~/projects/nberserk.github.io/org"
               :base-extension "org"
               :publishing-directory "~/projects/nberserk.github.io/_posts"
               :publishing-function org-html-publish-to-html
               :exclude "PrivatePage.org"   ;; regexp
               :headline-levels 3
               :section-numbers nil
               :with-toc nil
               :html-head "<link rel=\"stylesheet\"
                       href=\"../other/mystyle.css\" type=\"text/css\"/>"
               :html-preamble t
               :body-only t)
     
              ("images"
               :base-directory "~/images/"
               :base-extension "jpg\\|gif\\|png"
               :publishing-directory "/ssh:user@host:~/html/images/"
               :publishing-function org-publish-attachment)
     
              ("other"
               :base-directory "~/other/"
               :base-extension "css\\|el"
               :publishing-directory "/ssh:user@host:~/html/other/"
               :publishing-function org-publish-attachment)
              ("website" :components ("orgfiles" "images" "other"))))



;; webmode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;;(add-to-list 'auto-mode-alist '("\\.js?\\'" . web-mode))

(setq web-mode-enable-auto-expanding t)
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)
;; end of webmode
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; artist mode
;; enable moust right click
(eval-after-load "artist"
   '(define-key artist-mode-map [(down-mouse-3)] 'artist-mouse-choose-operation)
   )
