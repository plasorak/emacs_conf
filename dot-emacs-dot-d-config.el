(defun config-visit ()
  (interactive)
  (find-file "~/.emacs.d/config.org"))
(global-set-key (kbd "C-c e") 'config-visit)

(defun config-reload ()
(interactive)
(org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))
(global-set-key (kbd "C-c r") 'config-reload)

(use-package pdf-tools
  :ensure t)

(setq display-time-24hr-format t)
(display-time-mode 1)

(global-linum-mode t)
(line-number-mode 1)
(column-number-mode 1)

(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package swiper
  :ensure t
  :bind ("C-s" . swiper))

(put 'isearch-backward 'disabled "ISearch is disabled")
(put 'isearch-repeat-backward 'disabled "ISearch is disabled")
(put 'isearch-repeat-forward 'disabled "ISearch is disabled")
(put 'isearch-forward 'disabled "ISearch is disabled")

(setq org-src-window-setup 'current-window)

(use-package org-bullets
:ensure t
:config
(add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

;; (use-package lastpass
;;   :config
;;   ;; Set lastpass user
;;   (setq lastpass-user "pierre.lasorak@gmail.com")
;;   ;; Enable lastpass custom auth-source
;;   (lastpass-auth-source-enable))

(use-package sos
:ensure t)

(use-package nyan-mode
  :ensure t
  :config
  (nyan-mode 1))

(use-package ws-butler
:ensure t
:init)

(use-package exec-path-from-shell
:ensure t
:init
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
)

; deletes all the whitespace when you hit backspace or delete
(use-package hungry-delete
:ensure t
:config
(global-hungry-delete-mode))

(defun switch-to-minibuffer ()
  "Switch to minibuffer window."
  (interactive)
  (if (active-minibuffer-window)
      (select-window (active-minibuffer-window))
    (error "Minibuffer is not active")))

(global-set-key "\C-co" 'switch-to-minibuffer) ;; Bind to `C-c o'

(global-unset-key (kbd "C-w"))
(global-unset-key (kbd "M-w"))
(global-set-key (kbd "M-w") 'kill-region)
(global-set-key (kbd "C-w") 'kill-ring-save)

(setq inhibit-splash-screen t)

(tool-bar-mode -1)

(setq default-directory "~/Dropbox/Sussex_Postdoc")

(put 'upcase-region 'disabled nil)

(setq frame-title-format "%b")

(defalias 'yes-or-no-p 'y-or-n-p)

(use-package smartparens
  :ensure t
  :config
  (use-package smartparens-config)
  (use-package smartparens-html)
  (use-package smartparens-python)
  (use-package smartparens-latex)
  (smartparens-global-mode t)
  (show-smartparens-global-mode t)
  :bind 
  (("C-<down>" . sp-down-sexp)
   ("C-<up>"   . sp-up-sexp)
   ("M-<down>" . sp-backward-down-sexp)
   ("M-<up>"   . sp-backward-up-sexp)
   ("C-k"   . sp-kill-hybrid-sexp)
   ("C-c ("  . wrap-with-parens)
   ("C-c ["  . wrap-with-brackets)
   ("C-c {"  . wrap-with-braces)
   ("C-c '"  . wrap-with-single-quotes)
   ("C-c \"" . wrap-with-double-quotes)
   ("C-c _"  . wrap-with-underscores)
   ("C-c `"  . wrap-with-back-quotes)))

(show-paren-mode 1)
(setq show-paren-delay 0)
(defadvice show-paren-function
    (after show-matching-paren-offscreen activate)
  "If the matching paren is offscreen, show the matching line in the
          echo area. Has no effect if the character before point is not of
          the syntax class ')'."
  (interactive)
  (let* ((cb (char-before (point)))
         (matching-text (and cb
                               (char-equal (char-syntax cb) ?\) )
                               (blink-matching-open))))
      (when matching-text (message matching-text))))

;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(defun copy-file-path ()
    "Put the current file name on the clipboard"
    (interactive)
    (let ((filename (if (equal major-mode 'dired-mode)
                        default-directory
                      (buffer-file-name))))
      (when filename
        (kill-new filename)
        (message "Copied buffer file path '%s' to the clipboard." filename))))
  (defun copy-file-name ()
    "Copy the current buffer file name to the clipboard."
    (interactive)
    (let ((filename (if (equal major-mode 'dired-mode)
                        default-directory
                      (file-name-nondirectory (buffer-file-name)))))

      (when filename
        (kill-new filename)
        (message "Copied buffer file name '%s' to the clipboard." filename))))
(global-set-key (kbd "C-c c p") 'copy-file-path)
(global-set-key (kbd "C-c c n") 'copy-file-name)

(setq outline-minor-mode-prefix "\C-c \C-o") ; Or something else

(setq scroll-step 1)
(setq scroll-conservatively 100)

(setq ring-bell-function 'ignore)

(setq auto-save-default nil)

(when window-system (global-hl-line-mode t))

(put 'narrow-to-region 'disabled nil)

(global-unset-key (kbd "s-f"))
(global-set-key (kbd "s-f") 'toggle-frame-fullscreen)
(global-set-key (kbd "<s-return>") 'toggle-frame-fullscreen)

(use-package beacon
  :ensure t
  :init
  (beacon-mode 1))
(add-hook 'eshell-mode-hook (lambda ()
                                    (setq-local global-hl-line-mode
                                                nil)))
(add-hook 'term-mode-hook (lambda ()
                                    (setq-local global-hl-line-mode
                                                nil)))

(use-package popup-kill-ring
  :ensure t
  :bind ("M-y" . popup-kill-ring))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 10)))
  (setq dashboard-banner-logo-title "Yo Pierre!"))

(use-package mark-multiple
  :ensure t
  :bind ("C-c q" . 'mark-next-like-this))

(use-package expand-region
  :ensure t
  :bind ("C-q" . er/expand-region))

(use-package sudo-edit
  :ensure t
  :bind ("s-e" . sudo-edit))

(require 'tramp)
(add-to-list 'tramp-remote-path "~/global_install/bin/")

(use-package ggtags
:ensure t)
;; :config 
;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
;;               (ggtags-mode 1))))
;; )

(global-subword-mode 1)

(setq-default c-default-style "linux")
(setq-default c-basic-offset 2)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.C\\'" . c++-mode))

(setq-default indent-tabs-mode nil)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode t))
(add-hook 'c++-mode-hook
          (lambda () (setq flycheck-gcc-include-path
                           (list (expand-file-name "/Users/plasorak/Applications/ROOT/include/")))))
(add-hook 'c++-mode-hook
          (lambda () (setq flycheck-clang-include-path
                           (list (expand-file-name "/Users/plasorak/Applications/ROOT/include/")))))

(use-package cmake-mode
  :ensure t)

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(use-package beacon
  :ensure t
  :init
  (beacon-mode 1))

(use-package symon
  :ensure t
  :bind
  ("M-s M-s" . symon-modeq))

(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (setq powerline-default-separator (quote arrow))
  (spaceline-spacemacs-theme))

(use-package diminish
  :ensure t
  :init
  (diminish 'which-key-mode)
  (diminish 'beacon-mode)
  (diminish 'subword-mode))

(setq load-path (cons "/Users/plasorak/Applications/ROOT/" load-path))
(require 'root-help)

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3))


(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)
  (define-key company-active-map (kbd "SPC") #'company-abort))


(use-package company-irony
  :ensure t
  :config
  (require 'company)
  (add-to-list 'company-backends 'company-irony))

(use-package irony
  :ensure t
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(with-eval-after-load 'company
  (add-hook 'c++-mode-hook 'company-mode)
  (add-hook 'c-mode-hook 'company-mode))

(setq irony-additional-clang-options '("-I/Users/plasorak/Applications/ROOT/include"))

(use-package yasnippet
  :ensure t
  :config (use-package yasnippet-snippets
            :ensure t)
  (yas-reload-all))
(add-hook 'c++-mode-hook 'yas-minor-mode 1)
(add-hook 'c-mode-hook 'yas-minor-mode 1)
(add-hook 'python-mode-hook 'yas-minor-mode 1)
(add-hook 'org-mode-hook 'yas-minor-mode 1)

(use-package tex
  :ensure auctex
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq LaTeX-indent-level 4)
  (add-hook 'LaTeX-mode-hook 'visual-line-mode)
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (add-hook 'LaTeX-mode-hook 'yas-minor-mode 1))

(use-package company-math
  :ensure t
  :config
  (add-hook 'LaTeX-mode-hook (lambda ()
                                 (add-to-list 'company-backends 'company-math-symbols-latex)
                                 (add-to-list 'company-backends 'company-latex-commands))))

(eval-after-load 'tex
  '(setq LaTeX-indent-environment-list
           '(("itemize" LaTeX-indent-tabular)
             ("enumerate" LaTeX-indent-tabular)
             ("verbatim" current-indentation)
             ("verbatim*" current-indentation)
             ("tabular" LaTeX-indent-tabular)
             ("tabular*" LaTeX-indent-tabular)
             ("align" LaTeX-indent-tabular)
             ("align*" LaTeX-indent-tabular)
             ("array" LaTeX-indent-tabular)
             ("eqnarray" LaTeX-indent-tabular)
             ("eqnarray*" LaTeX-indent-tabular)
             ("multline" LaTeX-indent-tabular)
             ("displaymath")
             ("equation")
             ("equation*")
             ("picture")
             ("tabbing"))))

(eval-after-load 'tex
  '(progn
     (defun save-compile-latex ()
         "Save and compile latex document"
         (interactive)
         (save-buffer)
         (TeX-command-sequence t t))

     (defun complete-if-no-space ()
         (interactive)
         (let ((cb (string (char-before))))
           (if (or (equal cb " ") (equal (point) (line-beginning-position)))
               (tab-to-tab-stop)
             (TeX-complete-symbol))))

    (add-hook 'LaTeX-mode-hook (lambda ()
          (define-key LaTeX-mode-map (kbd "<f5>") 'save-compile-latex)
          (define-key LaTeX-mode-map (kbd "<f7>") 'preview-clearout-buffer)
          (define-key LaTeX-mode-map (kbd "TAB") 'complete-if-no-space)
          (define-key LaTeX-mode-map (kbd "<tab>") 'complete-if-no-space)))))


(add-hook 'LaTeX-mode-hook (lambda ()
                               (LaTeX-add-environments
                                '("tikzcd" LaTeX-env-label))))
(custom-set-variables 
 '(font-latex-math-environments '("tikzcd" "display" "displaymath"
                                    "equation" "eqnarray" "gather"
                                    "multline"  "align" "alignat"
                                    "xalignat" "dmath")))
;; (eval-after-load 'preview
;;   '(progn
;;     (set-default 'preview-scale-function 1.7)
;;     (set-default 'preview-default-option-list
;;                   '("displaymath" "floats" "graphics" "textmath"))))

(use-package ido
  :ensure t)
(use-package ido-completing-read+
  :ensure t)
(use-package flx-ido
  :ensure t)
(use-package ido-hacks
  :ensure t)

(push ".exe"  completion-ignored-extensions)
(push ".so"   completion-ignored-extensions)
(push ".o"    completion-ignored-extensions)
(push ".dSYM" completion-ignored-extensions)
(push ".pdf"  completion-ignored-extensions)
(push ".root" completion-ignored-extensions)
(push ".png"  completion-ignored-extensions)

;; (custom-set-variables
;;  '(ido-enable-last-directory-history nil)
;;  '(ido-record-commands nil)
;;  '(ido-max-work-directory-list 0)
;;  '(ido-max-work-file-list 0))

(setq ido-enable-prefix nil
      ido-enable-last-directory-history nil
      ido-enable-flex-matching t
      ido-record-commands nil
      ido-max-work-directory-list 0
      ido-max-work-file-list 0
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-max-prospects 10
      ido-save-directory-list-file (expand-file-name "ido.hist")
      ido-everywhere t
      ido-default-file-method 'selected-window
      ido-auto-merge-work-directories-length -1
      ido-ignore-extensions t)
(ido-mode +1)
(ido-ubiquitous-mode +1)

;;; smarter fuzzy matching for ido
(flx-ido-mode +1)
;; disable ido faces to see flx highlights
(setq ido-use-faces nil)

(require 'which-func)
(which-function-mode 1)

(use-package smex
:ensure t
:init (smex-initialize))
(setq smex-save-file (expand-file-name ".smex-items" ))
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(defvar my-term-shell "/bin/zsh")
(defadvice ansi-term (before force-bash)
(interactive (list my-term-shell)))
(ad-activate 'ansi-term)

(global-set-key (kbd "C-x k") 'kill-current-buffer)
(global-unset-key (kbd "s-k"))

(defun kill-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))
(global-set-key (kbd "C-M-s-k") 'kill-all-buffers)

(setq ibuffer-expert t)

(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-x b") 'ido-switch-buffer)

(use-package avy
:ensure t
:bind ("C-;" . avy-goto-char))

(use-package switch-window
:ensure t
:config
 (setq switch-window-input-style 'minibuffer)
 (setq switch-window-increase 4)
 (setq switch-window-threshold 2)
:bind
([remap other-window] . switch-window))

(defun split-and-follow-horizontally ()
(interactive)
(split-window-below)
(other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)
(defun split-and-follow-vertically ()
(interactive)
(split-window-right)
(other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)
(global-unset-key (kbd "s-t"))
(global-set-key (kbd "s-t") 'split-and-follow-vertically)

(defun copy-whole-line ()
(interactive)
(save-excursion
(kill-new
(buffer-substring
(point-at-bol)
(point-at-eol)))))
(global-set-key (kbd "C-c w l") 'copy-whole-line)

(load "~/.emacs.d/fcl-mode.el" nil t t)
(add-to-list 'auto-mode-alist '("\\.fcl$" . art-fhicl-mode))

(load  "~/.emacs.d/interaction-log.el" nil t t)
(require 'interaction-log)
;;(interaction-log-mode +1)
(global-set-key
(kbd "C-c l")
(lambda () (interactive) (display-buffer ilog-buffer-name)))

(use-package magit
:ensure t
)

(require 'ido)
(require 'dired)

(defconst *my-dired-dirs*
    (list (cons "present"  "~/Dropbox/References/MyRef/Postdoc_Sussex_Ref/Presentation")
          (cons "work"     "~/Dropbox/Sussex_Postdoc/")
          (cons "cernhome" "/ssh:lxplus7:~/")
          (cons "np04sw"   "/ssh:lxplus7|ssh:np04-srv-019:/nfs/sw/work_dirs/plasorak2/")
          (cons "fnalapp"  "/ssh:dunegpvm15:/dune/app/users/plasorak")))

(defconst *my-dired-aliases*
    (mapcar (lambda (e) (car e)) *my-dired-dirs*))

(defun my-dired-open-alias ()
"Open dired alias?"
    (interactive)
      (setq alias
            (ido-completing-read "Alias: "
                                 *my-dired-aliases*
                                 nil t))
    (if (and (stringp alias) (> (length alias) 0 ))
        (let ((pair (assoc alias *my-dired-dirs*)))
          (if pair
              (dired (cdr pair))
            (error "Invalid alias %s" alias)))
      (error "Invalid alias %s" alias)))

(global-set-key (kbd "s-d") 'my-dir-open-alias)

(global-unset-key (kbd "s-t"))
  (global-unset-key (kbd "C-t"))
  (global-unset-key (kbd "C-v"))
;; DO NOT UNCOMMENT THIS OTHERWISE EVIL WILL COME ON YOU
;; (and meta will just stop working... :'( )
;;  (global-unset-key (kbd "C-["))

(global-unset-key (kbd "<left>"))
(global-unset-key (kbd "<right>"))
(global-unset-key (kbd "<up>"))
(global-unset-key (kbd "<down>"))

(global-unset-key (kbd "<M-left>"))
(global-unset-key (kbd "<M-right>"))
(global-unset-key (kbd "<M-up>"))
(global-unset-key (kbd "<M-down>"))

(global-unset-key (kbd "C-x <left>"))
(global-unset-key (kbd "C-x <right>"))

(add-hook 'minibuffer-setup-hook
          (lambda ()
            (local-unset-key (kbd "<left>"))
            (local-unset-key (kbd "<right>"))
            (local-unset-key (kbd "<up>"))
            (local-unset-key (kbd "<down>"))))
(add-hook 'ansi-term-hook
          (lambda ()
            (local-unset-key (kbd "<left>"))
            (local-unset-key (kbd "<right>"))
            (local-unset-key (kbd "<up>"))
            (local-unset-key (kbd "<down>"))))
(use-package disable-mouse
:ensure t)
(global-disable-mouse-mode)
