;;; package --- Summary

;;; Commentary:
;;; Current pcurry .emacs on Truveris MB Pro

;;; Code:
(setq inhibit-startup-message t)                 ;no splash screen
(setq inhibit-splash-screen t)                   ;Eliminate GNU splash screen


;;; Imports my shell environment PATH when on a mac
(when (memq window-system '(mac ns))
  (let ((path (shell-command-to-string ". /etc/profile; . ~/.bash_profile; echo -n $PATH")))
    (setenv "PATH" path)
    (setq exec-path
          (append
           (split-string-and-unquote path ":")
           exec-path))))

;; el-get basic setup and autoload
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;;; Support homebrew-installed elisp
(let ((default-directory "/usr/local/share/emacs/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (let (el-get-master-branch)
       (goto-char (point-max))
       (eval-print-last-sexp)))))

;; (add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

(when (memq window-system '(mac ns))
  (require 'exec-path-from-shell)
  (exec-path-from-shell-copy-envs '("PYTHONPATH" "MANPATH")))

(load-theme 'wombat)

(require 'desktop)

(defun my-desktop-save ()
  (interactive)
  ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
  (if (eq (desktop-owner) (emacs-pid))
      (desktop-save desktop-dirname)))

;; desktop mode (save buffers on exit)
;; autosave buffers

(desktop-save-mode 1)

;;; autosave hook
(add-hook 'auto-save-hook 'my-desktop-save)

(require 'ido)
(ido-mode t)


;; Auto mode hooks
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; support yaml-mode for salt state editing
(add-to-list 'auto-mode-alist '("\\.sls$" . yaml-mode))

;; Some configuration to automatic behavior.
;; (delete-selection-mode t) ;; I am used to this but maybe I shouldn't be.
(show-paren-mode t)
(setq-default show-trailing-whitespace t)
(setq-default indent-tabs-mode nil)  ;; never indent with tabs

;; text mode hooks
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;;enable flycheck
;; (add-hook 'after-init-hook #'global-flycheck-mode)

;;enable linum mode
(add-hook 'python-mode-hook 'linum-mode)

;; python-mode hooks and keymap
(add-hook 'python-mode-hook
	  (lambda ()
            (setq py-smart-indentation nil)
            (setq py-indent-offset 4)
            (setq indent-tabs-mode nil)
	    (define-key python-mode-map [f8] 'python-pep8)))

;; Jedi auto-complete setup
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))
(add-hook 'sh-mode-hook
          (lambda ()
            (if (string-match "\\.zsh$" buffer-file-name)
                (sh-set-shell "zsh"))))

;; Makes reverting a file a single-keystroke operation
(defun refresh-file ()
  (interactive)
  (revert-buffer t t t))

;; Global function key bindings
(global-set-key [f5] 'refresh-file)
(global-set-key [f7] 'linum-mode)
(global-set-key [f9] 'delete-trailing-whitespace)


;; Take off some of the training wheels.
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

