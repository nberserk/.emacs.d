;;server-mode
(server-start)
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function) ;remove close confirm.http://shreevatsa.wordpress.com/2007/01/06/using-emacsclient/

;; theme
;; (add-to-list 'custom-theme-load-path (expand-file-name  "themes" dotfiles-dir))
;; (load-theme 'zenburn 'y )

(provide 'windows)
