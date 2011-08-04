;;; .emacs on mozart, beaten into using el-get

;; Need to make sure TeX is available, to work on my resume
(setq paul-texlive-install "/usr/texbin")

(setenv "PATH" (concat paul-texlive-install ":" (getenv "PATH")))

(cons paul-texlive-install exec-path)

;; Currently, my self-compiled code on mozart lives in ~/bin. This includes git,
;; because when we set this up, I recall that being Alec's advice.
;;
;; Yeah, maybe that was dumb. Maybe git should just be system-wide available.
;;
;; So, make sure my ~/bin is on my exec-path and PATH
(setq paul-binaries "/Users/paulc/bin")

(setenv "PATH" (concat paul-binaries ":" (getenv "PATH")))

(cons paul-binaries exec-path)

;; Local load-path for mozart. May end up living on all machines someday.
(setq load-path (cons "/Users/paulc/.emacs.d/el-get/el-get"
		      (cons "/Users/paulc/.emacs.d/site-lisp" load-path)))

;; Had to hack this in keep magit working right - I guess it doesn't check the
;; exec-path to find executables.
(setq magit-git-executable "/Users/paulc/bin/git")

;; Auctex needs to know where the texmf directory is to build properly.
;; This passes that info into the el-get recipe.
(setq el-get-local-texmf-path "/usr/local/texlive/2010/texmf")

;; Start doing the el-get magic.
(require 'el-get)

;; Things I'm managing with el-get right now.
;;(setq el-get-sources '())
;;      '(el-get auctex clojure-mode color-theme color-theme-twilight org-mode package))

;; (setq my-packages
;;       (append
;;        '(cssh el-get switch-window vkill google-maps nxhtml xcscope yasnippet)
;;        (mapcar 'el-get-source-name el-get-sources)))

(setq my-packages
      '(el-get auctex clojure-mode color-theme color-theme-twilight org-mode package python-mode)
)

(el-get 'sync my-packages)

;; Color-theme setup
(require 'color-theme)
(color-theme-initialize)
(color-theme-twilight)

;; Trying to get auctex working.
(setq load-path 
      (cons "/Applications/Emacs.app/Contents/Resources/site-lisp/auctex" 
	    load-path))

;; Org mode setup
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
;; (global-set-key "\C-cb" 'org-iswitchb)
(setq org-log-done t)
(setq org-agenda-files (list "~/personal/org-mode/home.org" "~/personal/org-mode/meta.org" "~/personal/org-mode/tech-skills.org" "~/personal/org-mode/infrastructure.org"))


;; Following modes not currently managed with el-get

;; Erlang mode setup
(setq load-path (cons  "/Users/paulc/lib/erlang/lib/tools-2.6.6.1/emacs"
		       load-path))
(setq erlang-root-dir "/Users/paulc/lib/erlang")
(require 'erlang-start)

;; Haskell mode setup - get Haskell mode under el-get after I 
;; get darcs on this machine.
(load "~/lib/emacs/haskell-mode-2.8.0/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'font-lock-mode)
(add-hook 'haskell-mode-hook 'imenu-add-menubar-index)

;; Useful for making constants.
(put 'upcase-region 'disabled nil)
