# emacs_conf
to get this working:
 - install emacs
 - open emacs once
 - close emacs
 - run
 ``` ln -s dot-emacs ~/.emacs && ln -s dot-emacs-dot-d-config.org ~/.emacs.d/config.org```
 - open emacs
 - ... wait for all the packages to install
 - close emacs
 - run
 ``` cd ~/.emacs.d/elpa/yasnippet-snippets-*.*/ && rm -rf snippets && ln -s path/of/the/git/dir/snippets snippets && cd -```
 - open emacs (and finally do something productive)
