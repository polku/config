
; Load general features files
(setq config_files "/usr/share/emacs/site-lisp/")
(setq load-path (append (list nil config_files) load-path))

(load "list.el")
(load "string.el")
(load "comments.el")
(load "header.el")
(load "php-mode.el")

;(require 'template)
;(require 'ess-site)
;(template-initialize)

; Set default emacs configuration
(set-language-environment "UTF-8")
(setq-default font-lock-global-modes t)
(setq-default line-number-mode t)
(setq-default column-number-mode t)
(setq-default tab-width 4)

; fucking indents
(global-set-key (kbd "TAB") 'self-insert-command)
(setq-default indent-tabs-mode t)
(add-hook 'c-mode-hook
   (lambda () (define-key c-mode-map (kbd "TAB") 'self-insert-command))) ; why the fuck I have to do this ?!
; av C-q Tab

(global-set-key (kbd "DEL") 'backward-delete-char)
(setq-default c-backspace-function 'backward-delete-char)
(setq-default c-basic-offset 4)
(setq-default c-default-style "linux")
(setq-default tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
                             64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))

; Load user configuration
(if (file-exists-p "~/.myemacs") (load-file "~/.myemacs"))

(require 'mouse)
(xterm-mouse-mode t)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq ring-bell-function 'ignore)
(setq make-backup-files nil)
(setq auto-save-interval 120)
(setq show-trailing-whitespace t)
(setq-default show-trailing-whitespace t)
(add-hook 'write-file-hooks 'delete-trailing-whitespace)
(display-time-mode 1)
(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "C-f") 'forward-word)
(global-set-key (kbd "C-d") 'scroll-down)
(global-set-key (kbd "M-i") 'indent-region) ; macro selection doc
(global-set-key (kbd "C-x C-n") 'global-whitespace-mode)
(global-set-key (kbd "C-c C-c") 'comment-region)
(global-set-key (kbd "C-c C-u") 'uncomment-region)
(global-set-key (kbd "<f5>") 'calculator)
(global-set-key (kbd "<f6>") 'calendar)
;*******************************************************************************;
