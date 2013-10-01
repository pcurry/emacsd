;; Current pcurry .emacs on Nomi MB Air

(setq inhibit-startup-message t)                 ;no splash screen
(setq inhibit-splash-screen t)                   ;Eliminate GNU splash screen

;; el-get basic setup and autoload
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

(load-theme 'wombat)

(show-paren-mode t)
(ido-mode)
(setq-default show-trailing-whitespace t)
(delete-selection-mode t)


(defun refresh-file ()
  (interactive)
  (revert-buffer t t t))


;; Global function key bindings
(global-set-key [f5] 'refresh-file)
(global-set-key [f9] 'delete-trailing-whitespace)

;; Take off some of the training wheels.
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
