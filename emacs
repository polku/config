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

; indents
;(global-set-key (kbd "TAB") 'self-insert-command)
(setq-default indent-tabs-mode t)
(setq-default tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
                             64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
(add-hook 'c-mode-hook
   (lambda () (define-key c-mode-map (kbd "TAB") 'self-insert-command)))
(add-hook 'c++-mode-hook
   (lambda () (define-key c++-mode-map (kbd "TAB") 'self-insert-command)))
(setq-default c-basic-offset 4)
(setq-default c-default-style "linux")

; Specific options indentation
(c-set-offset 'inline-open 0)
(c-set-offset 'case-label '+)
;(c-set-offset 'label '+)
;(c-set-offset 'defun-block-intro '++) ; av

; Global options
(global-set-key (kbd "DEL") 'backward-delete-char)
(setq-default c-backspace-function 'backward-delete-char)
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
(ido-mode t) ; rech nom fich
(add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode)) ; open .m file with octave-mode
(add-to-list 'auto-mode-alist '("\\.tpp\\'" . c++-mode)) ; open .tpp file with c++-mode
(add-to-list 'auto-mode-alist '("\\.vert\\'" . c-mode)) ; open glsl shader with c-mode
(add-to-list 'auto-mode-alist '("\\.frag\\'" . c-mode)) ; open glsl shader with c-mode
(put 'upcase-region 'disabled nil) ;; C-x C-u active
;;(global-auto-revert-mode t) ;; reload files when changed

; Global bindings
(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "C-f") 'forward-word)
(global-set-key (kbd "C-d") 'scroll-down)
(global-set-key (kbd "C-x C-n") 'global-whitespace-mode)
(global-set-key (kbd "C-c C-c") 'comment-region)
(global-set-key (kbd "C-c C-u") 'uncomment-region)
(global-set-key (kbd "<f5>") 'calculator)
(global-set-key (kbd "<f6>") 'calendar)
(global-set-key (kbd "<f7>") 'comment-region)
(global-set-key (kbd "<f8>") 'uncomment-region)
(global-set-key (kbd "<f9>") 'ibuffer)
(defun indent-file() "Indent the file" (interactive) (indent-region (point-min) (point-max) nil))
(global-set-key (kbd "<f10>") 'indent-file)
(global-set-key (kbd "<f11>") 'call-last-kbd-macro)

; Mode specific bindings
(fset 'cout
   "std::cout << \"\" << std:endl;\C-[OD\C-[OD\C-[OD\C-[OD\C-[OD:\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-m")
(add-hook 'c++-mode-hook
	(lambda ()
		(define-key c++-mode-map (kbd "<f9>") 'cout)))
(add-hook 'python-mode-hook
          (lambda ()
			(setq indent-tabs-mode nil
            		tab-width 4)))

; Auto-insert-mode (cf templates)
(auto-insert-mode)
(setq auto-insert-directory "~/.mytemplates/")
(setq auto-insert-query nil)
(define-auto-insert "\.py" "python.py")

;*******************************************************************************;
