((auctex status "installed" recipe
	 (:name auctex :website "http://www.gnu.org/software/auctex/" :description "AUCTeX is an extensible package for writing and formatting TeX files in GNU Emacs and XEmacs. It supports many different TeX macro packages, including AMS-TeX, LaTeX, Texinfo, ConTeXt, and docTeX (dtx files)." :type cvs :module "auctex" :url ":pserver:anonymous@cvs.sv.gnu.org:/sources/auctex" :build
		`(("./autogen.sh")
		  ("./configure" "--without-texmf-dir" "--with-lispdir=`pwd`" ,(concat "--with-emacs=" el-get-emacs))
		  "make")
		:load-path
		("." "preview")
		:load
		("tex-site.el" "preview/preview-latex.el")
		:info "doc"))
 (el-get status "installed" recipe
	 (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "4.stable" :pkgname "dimitri/el-get" :info "." :load "el-get.el"))
 (flymake status "installed" recipe
	  (:name flymake :description "Continuous syntax checking for Emacs." :type github :pkgname "illusori/emacs-flymake"))
 (haskell-mode status "installed" recipe
	       (:name haskell-mode :description "A Haskell editing mode" :type github :pkgname "haskell/haskell-mode" :load "haskell-site-file.el" :post-init
		      (progn
			(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
			(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation))))
 (haskell-mode-exts status "installed" recipe
		    (:name haskell-mode-exts :description "Modular Emacs extensions to Haskell's editing and interactive modes." :type github :pkgname "pheaver/haskell-mode-exts" :load-path
			   (".")
			   :features
			   (haskell-align-imports haskell-installed-packages haskell-navigate-imports haskell-sort-imports inf-haskell-send-cmd)))
 (markdown-mode status "installed" recipe
		(:name markdown-mode :description "Major mode to edit Markdown files in Emacs" :website "http://jblevins.org/projects/markdown-mode/" :type git :url "git://jblevins.org/git/markdown-mode.git" :before
		       (add-to-list 'auto-mode-alist
				    '("\\.\\(md\\|mdown\\|markdown\\)\\'" . markdown-mode))))
 (package status "installed" recipe
	  (:name package :description "ELPA implementation (\"package.el\") from Emacs 24" :builtin 24 :type http :url "http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el" :shallow nil :features package :post-init
		 (progn
		   (setq package-user-dir
			 (expand-file-name
			  (convert-standard-filename
			   (concat
			    (file-name-as-directory default-directory)
			    "elpa")))
			 package-directory-list
			 (list
			  (file-name-as-directory package-user-dir)
			  "/usr/share/emacs/site-lisp/elpa/"))
		   (make-directory package-user-dir t)
		   (unless
		       (boundp 'package-subdirectory-regexp)
		     (defconst package-subdirectory-regexp "^\\([^.].*\\)-\\([0-9]+\\(?:[.][0-9]+\\)*\\)$" "Regular expression matching the name of\n a package subdirectory. The first subexpression is the package\n name. The second subexpression is the version string."))
		   (setq package-archives
			 '(("ELPA" . "http://tromey.com/elpa/")
			   ("gnu" . "http://elpa.gnu.org/packages/")
			   ("marmalade" . "http://marmalade-repo.org/packages/")
			   ("SC" . "http://joseito.republika.pl/sunrise-commander/"))))))
 (python-mode status "installed" recipe
	      (:type github :pkgname "emacsmirror/python-mode" :name python-mode :type emacsmirror :description "Major mode for editing Python programs" :features
		     (python-mode doctest-mode)
		     :compile nil :load "test/doctest-mode.el" :prepare
		     (progn
		       (autoload 'python-mode "python-mode" "Python editing mode." t)
		       (add-to-list 'auto-mode-alist
				    '("\\.py$" . python-mode))
		       (add-to-list 'interpreter-mode-alist
				    '("python" . python-mode)))))
 (python-pep8 status "installed" recipe
	      (:type github :pkgname "emacsmirror/python-pep8" :name python-pep8 :type emacsmirror :description "Minor mode for running `pep8'" :features python-pep8 :post-init
		     (require 'tramp)))
 (rainbow-mode status "installed" recipe
	       (:name rainbow-mode :description "Colorize color names in buffers" :minimum-emacs-version 24 :type elpa))
 (rst-mode status "installed" recipe
	   (:name rst-mode :description "Mode for viewing and editing reStructuredText-documents." :type http :url "http://docutils.sourceforge.net/tools/editors/emacs/rst.el" :features rst))
 (ruby-mode status "installed" recipe
	    (:name ruby-mode :description "Major mode for editing Ruby files. RubyMode provides font-locking, indentation support, and navigation for Ruby code." :type elpa))
 (zenburn status "installed" recipe
	  (:name zenburn :auto-generated t :type emacswiki :description "" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/zenburn.el")))
