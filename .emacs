
;; Get my local built tools available.

(setq paul-texlive-install "/usr/texbin")
(setq paul-binaries "/Users/paulc/bin")

(add-to-list 'exec-path paul-texlive-install)
(add-to-list 'exec-path paul-binaries)

(setenv "PATH" (concat paul-binaries ":" paul-texlive-install ":" (getenv "PATH")))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(setq inhibit-startup-message t)                 ;no splash screen
(setq inhibit-splash-screen t)                   ;Eliminate GNU splash screen

;; Auctex needs to know where the texmf directory is to build properly.
;; This passes that info into the el-get recipe.
(setq el-get-local-texmf-path "/usr/local/texlive/2010/texmf")

;; Auto-setup for el-get
;; (unless (require 'el-get nil t)
;;   (url-retrieve
;;    "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
;;    (lambda (s)
;;      (let (el-get-master-branch)
;;        (goto-char (point-max))
;;        (eval-print-last-sexp)))))

(require 'el-get)
(el-get)

;; Get some of my key bindings from my work .emacs and my other .emacs
;; Make this more of what I want.

;; Also I should clear off this machine, install Mac OS X 10.7, and start
;; configuring a new system where I know what's actually going on.

(load-theme 'wombat)

(show-paren-mode t)
(ido-mode)
(recentf-mode t)                                 ;recently edited files in menu
(setq-default show-trailing-whitespace t)
(delete-selection-mode t)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

(defun refresh-file ()
  (interactive)
  (revert-buffer t t t))

;; Global function key bindings
(global-set-key [f5] 'refresh-file)
(global-set-key [f9] 'delete-trailing-whitespace)


;; Figure out per-mode bindings and use PEP8 in Python mode


(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

