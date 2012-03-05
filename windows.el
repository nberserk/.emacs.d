;;server-mode
(server-start)
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function) ;remove close confirm.http://shreevatsa.wordpress.com/2007/01/06/using-emacsclient/

;; theme
(add-to-list 'custom-theme-load-path (expand-file-name  "themes" dotfiles-dir))
(load-theme 'zenburn 'y 'y)

;; custom face
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#102e4e" :foreground "#eeeeee" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "outline" :family "Consolas")))))

(provide 'windows)
