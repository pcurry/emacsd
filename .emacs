;; .emacs -- your personal initialization file for Emacs.  

;; If this runs with no errors, then the Emacs Lisp file
;;
;;        /usr/public/share_lib/emacs/site-lisp/default.el 
;;
;; will be loaded immediately afterwards.  On the other hand, if there
;; *is* an error in your .emacs, then default.el will never get
;; loaded, which might cause all sorts of problems.  You can think of
;; default.el as a sort of "global" .emacs -- it's the place where the
;; Emacs maintainers make customizations that need to affect all users
;; on the system, whereas ~you/.emacs is the place you make
;; customizations that affect only your own Emacs. 

;; Files ending in ".el", are written in Emacs Lisp.  Your .emacs is
;; also written in Emacs Lisp -- it is the exception to the rule that
;; Emacs Lisp files end in ".el".
;;
;; To learn more about Emacs Lisp, read Info (by typing C-h i), or
;; mail help@cs.oberlin.edu and ask about it.

;;; End introductory comment.

;;; Begin code.

;; This makes anon ftp easy from Emacs.  Mail help about how to do
;; it if you don't already know -- it's very useful!
(setq ange-ftp-default-user "anonymous")

;;; Don't know where the site-lisp actually is on my mac.
;;; (setq load-path (cons "/usr/public/share/emacs/site-lisp" load-path))


; Make sure to send the right anonymous password in ftp:
(defvar ange-ftp-generate-anonymous-password 
  (concat (user-login-name) "@cs.oberlin.edu" "*Default password used
by Emacs when it does ftp.  Since anonymous ftp usually asks for your
address, we just use that."))

;; Make sure you get good scheme modes:
(fmakunbound 'run-scheme)
(autoload 'run-scheme "cmuscheme"
  "Run an interactive Scheme process in Emacs." t)

;; Make VM start out displaying a menu of mail messages when you run
;; "M-x vm":
(setq vm-startup-with-summary t)

;; Prepare your own personal keymap, and then put it on C-c:
(define-prefix-command 'personal-map)

;; C-c <letter> is guaranteed never to be bound in the standard
;; distribution of Emacs.  It is reserved for users' personal
;; keybindings, and we, being reasonable people, will abide by this
;; convention, so that we don't override anything important:
(global-set-key "\C-c" personal-map)

;; This is how run-scheme gets bound to C-c s.  Comment it out or
;; change it to something else if you want.  Remember, personal-map
;; was bound to C-c a few lines above, so the following line has the
;; effect of binding "C-c s" to run-scheme:
(define-key personal-map "s" 'run-scheme)

;; Make shell mode start by typing C-c j.
;; There is no compelling mnemonic for this.  I just picked "j"
;; because it's easy to reach.
(define-key personal-map "j" 'shell)

;; A keybinding for opening a file in a new window:
(define-key personal-map "f" 'find-file-other-window)

;; Convenient to have goto-line bound to a key.  It really ought to be
;; that way by default, but sometimes Emacs is just braindead:
(define-key personal-map "l" 'goto-line)

;; Make sure that text mode fills automatically.  "Fill" is
;; Emacs-speak for auto-wrapping, by the way:
(setq text-mode-hook 'turn-on-auto-fill)

;; We don't want to have trouble exiting emacs just because a shell or
;; a scheme was run.  A `hook' is something that gets run once, when a
;; certain mode starts up.  All modes run an appropriately named hook:
(add-hook 'shell-mode-hook
          (function
           (lambda ()
             (let ((p (get-buffer-process (current-buffer))))
               (if (processp p)
                   (process-kill-without-query p))))))

(add-hook 'inferior-scheme-mode-hook
          (function
           (lambda ()
             (let ((p (get-buffer-process (current-buffer))))
               (if (processp p)
                   (process-kill-without-query p))))))

;; We define a function with "defun":
(defun oberlin-scheme-send-buffer ()
  "Send the current buffer of Scheme code to the
Scheme-process-in-a-buffer, wherever it may be.
If there is no scheme process running, you'll get an error."
  (interactive)
  (message "Sending buffer contents to scheme process...")
  (scheme-send-region (point-min) (point-max))
  (message "Sending buffer contents to scheme process...done"))

;; This binds C-c b to our new function `oberlin-scheme-send-buffer',
;; but only when in scheme mode.  This is done by having the binding
;; made locally whenever a buffer enters `scheme-mode'.
(add-hook 'scheme-mode-hook
          (function
           (lambda ()
             (local-set-key "\C-cb" 'oberlin-scheme-send-buffer))))

;; Causes the time to always be displayed in the mode-line, and also
;; indicates the arrival of new mail by displaying "Mail" on the
;; mode-line:
(display-time)

;; This long expression sets up region highlighting under X windows.
;; Change the colors, or get rid of it entirely if you want -- these
;; are just my personal preferences.
(if (eq window-system 'x) ; if we are running under X windows...
    (progn
      (transient-mark-mode 1)
      (setq mark-even-if-inactive t)
      (setq search-highlight t)
      (setq highlight-nonselected-windows nil)
      (set-face-background 'region "gray")
      (set-face-foreground 'region "black")
      (set-face-background 'highlight "gray")
      (set-face-foreground 'highlight "black")))

;; Sets font-lock on, highlighting text as appropriate for each 
;; language.

      (add-hook 'scheme-mode-hook 'turn-on-font-lock)
      (add-hook 'java-mode-hook 'turn-on-font-lock)
      (add-hook 'c-mode-hook 'turn-on-font-lock)
      (add-hook 'c++-mode-hook 'turn-on-font-lock)
      (add-hook 'perl-mode-hook 'turn-on-font-lock)
      (add-hook 'sgml-mode-hook 'turn-on-font-lock)
      (add-hook 'html-mode-hook 'turn-on-font-lock)

;; Below is all the stuff that creates that annoying "Welcome!" buffer
;; when you start up Emacs.  Delete or modify it however you wish --
;; it's your .emacs, after all!

(switch-to-buffer (get-buffer-create "Welcome!"))

(insert
 "        ------------  Welcome to Emacs (version 20.2.2). ----------------
C-c s     runs Scheme.
C-c j     starts up a command shell (gives you a shell prompt, that is).
C-c f     calls up a file in another window.
C-c l     goes to a line (prompts you for the line number).
C-x 5 2   brings up a new \"frame\" (another X-window) of this Emacs.
C-x 5 0   deletes current frame (can help unclutter your screen sometimes).
C-h m     read out about the major mode in any given buffer.
C-x C-c   exit Emacs

Type \"C-h t\" if you are very new to Emacs and want to read the Emacs
tutorial (\"C-h\" means hold down the Control key and press h).  Don't
include the double-quotes, of course.

Use \"M-x vm\" to read mail.

Take a look at the file .emacs in your home directory, if you want to
know where this message (and other things) come from.
You can kill this buffer (i.e.: make it go away) with \"C-x k\".

Mail \"help@cs.oberlin.edu\" if you have questions.
")









(custom-set-variables)
(custom-set-faces
 '(highlight ((t (:foreground "black" :background "gray")))))
