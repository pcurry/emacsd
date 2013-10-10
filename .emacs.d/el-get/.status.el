((el-get status "installed" recipe
	 (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "4.stable" :pkgname "dimitri/el-get" :features el-get :info "." :load "el-get.el"))
 (markdown-mode status "installed" recipe
		(:name markdown-mode :description "Major mode to edit Markdown files in Emacs" :type git :url "git://jblevins.org/git/markdown-mode.git" :post-init
		       (add-to-list 'auto-mode-alist
				    '("\\.\\(md\\|mdown\\|markdown\\)\\'" . markdown-mode))))
 (python status "installed" recipe
	 (:name python :description "Python's flying circus support for Emacs" :type github :pkgname "fgallina/python.el"))
 (python-mode status "installed" recipe
	      (:type github :username "emacsmirror" :name python-mode :type emacsmirror :description "Major mode for editing Python programs" :features
		     (python-mode doctest-mode)
		     :compile nil :load "test/doctest-mode.el" :prepare
		     (progn
		       (autoload 'python-mode "python-mode" "Python editing mode." t)
		       (add-to-list 'auto-mode-alist
				    '("\\.py$" . python-mode))
		       (add-to-list 'interpreter-mode-alist
				    '("python" . python-mode)))))
 (rst-mode status "installed" recipe
	   (:name rst-mode :description "Mode for viewing and editing reStructuredText-documents." :type http :url "http://docutils.sourceforge.net/tools/editors/emacs/rst.el" :features rst))
 (yaml-mode status "installed" recipe
	    (:name yaml-mode :description "Simple major mode to edit YAML file for emacs" :type github :pkgname "yoshiki/yaml-mode" :prepare
		   (progn
		     (autoload 'yaml-mode "yaml-mode" nil t)
		     (add-to-list 'auto-mode-alist
				  '("\\.ya?ml\\'" . yaml-mode))))))
