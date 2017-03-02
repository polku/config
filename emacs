;; Load general features files
(setq config_files "/usr/share/emacs/site-lisp/")
(setq load-path (append (list nil config_files) load-path))
(add-to-list 'load-path "~/.emacs.d/elpa/")

(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))


;; Set default emacs configuration
(set-language-environment "UTF-8")
(setq-default font-lock-global-modes t)
(setq-default line-number-mode t)
(setq-default column-number-mode t)
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

; indents
;(global-set-key (kbd "TAB") 'self-insert-command)
;(setq-default indent-tabs-mode t)
;(setq-default tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
;                             64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
;(add-hook 'c-mode-hook
;   (lambda () (define-key c-mode-map (kbd "TAB") 'self-insert-command)))
;(add-hook 'c++-mode-hook
;   (lambda () (define-key c++-mode-map (kbd "TAB") 'self-insert-command)))

(setq-default indent-tabs-mode nil
              tab-width 4) ; C-q <TAB> if a tab is really necessary

(setq-default c-basic-offset 4)
(setq-default c-default-style "linux")

;; Specific options indentation
(c-set-offset 'inline-open 0)
(c-set-offset 'case-label '+)

;; Mouse
(require 'mouse)
(require 'xt-mouse)
(xterm-mouse-mode t)

;; Global options
(global-set-key (kbd "DEL") 'backward-delete-char)
(setq-default c-backspace-function 'backward-delete-char)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq ring-bell-function 'ignore)
(setq make-backup-files nil)
(setq auto-save-interval 30)
(setq show-trailing-whitespace t)
(setq-default show-trailing-whitespace t)
(add-hook 'write-file-hooks 'delete-trailing-whitespace)
(display-time-mode 1)
(ido-mode t) ; rech nom fich
(put 'upcase-region 'disabled nil) ;; C-x C-u active
(global-linum-mode 1)
(show-paren-mode 1) ; show matching parenthese
;;(global-auto-revert-mode t) ;; reload files when changed

;; Global bindings
(defun untab-file() "Untabify the file" (interactive) (untabify (point-min) (point-max) nil))
(defun indent-file() "Indent the file" (interactive) (indent-region (point-min) (point-max) nil))
(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "C-f") 'forward-word)
(global-set-key (kbd "C-d") 'scroll-down)
(global-set-key (kbd "C-x C-n") 'global-whitespace-mode)
(global-set-key (kbd "C-c C-c") 'comment-region)
(global-set-key (kbd "C-c C-u") 'uncomment-region)
(global-set-key (kbd "<f5>") 'calculator)
(global-set-key (kbd "<f6>") 'untab-file)
(global-set-key (kbd "<f7>") 'comment-region)
(global-set-key (kbd "<f8>") 'uncomment-region)
(global-set-key (kbd "<f9>") 'ibuffer)
(global-set-key (kbd "<f10>") 'indent-file)
(global-set-key (kbd "<f11>") 'call-last-kbd-macro)

;; auto-complete for all prog-modes
(add-hook 'prog-mode-hook #'auto-complete-mode)

;; Fuzzy matching search
(global-set-key (kbd "C-M-s") 'flx-isearch-forward)
(global-set-key (kbd "C-M-r") 'flx-isearch-backward)

;; Copy pasta, gui only
(if window-system ((load "simpleclip-1.0.0/simpleclip.el")
                   (simpleclip-mode 1)
                   (setq x-select-enable-primary t)
                   (setq x-select-enable-clipboard t)))
                   
;; Custom functions
(defun toggle-comments-region (start end)
  "Toggle comments (on/off) for each line in the region"
  (interactive "r")
  (goto-char start)
  (while (< (point) end)
    (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (forward-line 1)))

(defun toggle-comment-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))


;; Mode specific bindings and options
(fset 'cout
   "std::cout << \"\" << std:endl;\C-[OD\C-[OD\C-[OD\C-[OD\C-[OD:\C-[OC\C-[OC\C-[OC\C-[OC\C-[OC\C-m")
(add-hook 'c++-mode-hook
    (lambda ()
        (define-key c++-mode-map (kbd "<f9>") 'cout)))
(add-hook 'python-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil
                    tab-width 4)))
(add-hook 'web-mode-hook
          (lambda ()
            (setq web-mode-markup-indent-offset 2)
            (define-key web-mode-map (kbd "C-n") 'web-mode-tag-match)))

(setq-default ediff-forward-word-function 'forward-char)

;; Auto-insert-mode (cf templates)
(auto-insert-mode)
(setq auto-insert-directory "~/.mytemplates/")
(setq auto-insert-query nil)
(define-auto-insert "\.py" "python.py")
(define-auto-insert "\.html" "html.html")
(define-auto-insert "\.df" "docker.df")
(define-auto-insert "Dockerfile" "docker.df")

;; specific modes
(add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode)) ; open .m file with octave-mode
(add-to-list 'auto-mode-alist '("\\.tpp\\'" . c++-mode)) ; open .tpp file with c++-mode
(add-to-list 'auto-mode-alist '("\\.vert\\'" . c-mode)) ; open glsl shader with c-mode
(add-to-list 'auto-mode-alist '("\\.frag\\'" . c-mode)) ; open glsl shader with c-mode
(add-to-list 'auto-mode-alist '("\\.conf\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode)) ; handle js in html


;; dockerfile mode
(add-to-list 'load-path "~/.local/share/emacs/dockerfile-mode/")
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
(add-to-list 'auto-mode-alist '("\\.df\\'" . dockerfile-mode))


;; Configure flymake for Python
;; to deactivate flymake for a file, set this as the first line:
;; -*- mode: Python; eval: (flymake-mode 0) -*-
(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "epylint3" (list local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))

;; Set as a minor mode for Python
(add-hook 'python-mode-hook '(lambda () (flymake-mode)))

;; Configure to wait a bit longer after edits before starting
(setq-default flymake-no-changes-timeout '1)

;; Keymaps to navigate to the errors
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-cn" 'flymake-goto-next-error)))
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-cp" 'flymake-goto-prev-error)))

;; To avoid having to mouse hover for the error message, these functions make flymake error messages
;; appear in the minibuffer
(defun show-fly-err-at-point ()
  "If the cursor is sitting on a flymake error, display the message in the minibuffer"
  (require 'cl)
  (interactive)
  (let ((line-no (line-number-at-pos)))
    (dolist (elem flymake-err-info)
      (if (eq (car elem) line-no)
          (let ((err (car (second elem))))
            (message "%s" (flymake-ler-text err)))))))

(add-hook 'post-command-hook 'show-fly-err-at-point)


;*******************************************************************************;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (wombat))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
