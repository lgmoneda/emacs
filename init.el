;; Package Management
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
     '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
     '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

;Sunday, December 10, 2017
;============================
;==   Package Management   ==
;============================

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
   (package-install 'use-package))

;; Paradox (package-list)
(use-package paradox
    :ensure t)

;Sunday, December 10, 2017
;============================
;== Themes and Aesthetics  ==
;============================

;; Base16-theme, base16-dracula's home 
(use-package base16-theme 
  :ensure t)

;; (use-package dracula-theme
;;   :ensure t)

;; (load-file "~/.emacs.d/elpa/my-dracula-theme-20170412.845/my-dracula-theme.el")
;; (use-package color-theme-sanityinc-tomorrow
;;   :ensure t)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;; Load Theme
;; Themes to use: monokai, deeper-blue and hc-zenburn
;; 'base16-dracula 'base16-gruvbox-dark-medium
;; 'base16-circus
;; 'base16-solarized-dark
;; 'base16-tomorrow-night
;; https://belak.github.io/base16-emacs/
;; moe-dark
;; sanityinc-tomorrow-night
;; sanityinc-solarized-dark
(setq custom-safe-themes t)
(add-hook 'emacs-startup-hook
	  (lambda ()
	    ;; (load-theme 'base16-gruvbox-dark-medium t)
	    ;; (load-theme 'base16-atelier-estuary t)
	    ;; (load-theme 'my-dracula t)
	    ;; (load-theme 'base16-spacemacs)
	    (load-theme 'spacemacs-dark)
	    ))

;; (add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/my-dracula-theme-20170412.845")

(use-package powerline
  :ensure t)

;; Custom faces:
;; Make selected text background #012050
;; Set matching parens background color and bold
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(avy-lead-face ((t (:background "dark gray" :foreground "maroon3" :weight bold))))
 '(avy-lead-face-0 ((t (:background "dark gray" :foreground "maroon3" :weight bold))))
 '(avy-lead-face-1 ((t (:background "dark gray" :foreground "maroon3" :weight bold))))
 '(avy-lead-face-2 ((t (:background "dark gray" :foreground "maroon3" :weight bold))))
 '(company-tooltip-search ((t (:inherit highlight :background "steel blue"))))
 '(company-tooltip-search-selection ((t (:background "steel blue"))))
 '(diff-hl-change ((t (:background "#3a81c3"))))
 '(diff-hl-delete ((t (:background "#ee6363"))))
 '(diff-hl-insert ((t (:background "#7ccd7c"))))
 '(ein:cell-input-area ((t (:background "black"))))
 '(lazy-highlight ((t (:foreground "white" :background "SteelBlue"))))
 '(org-ellipsis ((t (:foreground "#969896" :underline nil))))
 '(org-hide ((t (:background "#292b2e" :foreground "#292b2e"))))
 '(region ((t (:background "#4C516D" :foreground "#00ff00"))))
 '(show-paren-match ((t (:background "#5C888B" :weight bold)))))

;Sunday, December 10, 2017
;============================
;==  Open File Shortcuts   ==
;============================

;; Fast init.el open
(global-set-key (kbd "<f6>") (lambda() (interactive)(find-file "~/.emacs.d/init.el")))
;; Open todo.org
(global-set-key (kbd "<f10>") (lambda() (interactive)(find-file "~/Dropbox/Agenda/todo.org")))
;; Open agenda
(global-set-key (kbd "C-<f10>") (lambda() (interactive)(org-agenda nil "d")))
;; Open day
(setq org-agenda-span 'day)
(global-set-key (kbd "C-c <f10>") (lambda() (interactive)(org-agenda 0 "a")))
(global-set-key (kbd "M-<f10>") (lambda() (interactive)(org-agenda 0 "l")))

;; Save place
;; Start from the last place you were in a file the next time you visit it
;; It's a emacs24.5 or older way to do it
;; (require 'saveplace)
;; (setq-default save-place t)
;; For emacs 25+
(save-place-mode 1) 
(setq save-place-file "~/.emacs.d/saveplace.log")

;; Fast jump to elisp function
;; In Debian derived distros, the package emacs24 or similar
;; does not include the source elisp code, you need it to
;; jump to the definition (.el or .el.gz files). To download it
;; install emacs24-el package.
(defun lgm/describe-func ()
  (interactive)
  (describe-function (function-called-at-point)))

(defun lgm/jump-to-elisp-func-def ()
  (interactive)
  (find-function (function-called-at-point))
  ) 

(global-set-key (kbd "C-h C-j") 'lgm/jump-to-elisp-func-def)
(global-set-key (kbd "C-h C-f") 'lgm/describe-func)

;; Garbage Collector teste
(setq gc-cons-threshold 20000000)

;; Adjusting Mouse sensitivity
(setq mouse-wheel-progressive-speed nil)

;; Let Elisp be less conservative
(setq max-specpdl-size (* 15 max-specpdl-size))
(setq max-list-eval-depth (* 15 max-lisp-eval-depth))

;; Move cursor after split
(global-set-key "\C-x2" (lambda () (interactive)(split-window-vertically) (other-window 1)))
(global-set-key "\C-x3" (lambda () (interactive)(split-window-horizontally) (other-window 1)))

;; Do not centralize cursor
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)

;; Save command history
(savehist-mode)

;; Better shell buffer behavior
(use-package shell-pop
 :ensure t
 :init (defalias 'sp 'shell-pop))

;; Writeroom, a focus mode!
(use-package writeroom-mode
  :ensure t)

;; Magit
(use-package magit
  :ensure t
  :init
  ;; Auto revert buffers when change branches
  (global-auto-revert-mode 1)
  (setq auto-revert-check-vc-info t))

;; Git-timemachine
(use-package git-timemachine
  :ensure t)

;; Dash
(use-package dash
  :ensure t)

;; Helm
(use-package helm
  :ensure t)

;; Try
(use-package try
  :ensure t)

;; Expand-region
(use-package expand-region
	     :ensure t)

;; Smart Mode line
(use-package smart-mode-line
    :config
  (setq sml/no-confirm-load-theme t)
  (setq sml/theme 'respectful)
  ;; (setq sml/theme 'dark)
  (sml/setup))

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(use-package diminish
    :config
  (eval-after-load "hideshow" '(diminish 'hs-minor-mode))
  (eval-after-load "undo-tree" '(diminish 'undo-tree-mode))
  (eval-after-load "simple" '(diminish 'overwrite-mode))
  (eval-after-load "autorevert" '(diminish 'auto-revert-mode)))

;; Rainbow delimiters in Elisp mode 
(use-package rainbow-delimiters
  :ensure t
  :config (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode))

;; thing-cmd
(use-package thing-cmds
  :ensure t)

;; Anzu shows total matchs for searchs
(use-package anzu 
	     :ensure t
	     :config (global-anzu-mode))

;Monday, September 18, 2017
;============================
;==          Ivy           ==
;============================

(use-package ivy
	     :ensure t
	     :init 
	     (ivy-mode 1)
	     (setq ivy-initial-inputs-alist nil)
	     ;; (setq ivy-use-virtual-buffers t)
	     ;; (setq enable-recursive-minibuffers t)

	     (setq ivy-re-builders-alist
		   '((ivy-switch-buffer . ivy--regex-plus)
		     (t . ivy--regex-fuzzy)))

	     (setq ivy-use-virtual-buffers t)
	     (setq ivy-count-format "(%d/%d) ")

	     ;; Use C-j for immediate termination with the current value, and RET
	     ;; for continuing completion for that directory. This is the ido
	     ;; behaviour.
	     (define-key ivy-minibuffer-map (kbd "C-j") #'ivy-immediate-done)
	     (define-key ivy-minibuffer-map (kbd "RET") #'ivy-alt-done)
	     )

(use-package counsel
	     :ensure t
	     :init (counsel-mode)
	     (global-set-key (kbd "M-X") 'counsel-M-x)
	     ;; (global-set-key (kbd "C-s") 'swiper)
	     (global-set-key (kbd "M-x") 'counsel-M-x)
	     (global-set-key (kbd "C-x C-f") 'counsel-find-file)
	     (global-set-key (kbd "<f1> f") 'counsel-describe-function)
	     (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
	     (global-set-key (kbd "<f1> l") 'counsel-find-library)
	     (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
	     (global-set-key (kbd "<f2> u") 'counsel-unicode-char)

	     :bind
	     ;; Use ivy to search the kill-ring, but
	     ;; keep the previous behavior
	     (("M-y" . counsel-yank-pop)
		    :map ivy-minibuffer-map
		    ("M-y" . ivy-next-line-and-call))
	     )

(use-package counsel-projectile
	     :ensure t
	     :init
	     (counsel-projectile-mode))
;; imenu-anywhere
;; Changes the C-c C-j behavior
(use-package imenu-anywhere
  :ensure t
  :init (imenu-anywhere))

;; Ag (search)
(use-package ag
  :ensure t)

;; Smex
(use-package smex
  :ensure t
  :init (smex-initialize)
  :config
  ;; Using counsel now
  ;;(global-set-key (kbd "M-X") 'smex)
  ;;(global-set-key (kbd "M-X") 'smex-major-mode-commands)
  ;; This is your old M-x.
  ;;(global-set-key (kbd "M-x") 'execute-extended-command)
  )

;; Projectile
(use-package projectile
  :ensure t
  :init (projectile-global-mode)
  ;; Smart Mode Line already displays project name
  ;; :config (setq projectile-mode-line'(:eval (format " P[%s]" (projectile-project-name))))
  :config (setq projectile-mode-line'(:eval (format "" (projectile-project-name))))
  :bind (("C-c p s" . projectile-ag)
         ("C-c p g" . projectile-grep)))

;; Auto-complete
(use-package auto-complete
  :ensure t)

;; Neotree
(use-package neotree
  :ensure t
  :bind ([f8] . neotree-toggle))

;Wednesday, August 23, 2017
;============================
;==         Scala          ==
;============================

(use-package scala-mode
  :interpreter
  ("scala" . scala-mode))

(add-hook 'scala-mode-hook (lambda () (setq tab-width 4)))

(cond ( (string-equal system-type "darwin")
    (progn (setq sbt:program-name "/usr/local/bin/sbt")
    (use-package ensime
      :ensure t
      :init
    (add-hook 'scala-mode-hook 'ensime-mode-hook)
      (setq
      ensime-sbt-command "/usr/local/bin/sbt"
      sbt:program-name "/usr/local/bin/sbt")
      )
    (setq ensime-exec-path "/usr/local/bin/sbt")
    )

    )

      ((string-equal system-type "gnu/linux")
	(setq sbt:program-name "/usr/bin/sbt")
	(use-package ensime
	  :ensure t
	  :init
	(add-hook 'scala-mode-hook 'ensime-mode-hook)
	  (setq
	  ensime-sbt-command "/usr/bin/sbt"
	  sbt:program-name "/usr/bin/sbt")
	)
	(setq ensime-exec-path "/usr/bin/sbt")
       )
      )

(defun scala-run () 
    (interactive)   
   (ensime-sbt-action "run")
   (ensime-sbt-action "~compile")
(let ((c (current-buffer)))
    (switch-to-buffer-other-window
   (get-buffer-create (ensime-sbt-build-buffer-name)))
 (switch-to-buffer-other-window c))) 
 (setq exec-path
(append exec-path (list ensime-exec-path))) ;;REPLACE THIS with the directory of your scalac executable!

(setq ensime-startup-snapshot-notification nil)
(setq ensime-eldoc-hints 'all)

;; Anaconda Anaconda+Eldoc
(use-package anaconda-mode
    :ensure t
    :diminish anaconda-mode
    :config
    (add-hook 'python-mode-hook 'anaconda-mode)
    (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
    (add-hook 'python-mode-hook 'python--add-debug-highlight)
    )

;; Column enforce
(use-package column-enforce-mode
	     :ensure t
	     :config
	     ;;(add-hook 'python-mode-hook 'column-enforce-mode)
	     )

;; Company-anaconda
(use-package company-anaconda
  :ensure t
  :diminish
  :config
  (eval-after-load "company"
     '(add-to-list 'company-backends '(company-anaconda company-capf))))
    ;;'(add-to-list 'company-backends '(company-anaconda company-dabbrev))))

(add-hook 'python-mode-hook 'company-mode)

;; Enable eldoc in your programming modes
(use-package eldoc
  :ensure t
  :diminish 
  :commands eldoc-mode
  :init
  (setq eldoc-idle-delay 0.1
	eldoc-echo-area-use-multiline-p nil)
  (eldoc-mode 1)
  :config
  (add-hook 'prog-mode-hook 'turn-on-eldoc-mode))

;; Enable hide definitions functions
(add-hook 'prog-mode-hook 'hs-minor-mode)
(global-set-key [f4] 'hs-toggle-hiding)

(use-package company
  :ensure t
  :diminish
  :defer 4
  :init (progn
          (global-company-mode)
          (setq company-global-modes '(not python-mode cython-mode sage-mode ein:notebook-modes org-mode markdown-mode))
          )
  :config (progn
            (setq company-tooltip-limit 12 
                  company-idle-delay 1.0
                  company-echo-delay 0.5
                  company-begin-commands '(self-insert-command  self-insert-command org-self-insert-command orgtbl-self-insert-command c-scope-operator c-electric-colon c-electric-lt-gt c-electric-slash )
                  company-transformers '(company-sort-by-occurrence)
                  company-selection-wrap-around t
                  company-minimum-prefix-length 2
                  company-dabbrev-downcase nil
		  company-require-match nil
                  )
;;	    (bind-keys :map company-mode-map
;;		       ("<tab>" . company-complete))
            (bind-keys :map company-active-map
		       ("C-s" . company-filter-candidates)
                       ("C-n" . company-select-next)
                       ("C-p" . company-select-previous)
		       ("C-d" . company-quickhelp-manual-begin)
                       ;;("C-d" . company-show-doc-buffer)
                       ("<tab>" . company--insert-candidate)
                       ("<escape>" . company-abort)
                       )
            )
  )

;; I don't want to see the error buffer
(remove-hook 'anaconda-mode-response-read-fail-hook
             'anaconda-mode-show-unreadable-response)

(use-package company-flx
  :ensure t)

(with-eval-after-load 'company
  (company-flx-mode +1))

;; Pop documentation help for Company
;; M-x customize-group <RET> company-quickhelp <RET>
(use-package company-quickhelp
  :ensure t
  ;; To see doc just press C-d in company candidate
  :init (company-quickhelp-mode 0)
  :config
  (eval-after-load 'company
  '(define-key company-active-map (kbd "C-d") #'company-quickhelp-manual-begin)))

;; Not so useful, but eventually...
(use-package helm-company
  :ensure t
  :config (eval-after-load 'company
  '(progn
     ;;(define-key company-mode-map (kbd "C-:") 'helm-company)
     (define-key company-active-map (kbd "C-:") 'helm-company))))

;; Pair parenthesis
(use-package smartparens
  :ensure t
  :init (smartparens-global-mode)
  (sp-pair "'" nil :actions :rem)
  (sp-pair "`" nil :actions :rem)
  :config
  ;; Now i can express sadness in erc-mode 
  (sp-local-pair 'erc-mode "(" nil :actions nil))

;; Smartparens keyibinding management
;; Sexp is a Symbolic Expression, something like (+ 40 2)

;; Big jump, jumps the outer ()
(define-key smartparens-mode-map (kbd "C-M-f") 'sp-forward-sexp)
(define-key smartparens-mode-map (kbd "C-M-b") 'sp-backward-sexp)

;; Enter the next at beginning ()
(define-key smartparens-mode-map (kbd "C-M-d") 'sp-down-sexp)
;; Enter the last sexp at end
(define-key smartparens-mode-map (kbd "C-M-a") 'sp-backward-down-sexp)
;; Goes to the begining of the current sexp you're in
(define-key smartparens-mode-map (kbd "C-S-d") 'sp-beginning-of-sexp)
;; (define-key smartparens-mode-map (kbd "C-S-a") 'sp-end-of-sexp)

(define-key smartparens-mode-map (kbd "C-M-e") 'sp-up-sexp)
(define-key smartparens-mode-map (kbd "C-M-u") 'sp-backward-up-sexp)
;; Changes position under cursor element with the next
(define-key smartparens-mode-map (kbd "C-M-t") 'sp-transpose-sexp)


(define-key smartparens-mode-map (kbd "C-M-n") 'sp-next-sexp)
(define-key smartparens-mode-map (kbd "C-M-p") 'sp-previous-sexp)

(define-key smartparens-mode-map (kbd "C-M-k") 'sp-kill-sexp)
(define-key smartparens-mode-map (kbd "C-M-w") 'sp-copy-sexp)


;; (define-key smartparens-mode-map (kbd "M-<delete>") 'sp-unwrap-sexp)
;; (define-key smartparens-mode-map (kbd "M-<backspace>") 'sp-backward-unwrap-sexp)

;; (define-key smartparens-mode-map (kbd "C-<right>") 'sp-forward-slurp-sexp)
;; (define-key smartparens-mode-map (kbd "C-<left>") 'sp-forward-barf-sexp)
;; (define-key smartparens-mode-map (kbd "C-M-<left>") 'sp-backward-slurp-sexp)
;; (define-key smartparens-mode-map (kbd "C-M-<right>") 'sp-backward-barf-sexp)

;; (define-key smartparens-mode-map (kbd "M-D") 'sp-splice-sexp)
;; (define-key smartparens-mode-map (kbd "C-M-<delete>") 'sp-splice-sexp-killing-forward)
;; (define-key smartparens-mode-map (kbd "C-M-<backspace>") 'sp-splice-sexp-killing-backward)
;; (define-key smartparens-mode-map (kbd "C-S-<backspace>") 'sp-splice-sexp-killing-around)


(define-key smartparens-mode-map (kbd "C-]") 'sp-select-next-thing-exchange)
(define-key smartparens-mode-map (kbd "C-<left_bracket>") 'sp-select-previous-thing)
(define-key smartparens-mode-map (kbd "C-M-]") 'sp-select-next-thing)

(define-key smartparens-mode-map (kbd "M-F") 'sp-forward-symbol)
(define-key smartparens-mode-map (kbd "M-B") 'sp-backward-symbol)

;; ?
(--each '(python-mode python)
  (eval-after-load it '(require 'smartparens-python)))

;; Display time in the mode-line
(setq display-time-format "%Hh%M ")
(setq display-time-default-load-average nil)
;; Hide the "MAIL" from mode-line

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-quickhelp-color-background "dark slate gray")
 '(company-quickhelp-color-foreground "wheat")
 '(display-time-mail-string "")
 '(ein:use-auto-complete t t)
 '(ein:use-auto-complete-superpack t t)
 '(markdown-command "/usr/bin/pandoc")
 '(package-selected-packages
   (quote
    (spacemacs-theme lsp-typescript sml-mode org-wild-notifier org-notify cider clj-refactor clojure-mode go-mode org-super-agenda org-alert color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized sanityinc-color-theme power-line docker helm-tramp docker-tramp powerline 0blayout counsel-projectile counsel ivy exec-path-from-shell auctex default-text-scale org-gcal ess slack ensime writeroom-mode writeroom darkroom column-enforce-mode org-bullets latex-preview-pane scheme-complete quack org-dashboard org-journal restclient pyimport electric-operator multi diff-hl avy markdown-preview-mode markdown-mode ein beacon which-key highlight-current-line multiple-cursors smartparens helm-company company-quickhelp company-flx company-anaconda anaconda-mode neotree auto-complete projectile smex ag imenu-anywhere flx-ido ido-vertical-mode anzu thing-cmds rainbow-delimiters expand-region try helm magit base16-theme paradox use-package spinner monokai-theme hydra)))
 '(paradox-github-token t)
 '(region ((t (:background "#102050" :foreground "#FFFFFF"))))
 '(show-paren-match ((t (:weight (quote extra-bold)))))
 '(spacemacs-theme-comment-bg nil)
 '(spacemacs-theme-comment-italic t))
;;(display-time-mode 1)

;; Show time in mode-line when using Emacs in fullscreen,
;; avoiding using it three days in a row without sleeping
(global-set-key (kbd "<f9>") (lambda()
				(interactive)
				(toggle-frame-fullscreen)
				;; In MacOS it takes a while to update frame params
				(sit-for 1)
				;; Now it works with multiple screens :)
				(if (eq (cdr (assoc 'fullscreen (frame-parameters))) 'fullboth)
				;; (if (eq display-time-mode nil)
				    (display-time-mode 1)
				    (display-time-mode 0))
				))

;; To activate nupy environment
(defun anupy ()
  (interactive)
  (pythonic-activate "~/miniconda2/envs/nupy")
  )

;; Check if i'm at work and activate
;; the right environment
(defun activate-work-env ()
  (if (string= (system-name) "rc530")
      (pythonic-activate "~/miniconda2/envs/ml")
      )
  (if (string-match "lgmac" (system-name))
      (pythonic-activate "~/miniconda2/envs/ml3")
      )
  )

(activate-work-env)

;; Multiple cursors
;; First mark the word, then add more cursors
;; If you want to insert a new line in multiple cursors mode, use C-j
(use-package multiple-cursors
  :ensure t
  :bind
  (("C->" . mc/mark-next-like-this)
   ("C-<" . mc/mark-previous-like-this)
   ("C-c C->" . mc/mark-all-like-this)
   ("C-x , m" . mc/edit-lines)
   ("C-x , n" . mc/edit-ends-of-lines)))

;; Some initial confis
;; UTF-8 please
(setq locale-coding-system 'utf-8) 
(set-terminal-coding-system 'utf-8) 
(set-keyboard-coding-system 'utf-8) 
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(setq  truncate-lines nil
       inhibit-startup-screen t
       initial-scratch-message ""
       fill-column 80)

;; Highligh current line! 
(use-package highlight-current-line
  :ensure t
  :config (highlight-current-line-on t)
  (set-face-background 'highlight-current-line-face "black")
  )

;; Replace highlighted text
(delete-selection-mode 1)


;; Make annoying yes or no less annoying
(defalias 'yes-or-no-p 'y-or-n-p)

;; Global visual line
(global-visual-line-mode t)
(diminish 'visual-line-mode)

;; Hiding menu, tool bar and scroll bar
(menu-bar-mode -99)
(tool-bar-mode -99)
(scroll-bar-mode -1)

;; More thinner window divisions
(fringe-mode '(4 . 3))

;; Outside border to make it better in fullscreen mode
(add-to-list 'default-frame-alist '(internal-border-width . 2))

;; Enable paren mode at start
(show-paren-mode 1)
;;Highlights the whole expression
;;(setq show-paren-style 'expression)

;; Enable line numbers
(global-linum-mode 0)

;; Defining switch tabs commands
(global-set-key [C-iso-lefttab] 
    (lambda ()
      (interactive)
      (other-window -1)))

;; MacOS version
(global-set-key (kbd "C-S-<tab>") 
    (lambda ()
      (interactive)
      (other-window -1)))

;; Defining switch tabs commands
(global-set-key [C-tab] 
    (lambda ()
      (interactive)
      (other-window 1)))

;; Defining switch buffer command
(global-set-key (kbd "C-1")
    (lambda ()
      (interactive)
      (switch-to-prev-buffer)))

;; Defining switch buffer command
(global-set-key (kbd "C-'")
    (lambda ()
      (interactive)
      (bury-buffer)))

;; Defining switch frames command
(global-set-key (kbd "C-2")
    (lambda ()
      (interactive)
      (other-frame 1)))

;; Tryng to save my hand
(global-set-key (kbd "C-0")
    (lambda ()
      (interactive)
      (other-frame 1)))

;; Initialize in full screen
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(put 'upcase-region 'disabled nil)

;; Which-key minor mode
(use-package which-key
  :ensure t
  :init (which-key-mode))

;;Turn the system sound off
(setq ring-bell-function 'ignore)

; Set cursor color 
(set-cursor-color "##ea51b2")

;;Beacon minor mode
(use-package beacon
  :ensure t
  :diminish beacon-mode
  :init (beacon-mode 0)
        ;; For deeper-blue theme
        ;; (setq beacon-color "#00ff00")
        ;; For monokai theme
        ;;(setq beacon-color "#AE81FF")
	;; base16-dracula
        (setq beacon-color "#ea51b2")
	;; gru-dark-medium
        ;; (setq beacon-color "#fb4934")
        ;; base16-circus
  	;; (setq beacon-color "#dc657d")
        ;; (setq beacon-size 300)
	;; (setq beacon-blink-delay 3)
	)

;; Emacs Ipython Notebook
(use-package ein
  :ensure t
  :init ;; (setq ein:use-auto-complete t)
;;  (setq ein:use-smartrep t)
  (setq auto-complete-mode t)
  (setq ein:output-type-prefer-pretty-text-over-html t)
  ;; (setq ein:output-type-preference
  ;; 	'(emacs-lisp image image/png svg image/svg image/png jpeg image/jpeg text html text/html latex text/latex javascript))
  )

;; (setq ein:use-auto-complete-superpack t)
;;(setq ein:use-smartrep t)

(setq ein:notebook-modes '(ein:notebook-multilang-mode ein:notebook-python-mode))

;; Hide your password when prompted
(require 'comint)
(setq comint-password-prompt-regexp
		    (concat comint-password-prompt-regexp
			    "\\|^Password for .*:\\s *\\'"))

;; Markdown mode and preview
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; Use M-x markdown-preview-mode in a md buffer
(use-package markdown-preview-mode
  :ensure t)

;; avy
(use-package avy
  :ensure t)

(global-set-key (kbd "C-:") 'avy-goto-char-timer)
(global-set-key (kbd "C-x C-a") 'avy-goto-char)
(global-set-key (kbd "C-x a") 'avy-goto-char-timer)
(global-set-key (kbd "C-?") 'avy-goto-line)

;; Show differences between local and repo
(use-package diff-hl
  :ensure t
  :init
  (setq diff-hl-side 'left)
  :config
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
  (diff-hl-flydiff-mode)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  (global-diff-hl-mode)

  ;; defining the custom colors to the diff-hl

  (custom-set-faces
   '(diff-hl-change ((t (:background "#3a81c3"))))
   '(diff-hl-insert ((t (:background "#7ccd7c"))))
   '(diff-hl-delete ((t (:background "#ee6363"))))))

;; Show in mode line info about current func body
;; It's only enabled in python-mode
;; (use-package which-func
;;   :ensure t
;;   :config
;;   (setq which-func-modes '(python-mode))
;;   (add-hook 'python-mode-hook '(lambda () (which-function-mode t))))

;; Add Hydra
(use-package hydra
  :ensure t)

;; custom package
;; load the custom helm-spotify-plus
(use-package multi
  :ensure t)

(load-file "~/repos/helm-spotify-plus/helm-spotify-plus.el")

;; Helm-spotify-plus key binds 
(global-set-key (kbd "C-c C-s") 'helm-spotify-plus)
(defhydra hydra-spotify (global-map "C-c s")
  "helm-spotify-plus"
 ("s" helm-spotify-plus)
 ("f" helm-spotify-plus-next)
 ("b" helm-spotify-plus-previous)
 ("p" helm-spotify-plus-play)
 ("g" helm-spotify-plus-pause))

;; Highlight matching tags
(load-file "~/.emacs.d/others/hl-tags-mode/hl-tags-mode.el")
(require 'hl-tags-mode)
(add-hook 'sgml-mode-hook (lambda () (hl-tags-mode)))
(add-hook 'html-mode-hook (lambda () (hl-tags-mode)))
(add-hook 'nxml-mode-hook (lambda () (hl-tags-mode)))

;; Disable auto-save
(setq auto-save-default nil)
;; Disable backup
(setq backup-inhibited t)

;; Python
(require 'python)
(defun python--add-debug-highlight ()
  "Adds a highlighter for use by `python--pdb-breakpoint-string'"
  (highlight-lines-matching-regexp "## DEBUG ##\\s-*$" 'hi-red-b))

(add-hook 'python-mode-hook 'python--add-debug-highlight)

(defvar python--pdb-breakpoint-string "import pdb; pdb.set_trace() ## DEBUG ##"
  "Python breakpoint string used by `python-insert-breakpoint'")

(defun python-insert-breakpoint ()
  "Inserts a python breakpoint using `pdb'"
  (interactive)
  (back-to-indentation)
  ;; this preserves the correct indentation in case the line above
  ;; point is a nested block
  (split-line)
  (insert python--pdb-breakpoint-string))
(define-key python-mode-map (kbd "<f5>") 'python-insert-breakpoint)

(defadvice compile (before ad-compile-smart activate)
  "Advises `compile' so it sets the argument COMINT to t
if breakpoints are present in `python-mode' files"
  (when (derived-mode-p major-mode 'python-mode)
    (save-excursion
      (save-match-data
        (goto-char (point-min))
        (if (re-search-forward (concat "^\\s-*" python--pdb-breakpoint-string "$")
                               (point-max) t)
            ;; set COMINT argument to `t'.
            (ad-set-arg 1 t))))))

;; Insert a execution time print
(defun lgm/insert-timer()
  (interactive)
  (save-excursion 
   (back-to-indentation)
   (split-line)
   (insert "from time import time; start = time() ## Timing from here")
   (next-line)
   (insert "print('Execution time: {0}m{1}s'.format(int((time()-start)/60), int((time()-start)%60 )))"))
  )

(define-key python-mode-map (kbd "<f4>") 'lgm/insert-timer)


;; Run python and pop-up its shell.
;; Kill process to solve the reload modules problem.
(defun my-python-shell-run ()
  (interactive)
  (when (get-buffer-process "*Python*")
     (set-process-query-on-exit-flag (get-buffer-process "*Python*") nil)
     (kill-process (get-buffer-process "*Python*"))
     ;; If you want to clean the buffer too.
     ;;(kill-buffer "*Python*")
     ;; Not so fast!
     (sleep-for 0.5)
     )
  (run-python (python-shell-parse-command) nil nil)
  (python-shell-send-buffer)
  ;; Pop new window only if shell isn't visible
  ;; in any frame.
  (unless (get-buffer-window "*Python*" t) 
    (python-shell-switch-to-shell)
    )
 )

(defun my-python-shell-run-region ()
  (interactive)
  (python-shell-send-region (region-beginning) (region-end))
  (python-shell-switch-to-shell)
  )

(eval-after-load "python"
  '(progn
     (define-key python-mode-map (kbd "C-c C-c") 'my-python-shell-run)
     (define-key python-mode-map (kbd "C-c C-r") 'my-python-shell-run-region)
     (define-key python-mode-map (kbd "C-h f") 'python-eldoc-at-point)
     ))

;; Trying to make TAB great again
(defun indent-or-complete ()
  "Complete if point is at end of a word, otherwise indent line."
  (interactive)
  (if (looking-at "\\>")
      (dabbrev-expand nil)
    (indent-for-tab-command)
    ))

(defun smart-tab ()
  "This smart tab is minibuffer compliant: it acts as usual in
    the minibuffer. Else, if mark is active, indents region. Else if
    point is at the end of a symbol, expands it. Else indents the
    current line."
  (interactive)
  (if (minibufferp)
      (unless (minibuffer-complete)
	(dabbrev-expand nil))
    (if mark-active
	(indent-region (region-beginning)
		       (region-end))
      (if (looking-at "\\_>")
	  (dabbrev-expand nil)
	(indent-for-tab-command)))))

(defun my-smart-tab ()
  "This smart tab is minibuffer compliant: it acts as usual in
    the minibuffer. Else, if mark is active, indents region. Else if
    point is at the end of a symbol, expands it. Else indents the
    current line."
  (interactive)
  (if (minibufferp)
      (unless (minibuffer-complete)
	(dabbrev-expand nil))
   (if mark-active
	(python-indent-shift-right (region-beginning)
		       (region-end))
      (if (looking-at "\\_>")
	  (dabbrev-expand nil)
	(indent-for-tab-command)))))

(defun my-smart-backtab ()
  (interactive)
  (if mark-active
      (python-indent-shift-left (region-beginning)
				 (region-end))
    (if (looking-at "\\_>")
	(dabbrev-expand nil)
      (python-indent-dedent-line))))

;;(define-key python-mode-map (kbd "TAB") 'indent-or-complete)
(define-key python-mode-map (kbd "TAB") 'my-smart-tab)
(define-key python-mode-map (kbd "<backtab>") 'my-smart-backtab)

;; Maybe it's a good idea to use it in all prog modes 
(define-key prog-mode-map (kbd "TAB") 'my-smart-tab)
(define-key prog-mode-map (kbd "<backtab>") 'my-smart-backtab)

(define-key markdown-mode-map (kbd "TAB") 'indent-or-complete)

;; Put white spaces between operators in Python
(use-package electric-operator
  :ensure t
  :config (add-hook 'python-mode-hook #'electric-operator-mode))

;; Warning about imports in python
;; Requires pyflakes
;; M-x pyimport-remove-unused
;; M-x pyimport-insert-missing
;; https://github.com/Wilfred/pyimport
(use-package pyimport
  :ensure t)

(define-key python-mode-map (kbd "C-c C-i") #'pyimport-insert-missing)

;; Test http rest webservices inside emacs
;; https://github.com/pashky/restclient.el
(use-package restclient
  :ensure t)

;;(define-key company-mode-map (kbd "TAB") 'company-complete-common)

;;Tuesday, August 15, 2017
;;============================
;;==          ERC           ==
;;============================
;; (add-to-list 'load-path "~/.emacs.d/elisp/erc-extras" t)

;; ;; Trying to display nicely
;; (erc-spelling-mode 1)
;; (add-hook 'erc-mode-hook (lambda () (auto-fill-mode 0)))
;; (make-variable-buffer-local 'erc-fill-column)
;;  (add-hook 'window-configuration-change-hook 
;; 	   '(lambda ()
;; 	      (save-excursion
;; 	        (walk-windows
;; 		 (lambda (w)
;; 		   (let ((buffer (window-buffer w)))
;; 		     (set-buffer buffer)
;; 		     (when (eq major-mode 'erc-mode)
;; 		       (setq erc-fill-column (- (window-width w) 2)))))))))


;; (when (assoc "en0" (network-interface-list))
;;   (erc :server "irc.freenodenet" :port 6667 :nick "lgmoneda"))


;; (progn
;;      (require 'erc)
;;      (require 'erc-track)
;;      (erc-track-mode +1)

;;      ;; keywords to track
;;      (setq erc-keywords '("bayes" "reinforcement" "unsupervised" "bayesian"))

;;      ;; Ignore Server Buffer
;;      (setq erc-track-exclude-server-buffer t)

;;      ;; show only when my nickname is mentioned in any channel
;;      (setq erc-current-nick-highlight-type 'nick)
;;      (setq erc-track-exclude-types '("JOIN" "PART" "QUIT" "NICK" "MODE"))
;;      (setq erc-track-use-faces t)
;;      (setq erc-track-faces-priority-list
;;            '(erc-current-nick-face
;;              erc-keyword-face
;;              erc-direct-msg-face))
;;      (setq erc-track-priority-faces-only 'all))

;; (load "~/.ercfile")
;; (require 'erc-services)
;; (erc-services-mode 1)
;; (setq erc-prompt-for-nickserv-password nil)
;; (setq erc-nickserv-passwords
;;       `((freenode (("lgmoneda" . ,lgmonedanick)))))

;; ;; Prevents Erc buffers flashing at start
;; (erc-autojoin-mode t)
;; (setq erc-autojoin-timing :ident)
;; (setq erc-autojoin-delay 40)
;; (setq erc-join-buffer 'bury)
;; (setq erc-autojoin-channels-alist
;;       '(("freenode.net" "#emacs" "#sptk" "##machinelearning"
;; 	 "#scikit-learn" "#tensorflow")))

;; (erc-autojoin-after-ident "irc.freenode.net" "lgmoneda")

;; (add-hook 'erc-nickserv-identified-hook 'erc-autojoin-after-ident)

;; ;; Log in a buffer when people talk to me
;; (setq erc-log-matches-flag t)
;; (setq erc-log-matches-types-alist
;;           '((keyword . "### Keywords Log ###")
;;             (current-nick . "### Me Log ###")))

;; ;; Prevent the new created buffer from pvt to be brought visible
;; (setq erc-auto-query 'bury)

;; ;; Both defadvices to track pvts using channels mode-line face
;; (defadvice erc-track-find-face (around erc-track-find-face-promote-query activate)
;;   (if (erc-query-buffer-p) 
;;       (setq ad-return-value (intern "erc-current-nick-face"))
;;     ad-do-it))

;; (defadvice erc-track-modified-channels (around erc-track-modified-channels-promote-query activate)
;;   (if (erc-query-buffer-p) (setq erc-track-priority-faces-only 'nil))
;;   ad-do-it
;;   (if (erc-query-buffer-p) (setq erc-track-priority-faces-only 'all)))

;; (require 'erc-nicklist)
;; ;; bk's toggle nicklist!
;; (defun bk/nicklist-toggle ()
;;   "Function to toggle the nicklist in ERC mode."
;;   (interactive)
;;   (let ((nicklist-buffer-name (format " *%s-nicklist*" (buffer-name))))
;;     (if (get-buffer nicklist-buffer-name)
;;         (kill-buffer nicklist-buffer-name)
;;       (erc-nicklist))))

;; (define-key erc-mode-map (kbd "<f7>") 'bk/nicklist-toggle)

;; Smarter beep
;; Remember to apt-get install mplayer!
;; todo: no beep when buffer is visible
(add-hook 'erc-text-matched-hook 'erc-sound-if-not-server)
(defun erc-sound-if-not-server (match-type nickuserhost msg)
  (unless (or
	   (string-match "Serv" nickuserhost)
	   (string-match nickuserhost (erc-current-nick))
	   (string-match "Server" nickuserhost))
	(when (string= match-type "current-nick")
	(start-process-shell-command "lolsound" nil "mplayer ~/.emacs.d/sounds/icq-message.wav"))
	;;(setq mode-line-end-spaces
        ;; to-do use message-truncate-lines or messages-buffer-max-lines

       	(message
	      (format "[%s|<%s:%s> %s]"
	      	      (format-time-string "%Hh%M" (date-to-time (current-time-string)))
	      	      (subseq nickuserhost 0 (string-match "!" nickuserhost))
		      (or (erc-default-target) "")
		      (subseq msg 0 (- (length msg) 1))
		      ;; (if (eq (string-match (erc-current-nick) msg) 0)
		      ;; 	  (subseq msg (+ 1 (length (erc-current-nick))) 40)
		      ;; 	  msg
		      ;; 	  )
		      )
	      ;; Show msg for 20s
	       (run-with-timer 20 nil
                  (lambda ()
                    (message nil)))
	      )))

;; E-mail config
(setq user-mail-address "lg.moneda@gmail.com")
(setq user-full-name "Luis Moneda")
(setq
send-mail-function 'smtpmail-send-it
message-send-mail-function 'smtpmail-send-it
user-mail-address "lg.moneda@gmail.com"
smtpmail-starttls-credentials '(("smtp.gmail.com" "587" nil nil))
smtpmail-auth-credentials (expand-file-name "~/.authinfo")
smtpmail-default-smtp-server "smtp.gmail.com"
smtpmail-smtp-server "smtp.gmail.com"
smtpmail-smtp-service 587
smtpmail-debug-info t
starttls-extra-arguments nil
starttls-gnutls-program "/usr/bin/gnutls-cli"
starttls-extra-arguments nil
starttls-use-gnutls t
message-signature "Luis Moneda
http://lgmoneda.github.io/"
)

;; Mode line α
(defvar mode-line-cleaner-alist
  `((auto-complete-mode . "")
    (yas/minor-mode . " υ")
    (paredit-mode . " π")
    (eldoc-mode . "")
    (hs-minor-mode . "")
    (which-key-mode . "")
    (smartparens-mode . "")
    (counsel-mode . "")
    (ivy-mode . "")
    (abbrev-mode . "")
    (column-enforce-mode . "")
    (company-mode . "")
    (eldoc-mode . "")
    (Org-Indent . "")
    (visual-line-mode . "")
    (anzu-mode . "")
    (flyspell-mode . "")
    (color-identifiers-mode . "")
    (auto-revert-mode . "")
    (org-indent-mode . "")
    ;; Major modes
    (fundamental-mode . "Fund")
    (lisp-interaction-mode . "λ")
    (hi-lock-mode . "")
    (python-mode . "Py")
    (emacs-lisp-mode . "EL")
    (nxhtml-mode . "nx"))
  "Alist for `clean-mode-line'.

When you add a new element to the alist, keep in mind that you
must pass the correct minor/major mode symbol and a string you
want to use in the modeline *in lieu of* the original.")

(defun clean-mode-line ()
  (interactive)
  (loop for cleaner in mode-line-cleaner-alist
        do (let* ((mode (car cleaner))
                 (mode-str (cdr cleaner))
                 (old-mode-str (cdr (assq mode minor-mode-alist))))
             (when old-mode-str
                 (setcar old-mode-str mode-str))
               ;; major mode
             (when (eq mode major-mode)
               (setq mode-name mode-str)))))


(add-hook 'after-change-major-mode-hook 'clean-mode-line)

;Sunday, August 20, 2017
;============================
;==        Org-mode        ==
;============================
(require 'org)

;; Indent tasks
;; Old star color: 626483
(setq org-startup-indented t)

;; Init hiding everything
(setq org-startup-folded t)

;; Always hide stars
(setq org-hide-leading-stars t)

;; Fix helm-org-heading style
(setq helm-org-headings-fontify t)

;; No blank lines between headers
(setq org-cycle-separator-lines 0)

;; Show deadlines 30 days before
(setq org-deadline-warning-days 60)

;; Consider everything under the tree to todo statistics
(setq org-hierarchical-todo-statistics nil)

;; Add close time when changing to DONE
(setq org-log-done 'time)

;; Configs to use org mode to track time in tasks

;; Resume clocking task when emacs is restarted
(org-clock-persistence-insinuate)

;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)

;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)

;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist t)

;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)

;; Do not prompt to resume an active clock
(setq org-clock-persist-query-resume nil)

(defun lgm/clock-in-when-started ()
"Automatically clock in a task when status is changed to STARTED"
    (when (string= org-state "STARTED")
      (org-clock-in)))

(add-hook 'org-after-todo-state-change-hook 'lgm/clock-in-when-started)

;; Easy jump, clock in and clock out
(global-set-key (kbd "<f12>") 'org-clock-goto)
(global-set-key (kbd "C-<f12>") 'org-clock-in)
(global-set-key (kbd "M-<f12>") 'org-clock-out)

;; Wrap clock tags in logbook
(setq org-clock-into-drawer t)
(setq org-log-into-drawer t)

;; Change viewer apps C-c C-o
;; When not in MAC
(unless (string-equal system-type "darwin")
(setq org-file-apps
      '((auto-mode . emacs)
        ("\\.x?html?\\'" . "xdg-open %s")
        ("\\.pdf\\'" . "evince \"%s\"")
        ("\\.pdf::\\([0-9]+\\)\\'" . "xdg-open \"%s\" -p %1")
        ("\\.pdf.xoj" . "xournal %s")))
      )

;;(add-hook 'org-trigger-hook 'lgm/clock-in-when-started)
;; From cashestocashes.com
;; Once you've included this, activate org-columns with C-c C-x C-c while on a top-level heading, which will allow you to view the time you've spent at the different levels (you can exit the view by pressing q)
;; Set default column view headings: Task Total-Time Time-Stamp
(setq org-columns-default-format "%50ITEM(Task) %10CLOCKSUM %16CLOSED")

;; New states to to-do
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "WAIT(w)" "STARTED(s)" "|" "DONE(d)" "CANCELED(c)" "INACTIVE(i)" "FAIL(f)")))

(setq org-todo-keyword-faces
      '(("TODO" . org-warning)
	("NEXT" . "pink")
	("STARTED" . "yellow")
	("WAIT" . "purple")
	("INACTIVE" . (:foreground "grey"))
        ("CANCELED" . (:foreground "blue" :weight bold))
        ("FAIL" . (:foreground "blue" :weight bold))))

;; No line number in org mode, please
;;(add-hook 'org-mode-hook (linum-mode 0))
;; Open org-agenda
;; (add-hook 'after-init-hook 'org-agenda-list)
(setq org-agenda-block-separator "-")

(org-defkey org-mode-map (kbd "C-S-s /") 'helm-org-agenda-files-headings)

(defun org-tell-me-first-header ()
  (interactive)
  (save-excursion
    (outline-up-heading 3)
    (print (substring-no-properties (org-get-heading t t)))
  )
 )

;; TODO entry automatically change to done when all children are done (from orgmode.org)
(defun org-summary-todo (n-done n-not-done)
       "Switch entry to DONE when all subentries are done, to TODO otherwise."
       (let (org-log-done org-log-states)   ; turn off logging
         (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
     
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

;; Org-babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (gnuplot . t)
   (haskell . nil)
   (latex . t)
   (ledger . t)         ;this is the important one for this tutorial
   (python . t)
   (sh . t)
   (dot . t)
   (sql . nil)
   (sqlite . t)))


;Sunday, December 10, 2017
;============================
;==    Org beautifying     ==
;============================

;; set the fall-back font
;; this is critical for displaying various unicode symbols, such as those used in my init-org.el settings
;; http://endlessparentheses.com/manually-choose-a-fallback-font-for-unicode.html
(set-fontset-font "fontset-default" nil 
                  (font-spec :size 20 :name "Symbola"))

;; Set font size
(set-face-attribute 'default nil :height 110)

;; Setting English Font
;; (set-face-attribute
;;   'default nil :stipple nil :height 130 :width 'normal :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant 'normal :weight 'normal :foundry "outline" :family "DejaVu Sans Mono for Powerline")

;; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
(setq utf-translate-cjk-mode nil)

(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)

;; set the default encoding system
(prefer-coding-system 'utf-8)
(setq default-file-name-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; backwards compatibility as default-buffer-file-coding-system
;; is deprecated in 23.2.
(if (boundp buffer-file-coding-system)
    (setq buffer-file-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8))

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; use org-bullets-mode for utf8 symbols as org bullets
(require 'org-bullets)
;; make available "org-bullet-face" such that I can control the font size individually
(setq org-bullets-face-name (quote org-bullet-face))
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-bullets-bullet-list '("◉" "○" "✸" "✿" "✙" "♱" "♰" "☥" "✞" "✟" "✝" "†" "✠" "✚" "✜" "✛" "✢" "✣" "✤" "✥"))

;; org ellipsis options, other than the default Go to Node...
;; not supported in common font, but supported in Symbola (my fall-back font) ⬎, ⤷, ⤵
(setq org-ellipsis " ▼")


(set-display-table-slot standard-display-table 
                        'selective-display (string-to-vector " ◦◦◦ ")) ; or whatever you like


;; Agenda views / configs

(setq org-agenda-custom-commands
      '(("c" "Simple agenda view"
         ((agenda "")
          (alltodo "")))))
(defun air-org-skip-subtree-if-habit ()
  "Skip an agenda entry if it has a STYLE property equal to \"habit\"."
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (string= (org-entry-get nil "STYLE") "habit")
        subtree-end
	nil)))

(defun air-org-skip-subtree-if-priority (priority)
  "Skip an agenda subtree if it has a priority of PRIORITY.

PRIORITY may be one of the characters ?A, ?B, or ?C."
  (let ((subtree-end (save-excursion (org-end-of-subtree t)))
        (pri-value (* 1000 (- org-lowest-priority priority)))
        (pri-current (org-get-priority (thing-at-point 'line t))))
    (if (= pri-value pri-current)
        subtree-end
      nil)))

;; Org Journal
(use-package org-journal
  :ensure t
  :init (setq org-journal-dir "~/Dropbox/Agenda/Journal"))


;; Build progress bars
;; #+BEGIN: block-dashboard
;; #+END:
;; C-c C-c to build/update bars
(use-package org-dashboard
   :ensure t)

;; I want imenu, not new journal entry!
(global-set-key (kbd "C-c C-j") 'imenu-anywhere)
(define-key python-mode-map (kbd "C-c C-j") 'imenu-anywhere)

(setf org-journal-dir "~/Dropbox/Agenda/Journal")
(setf org-journal-file-format "my-journal.org")
(setf org-journal-date-prefix "* ")
(setf org-journal-time-prefix "** ")

;; Make Org Journal remember me about
;; writing my day thoughts like in Memento mode
(defcustom journal-file "~/Dropbox/Agenda/Journal/my-journal.org" 
  "Customizable variable to specify any file, which will be used for Memento." 
  :type 'string
  :group 'journal)

(defun lgm/org-journal-new-today-entry (prefix &optional event)
  "Open the journal for the date indicated by point and start a new entry.
If the date is not today, it won't be given a time heading. If a
prefix is given, don't add a new heading."
  (interactive
   (list current-prefix-arg last-nonmenu-event))
  (let* ((time (current-time)))
    (lgm/org-journal-new-entry prefix time)))

(defun lgm/org-journal-new-entry (prefix &optional time)
  "Open today's journal file and start a new entry.
Giving the command a PREFIX arg will just open a today's file,
without adding an entry. If given a TIME, create an entry for the
time's day.

Whenever a journal entry is created the
`org-journal-after-entry-create-hook' hook is run"
  (interactive "P")
  (org-journal-dir-check-or-create)
  (let* ((entry-path (org-journal-get-entry-path time))
         (should-add-entry-p (not prefix)))

    ;; open journal file
    (unless (string= entry-path (buffer-file-name))
      (funcall org-journal-find-file entry-path))
    (org-journal-decrypt)
    (goto-char (point-max))
    (let ((unsaved (buffer-modified-p))
          (new-file-p (equal (point-max) 1)))

      ;; empty file? Add a date timestamp
      (insert "\n")
      (insert org-journal-date-prefix
              (format-time-string org-journal-date-format time))

      ;; add crypt tag if encryption is enabled and tag is not present
      (when org-journal-enable-encryption
        (goto-char (point-min))
        (unless (member org-crypt-tag-matcher (org-get-tags))
          (org-set-tags-to org-crypt-tag-matcher))
        (goto-char (point-max)))

      ;; move TODOs from previous day here
      (when (and new-file-p org-journal-carryover-items)
        (save-excursion (org-journal-carryover)))
      (print "dbuga")
      ;; insert the header of the entry
      (when should-add-entry-p
        (unless (eq (current-column) 0) (insert "\n"))
        (let ((timestamp (if (= (time-to-days (current-time)) (time-to-days time))
                             (format-time-string org-journal-time-format)
                           "")))
          (insert "\n" org-journal-time-prefix timestamp))
        (run-hooks 'org-journal-after-entry-create-hook))

      ;; switch to the outline, hide subtrees
      (org-journal-mode)
      (if (and org-journal-hide-entries-p (org-journal-time-entry-level))
          (outline-hide-sublevels 
	   (- (org-journal-time-entry-level) 1))
	  (show-all)
	  )

      ;; open the recent entry when the prefix is given
      (when should-add-entry-p
        (show-entry))

      (set-buffer-modified-p unsaved)

      ;; Isolate it and use the write mode
      (delete-other-windows)
      (writeroom-mode)

      )))

(defun journal-get-modification-date ()
  "Returns the last modified date of the current memento file."
  (format-time-string "%Y-%m-%d"
                      (nth 5 (file-attributes journal-file))))

(defun journal-check-when-quit ()
  (interactive)
  (if (file-exists-p journal-file)
      ;; Check if there was a log written today. If this is not the case, then check if it's already tonight except the night.
      (if (and (string< (journal-get-modification-date) (format-time-string "%Y-%m-%d")) (or (string< (format-time-string "%k") " 6") (string< "21" (format-time-string "%k"))))
          ;; Invoke Memento if the user wants to proceed. 
          (if (yes-or-no-p "Do you want to write your Journal?")
              (progn (call-interactively 'lgm/org-journal-new-today-entry)
		     (keyboard-quit)
		     )
	      ))
    ;; If the Memento file doesn't exist yet, create a file and proceed with creating a log.
    (write-region "" nil journal-file)
    (progn (call-interactively 'lgm/org-journal-new-today-entry))))

(add-to-list 'kill-emacs-hook 'journal-check-when-quit)

;; Dict.cc wrap
(add-to-list 'load-path "~/.emacs.d/elisp/dict-cc" t)
(require 'dict-cc)
;; PATH append
(setenv "PATH" (concat "/home/lgmoneda/miniconda2/bin:" (getenv "PATH")))

;; Functions to copy words at point, from:
;; https://www.emacswiki.org/emacs/CopyWithoutSelection
(defun get-point (symbol &optional arg)
  "get the point"
  (funcall symbol arg)
  (point)
  )

(defun paste-to-mark(&optional arg)
  "Paste things to mark, or to the prompt in shell-mode"
  (let ((pasteMe 
     	 (lambda()
     	   (if (string= "shell-mode" major-mode)
	       (progn (comint-next-prompt 25535) (yank))
	     (progn (goto-char (mark)) (yank) )))))
    (if arg
	(if (= arg 1)
	    nil
	  (funcall pasteMe))
      (funcall pasteMe))
    ))

(defun copy-thing (begin-of-thing end-of-thing &optional arg)
  "copy thing between beg & end into kill ring"
  (save-excursion
    (let ((beg (get-point begin-of-thing 1))
	  (end (get-point end-of-thing arg)))
      (copy-region-as-kill beg end)))
  )


(defun copy-word (&optional arg)
  "Copy words at point into kill-ring"
  (interactive "P")
  (kill-new (thing-at-point 'word))
  ;;(copy-thing 'backward-word 'forward-word arg)
  ;;(paste-to-mark arg)
  )

(global-set-key (kbd "C-c w") (quote copy-word))

(defun copy-line (&optional arg)
  "Save current line into Kill-Ring without mark the line "
  (interactive "P")
  (copy-thing 'beginning-of-line 'end-of-line arg)
  ;;(paste-to-mark arg)
  )

(global-set-key (kbd "C-c l")         (quote copy-line))

;; Trying to start using marker
;; C-<space> C-<space> to leave mark
;; C-u C-<space>
;; C-<space> again to previous marks
;; C-<space> C-s "char" to selec region between mark and I-search
;; ^ or use ace-jump!
;; C-x C-<space> global jump to last mark 
(setq set-mark-command-repeat-pop t)

;; Selection functions utilities
;; Stop using arrows for selection!
;; It requires thing-cmds 
(defun mark-a-word-or-thing (arg)
   "..."
  (interactive "P")
  (cond ((or arg mark-active)
         (when (consp arg) (setq current-prefix-arg nil))
         (call-interactively 'mark-thing))
        (t
         (skip-syntax-backward "w_")
         (mark-thing 'word))))

(global-set-key (kbd "C-+") 'mark-a-word-or-thing)
(global-set-key (kbd "C-=") 'er/expand-region)

(defun counsel-projectile-ag-word (word &optional options)
  "Search the current project with ag.

OPTIONS, if non-nil, is a string containing additional options to
be passed to ag. It is read from the minibuffer if the function
is called with a prefix argument."
  (let* ((ignored (mapconcat (lambda (i)
                               (concat "--ignore "
                                       (shell-quote-argument i)
                                       " "))
                             (append (projectile-ignored-files-rel)
                                     (projectile-ignored-directories-rel))
                             ""))
         (options
          (if current-prefix-arg
              (read-string (projectile-prepend-project-name "ag options: ")
                           ignored
                           'counsel-projectile-ag-options-history)
            (concat ignored options))))
    (counsel-ag word
                (projectile-project-root)
                options
                (projectile-prepend-project-name "ag"))))

(defun lgm/look-for-word-in-project ()
  (interactive)
  (progn
   (er/mark-word)
   (counsel-projectile-ag-word (buffer-substring (region-beginning) (region-end)))
   )
  )

(defun lgm/look-for-selected-word-in-project ()
  (interactive)
  (progn
   (counsel-projectile-ag-word (buffer-substring (region-beginning) (region-end)))
   )
  )

(define-key projectile-command-map (kbd "s w") 'lgm/look-for-word-in-project)
(global-set-key (kbd "C-M-*") 'lgm/look-for-selected-word-in-project)


;; Creates a new line without breaking the current line
(defun newline-without-break-of-line ()
  "1. move to end of the line.
  2. insert newline with index"

  (interactive)
  (let ((oldpos (point)))
    (end-of-line)
    (newline-and-indent)))

(global-set-key (kbd "<C-return>") 'newline-without-break-of-line)

;; Changes the search face


;; Schema 
(use-package quack
  :ensure t)

(use-package scheme-complete
  :ensure t)

;; If you use eldoc-mode (included in Emacs), you can also get live
;; scheme documentation with:
(autoload 'scheme-get-current-symbol-info "scheme-complete" nil t)
(add-hook 'scheme-mode-hook
  (lambda ()
    (make-local-variable 'eldoc-documentation-function)
    (setq eldoc-documentation-function 'scheme-get-current-symbol-info)
    (eldoc-mode)))

(eval-after-load 'scheme
  '(define-key scheme-mode-map "\t" 'scheme-complete-or-indent))

(setq lisp-indent-function 'scheme-smart-indent-function)

;; Some functions from EmacsWiki
(add-to-list 'load-path "~/.emacs.d/elisp/misc/" t)

;; Jump to last change 
(require 'goto-chg)
(global-set-key [(control ?.)] 'goto-last-change)
(global-set-key [(control ?,)] 'goto-last-change-reverse)

;; LaTeX!
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
;(setq TeX-PDF-mode t)

;; automatic formatting of a section: C-c C-q C-s;
;; section preview: C-c C-p C-s; 

(require 'flymake)

(defun flymake-get-tex-args (file-name)
(list "pdflatex"
      (list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))



(use-package latex-preview-pane
	     :ensure t)

;;(add-hook 'LaTeX-mode-hook 'flymake-mode)
;;(add-hook 'LaTeX-mode-hook 'latex-preview-pane-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)

;;To hide all the contents of your current section, use C-c C-o C-l. You can apply it to a chapter, subsection, etc. You can also move to a next unit of your document with C-c C-o C-n, or to a previous one with C-c C-o C-p. If you’re lost and want to see the whole document again, use C-c C-o C-a.
(defun turn-on-outline-minor-mode ()
(outline-minor-mode 1))

(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
(add-hook 'latex-mode-hook 'turn-on-outline-minor-mode)
(setq outline-minor-mode-prefix "\C-c \C-o") ; Or something else

(setq TeX-parse-self t) ; Enable parse on load.
(setq TeX-auto-save t) ; Enable parse on save.

; Annoying 25.2 message when running Python
(with-eval-after-load 'python
  (defun python-shell-completion-native-try ()
    "Return non-nil if can trigger native completion."
    (let ((python-shell-completion-native-enable t)
          (python-shell-completion-native-output-timeout
           python-shell-completion-native-try-output-timeout))
      (python-shell-completion-native-get-completions
       (get-buffer-process (current-buffer))
       nil "_"))))
(setq python-shell-completion-native-enable nil)

(use-package alert
  :commands (alert)
  :init
  ;;(setq alert-default-style 'notifier)
  )

;;Saturday, August 12, 2017
;;============================
;;==  Header func head :P   ==
;;============================

(defun lgm/insert-comment-header()
  (interactive)
  (setq header (read-string "Enter header: "))
  (setq header-length (length header))
  (back-to-indentation)
  (open-line 3)
  (insert comment-start)
  (insert (calendar-date-string (calendar-current-date)))
  (next-line)
  (insert (concat comment-start "============================"))
  (next-line)
  (insert (concat comment-start "=="))
  (setq n-white-spaces (- 24 header-length))
  (setq count 0)
  (while (< count n-white-spaces)
    (insert " ")
    (setq count (1+ count))
    (if (= count (/ n-white-spaces 2))
	(insert header)
	)
    )
  (insert "==")
  (next-line)
  (insert (concat comment-start "============================"))
  (open-line 1)
  (back-to-indentation)
  )

(define-key emacs-lisp-mode-map (kbd "<f5>") 'lgm/insert-lisp-comment-header)


;;Thursday, August 10, 2017
;;============================
;;==           R            ==
;;============================

(setq inferior-R-program-name "/Library/Frameworks/R.framework/Resources/R")

(use-package ess
	     :ensure t
	     :init
  (setq ess-eval-visibly-p nil)
  (setq ess-ask-for-ess-directory nil)
  ;; (require 'ess-eldoc)
  )

;;Tuesday, August 15, 2017
;;============================
;;==       G Calendar       ==
;;============================

(use-package org-gcal 
  :init
  :ensure t
  )
 
;; Load gcalsync
(load "~/Dropbox/Projetos/Emacs/.gcalsync.el")

(use-package org-alert
  :init
  :ensure t
  )

;;(setq alert-default-style 'libnotify)

;; Start with my to-do
;; The org mode file is opened with
(find-file "~/Dropbox/Agenda/todo.org")
(switch-to-buffer "todo.org")
(setq org-agenda-window-setup 'other-window)
;; (org-agenda-list)

(add-to-list 'org-agenda-files  "~/Dropbox/Agenda/todo.org" "~/Dropbox/Agenda/finances.org")

;; Fix the bullets bug
(add-hook 'after-init-hook (org-mode-restart))

;;Tuesday, August 15, 2017
;;============================
;;==       OS Configs       ==
;;============================
(cond
    ((string-equal system-type "gnu/linux")
     (progn
      (+ 1 1)
    ))
    ((string-equal system-type "darwin")
        (progn
	 (add-to-list 'exec-path "/usr/local/bin" "/Library/TeX/texbin/pdflatex")
	 ;;add hookup shell
	 (add-hook 'shell-mode-hook (lambda ()
				      (setenv "PATH" (shell-command-to-string "$SHELL -cl \"printf %s \\\"\\\$PATH\\\"\""))
				      (setq exec-path (append (parse-colon-path (getenv "PATH")) (list exec-directory)))

				      ))
	 (setq ispell-program-name "/usr/local/bin/ispell/")
	 (setenv "PATH" "/usr/local/bin:/Library/TeX/texbin/:$PATH" t)
	 ;; Shell
	 ;; There's a .emacs_bash with .~/bash_profile
	 ;; Maybe i should use this:
	 ;;https://github.com/purcell/exec-path-from-shell
	  (setq markdown-command "/usr/local/bin/pandoc")
        )
    )
    )

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(use-package default-text-scale
	     :ensure t)

(global-set-key (kbd "C-M-=") 'default-text-scale-increase)
(global-set-key (kbd "C-M--") 'default-text-scale-decrease)


(setq tramp-default-method "ssh")
;;(setq tramp-auto-save-directory "~/tmp/tramp/")
(add-to-list 'backup-directory-alist
                  (cons tramp-file-name-regexp nil))
(setq tramp-chunksize 2000)

(setq max-mini-window-height 1)

(require 'docker-tramp-compat)
;; Open files in Docker containers like so: /docker:drunk_bardeen:/etc/passwd
(push
 (cons
  "docker"
  '((tramp-login-program "docker")
    (tramp-login-args (("exec" "-it") ("%h") ("/bin/bash")))
    (tramp-remote-shell "/bin/sh")
    (tramp-remote-shell-args ("-i") ("-c"))))
 tramp-methods)

(defadvice tramp-completion-handle-file-name-all-completions
  (around dotemacs-completion-docker activate)
  "(tramp-completion-handle-file-name-all-completions \"\" \"/docker:\" returns
    a list of active Docker container names, followed by colons."
  (if (equal (ad-get-arg 1) "/docker:")
      (let* ((dockernames-raw (shell-command-to-string "docker ps | perl -we 'use strict; $_ = <>; m/^(.*)NAMES/ or die; my $offset = length($1); while(<>) {substr($_, 0, $offset, q()); chomp; for(split m/\\W+/) {print qq($_:\n)} }'"))
             (dockernames (cl-remove-if-not
                           #'(lambda (dockerline) (string-match ":$" dockerline))
                           (split-string dockernames-raw "\n"))))
        (setq ad-return-value dockernames))
    ad-do-it))


(defvar org-capture-templates
       '(("t" "todo" entry (file org-default-notes-file)
	  "* TODO %?\n%u\n%a\n" :clock-in t :clock-resume t)
	 ("b" "Blank" entry (file org-default-notes-file)
	  "* %?\n%u")
	 ("m" "Meeting" entry (file org-default-notes-file)
	  "* MEETING with %? :MEETING:\n%t" :clock-in t :clock-resume t)
	 ("d" "Diary" entry (file+datetree "~/org/diary.org")
	  "* %?\n%U\n" :clock-in t :clock-resume t)
	 ("D" "Daily Log" entry (file "~/org/daily-log.org")
	  "* %u %?\n*Summary*: \n\n*Problem*: \n\n*Insight*: \n\n*Tomorrow*: " :clock-in t :clock-resume t)
	 ("i" "Idea" entry (file org-default-notes-file)
	  "* %? :IDEA: \n%u" :clock-in t :clock-resume t)
	 ("n" "Next Task" entry (file+headline org-default-notes-file "Tasks")
	  "** NEXT %? \nDEADLINE: %t") ))

(setq org-lowest-priority ?D)
(setq org-default-priority ?D)
(setq org-agenda-skip-scheduled-if-deadline-is-shown t)

(setq org-agenda-block-separator " ")
(setq org-agenda-custom-commands 
      '(("d" "Daily agenda and NEXTs!"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority tasks:")))

	  ;; Next deadlines 
	  (agenda "" 
		  ((org-agenda-time-grid nil)
		   (org-agenda-span 'day)
		   (org-deadline-warning-days 21)       
		   (org-agenda-entry-types '(:deadline))  
		   (org-agenda-sorting-strategy '(deadline-up))
		   (org-agenda-overriding-header "Deadlines in the next 21 days:")
		   ))

	  ;; Today Agenda
          (agenda "" ((org-agenda-ndays 5)
		      (org-agenda-span 'day)
		      (org-agenda-time-grid nil)
		      (org-deadline-warning-days 0)
		      (org-agenda-skip-scheduled-delay-if-deadline t)
		      (org-agenda-todo-ignore-scheduled t)
		      (org-agenda-scheduled-leaders '("" ""))
		      (org-agenda-tags-todo-honor-ignore-options t)
		      (org-agenda-overriding-header "Today Agenda:")
		      )
		  )
	  
	  ;; NEXT Nubank Tasks
          (tags-todo "+nubank+TODO=\"NEXT\""
	  	(
	  	 (org-agenda-category-filter-preset (quote ("+Nubank")))
	  	 (org-agenda-overriding-header "Next tasks at Nubank:")
	  	 ;; (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled))
	  	 (org-agenda-overriding-columns-format "%20ITEM %SCHEDULED")
	  	 (org-agenda-sorting-strategy '(category-keep))
	  	 (org-agenda-view-columns-initially t)
	  	 ;; (org-agenda-prefix-format " %i %s %?-16 (concat \"[ \"(org-format-outline-path (list (nth 1 (org-get-outline-path)))) \" ]\") ")
		 (org-agenda-prefix-format "%?-16 (scheduled-or-not (org-entry-get (point) \"SCHEDULED\")) ")
	  	 ;; (org-agenda-prefix-format
	  	 ;;      "%((concat (or (org-entry-get (point) \"scheduled\" t) \"\") \" \"
	  	 ;; 		 (or (org-entry-get (point) \"CaseNum\" t) \"\") \" \"
                 ;;                 (or (org-entry-get (point) \"FiscalYear\" t) \"\") \" \"))") 
	  	 )

	  	)

	  ;; NEXT Master
          (tags "+usp+TODO=\"NEXT\""
		(
		 (org-agenda-overriding-header "Next task in Master:")
		 (org-agenda-prefix-format "%?-16 (scheduled-or-not (org-entry-get (point) \"SCHEDULED\")) ")
		 )
		)
	  
	  ;; NEXT Work
          (tags "+work+TODO=\"NEXT\"|udacity+TODO=\"NEXT\"" 
		(
		 (org-agenda-overriding-header "Next task in Work and Udacity:")
		 (org-agenda-prefix-format "%?-16 (scheduled-or-not (org-entry-get (point) \"SCHEDULED\")) ")
		 )
		)
	  
	  ;; NEXT Study
          (tags "+study+TODO=\"NEXT\""
		(
		 (org-agenda-overriding-header "Next task in Study:")
		 (org-agenda-prefix-format "%?-16 (scheduled-or-not (org-entry-get (point) \"SCHEDULED\")) ")
		 )
		)

	  ;; NEXT Kaggle
          (tags "+kaggle+TODO=\"NEXT\""
		((org-agenda-overriding-header "Next tasks in Kaggle:")
		 (org-agenda-prefix-format "%?-16 (scheduled-or-not (org-entry-get (point) \"SCHEDULED\")) ")
		 )
		)

	  ;; NEXT Life
          (tags "+life-goals2018+TODO=\"NEXT\""
		((org-agenda-overriding-header "Next tasks in Life:")
		 (org-agenda-prefix-format "%?-16 (scheduled-or-not (org-entry-get (point) \"SCHEDULED\")) ")
		 )
		)
	  
	  ;; Blocked Nubank
	  (tags "+nubank+TODO=\"WAIT\""
		((org-agenda-skip-function 'my-skip-unless-waiting)
            (org-agenda-category-filter
	     (quote
	      ("+Nubank")))
	    (org-agenda-overriding-header "Blocked Nubank Tasks: "))
		
		)
	  
	  ;; TODO Nubank
	  (tags "+nubank+LEVEL=3+TODO=\"TODO\""
		((org-agenda-skip-function 'my-skip-unless-waiting)
            (org-agenda-category-filter
	(quote
	 ("+Nubank")))
	    (org-agenda-overriding-header "Nubank Tasks: "))

		)

	  ;; Mid and low priority tasks
	  ;; (tags "+PRIORITY={B}"
          ;;       ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
          ;;        (org-agenda-overriding-header "Mid or low-priority tasks:")))

	  ;; Deadlines
	  ;; (tags "+DEADLINE>=\"<today>\"&DEADLINE<=\"<+2m>\""
          ;;      ((org-agenda-overriding-columns-format
          ;;        "%25ITEM %DEADLINE %TAGS")
	  ;; 	(org-agenda-overriding-header "Approaching Deadlines!:")))

	  ;; Long deadlines 
	  (agenda "" 
		  ((org-agenda-time-grid nil)
		   (org-agenda-span 'day)
		   (org-deadline-warning-days 90)       
		   (org-agenda-entry-types '(:deadline))  
		   (org-agenda-sorting-strategy '(deadline-up))
		   (org-agenda-overriding-header "Deadlines in the next 90 days:")
		   ))
       
	  
	  ;; Year Goals Milestones
	  (tags "-nubank+goals2018+TODO=\"NEXT\""
		((org-agenda-category-filter "-Nubank")
		 (org-agenda-skip-function '(or (air-org-skip-subtree-if-habit)
						(air-org-skip-subtree-if-priority ?A)
						(org-agenda-skip-if nil '(scheduled deadline))))
	    (org-agenda-overriding-header "2018 Goals Milestones: ")
	    )
		)

	  ;; Year Goals General
	  (tags "+goals2018+LEVEL=3+TODO=\"TODO\"" 
		((org-agenda-category-filter "-Nubank")
		 (org-agenda-skip-function '(or (air-org-skip-subtree-if-habit)
						(air-org-skip-subtree-if-priority ?A)
						(org-agenda-skip-if nil '(scheduled deadline))))
	    (org-agenda-overriding-header "2018 Goals: ")
	    )
		)

	  ;; Next few days
          (agenda "" ((org-agenda-ndays 2)
		      (org-agenda-span 3)
		      (org-agenda-start-day "+1d")
		      (org-agenda-scheduled-leaders '("" ""))
		  (org-agenda-overriding-header "Next few days:"))
		  )

	  ;; All next tasks
	  (tags "-goals2018+TODO=\"NEXT\""
		(
		 (org-agenda-tags-todo-honor-ignore-options :scheduled)
		 (org-agenda-skip-function '(or (air-org-skip-subtree-if-habit)
						(air-org-skip-subtree-if-priority ?A)
						(org-agenda-skip-if nil '(scheduled deadline))))
	    (org-agenda-overriding-header "Next tasks NOT SCHEDULED:")
	    )
	   )
	  )
         ((org-agenda-compact-blocks nil))
	 )

    ;; 	("n" "Next Nubank tasks" todo "NEXT" 
    ;; ((org-agenda-skip-function 'my-skip-unless-waiting)
    ;;         (org-agenda-category-filter-preset
    ;; 	(quote
    ;; 	 ("+Nubank")))
    ;; 	    (org-agenda-overriding-header "Nu Agenda: "))

    ;; )
	
	))

;; Enable the usage of two agenda views at the same time
(org-toggle-sticky-agenda)

;; Shortcut to display day activity
(defun org-agenda-show-agenda-and-todo (&optional arg)
  (interactive "P")
  (org-agenda arg "n"))

(defun scheduled-or-not (resp)
  (interactive)
  (if resp
    ;;'"OK"
    ;;(format-time-string "%Y-%m-%d" (org-time-string-to-time resp))
    (concat "In " (number-to-string (org-time-stamp-to-now resp)) " day(s)")
    '"Not Scheduled"
    )
)

;; Only deadlines view
(add-to-list 'org-agenda-custom-commands
             '("z" "Deadlines" 
               tags "+DEADLINE>=\"<today>\"&DEADLINE<=\"<+2m>\""
               ((org-agenda-overriding-columns-format
                 "%25ITEM %DEADLINE %TAGS")))
             )

;; Compact only day view
(add-to-list 'org-agenda-custom-commands
             '("l" "Compact today"
	       agenda "" ((org-agenda-ndays 5)
			  (org-agenda-span 'day)
			  (org-deadline-warning-days 0)
			  (org-agenda-skip-scheduled-delay-if-deadline t)
			  (org-agenda-todo-ignore-scheduled t)
			  (org-agenda-scheduled-leaders '("" ""))
			  (org-agenda-tags-todo-honor-ignore-options t)
			  (org-agenda-overriding-header "Today Agenda:")
			  )		 
	       )
	     )	     

;; (use-package calfw
;;   :ensure t)

;; (use-package calfw-org
;;   :ensure t)

(defadvice org-agenda (around split-vertically activate)
  (let ((split-width-threshold 80))  ; or whatever width makes sense for you
    ad-do-it))

(add-hook 'after-init-hook (lambda () (org-agenda nil "d")))

(defun lgm/next-nu ()
  (interactive)
  (org-agenda nil "n")
  )

;Sunday, April 8, 2018
;============================
;==           Go           ==
;============================
(use-package go-mode
     :ensure t
     :preface

     (defun bk/set-go-compiler ()
	(if (not (string-match "go" compile-command))
	    (set (make-local-variable 'compile-command)
		 "go build -v && go test -v && go run"))
	(local-set-key (kbd "M-p") 'compile))

     :init

     (when (string-equal system-type "darwin")
	(add-to-list 'exec-path "/usr/local/go/bin/go")
	(setenv "GOPATH" "/usr/local/go/bin/go"))

     (setq gofmt-command "goimports")
     :bind (:map go-mode-map
		  ("C-c C-r" . go-remove-unused-imports)
		  ("C-c i" . go-goto-imports)
		  ("M-." . godef-jump)
		  ("M-*" . pop-tag-mark))
     :config
     (add-hook 'before-save-hook 'gofmt-before-save)
     (add-hook 'go-mode-hook 'bk/set-go-compiler))


(defvar yt-iframe-format
  ;; You may want to change your width and height.
  (concat "<iframe width=\"440\""
          " height=\"335\""
          " src=\"https://www.youtube.com/embed/%s\""
          " frameborder=\"0\""
          " allowfullscreen>%s</iframe>"))

(org-add-link-type
 "yt"
 (lambda (handle)
   (browse-url
    (concat "https://www.youtube.com/embed/"
            handle)))
 (lambda (path desc backend)
   (cl-case backend
     (html (format yt-iframe-format
                   path (or desc "")))
     (latex (format "\href{%s}{%s}"
                    path (or desc "video"))))))


;; This should work :(
(add-hook 'org-finalize-agenda-hook
    (lambda ()
      (save-excursion
        (goto-char (point-min))
        (while (re-search-forward "nu-agenda:" nil t) 
          (add-text-properties (match-beginning 0) (point-at-eol)
             '(face (:foreground "green"))))
        (goto-char (point-min))
        (while (re-search-forward "work:" nil t) 
          (add-text-properties (match-beginning 0) (point-at-eol)
             '(face (:foreground "purple")))))))

;; Scroll while centering
(global-set-key (kbd "C-v") (lambda () (interactive) (scroll-up-command) (recenter) ))
(global-set-key (kbd "M-v") (lambda () (interactive) (scroll-down-command) (recenter) ))
(setq scroll-error-top-bottom 'true)
(setq scroll-preserve-screen-position t)


;Wednesday, May 2, 2018
;============================
;==        Clojure         ==
;============================

;; (use-package clojure-mode
;;     :ensure t)
;; (use-package clj-refactor
;;     :ensure t)
;; (use-package cider
;;     :ensure t)

;; ;; start cider and clj-refactor when clojure-mode is enabled (by default, on .clj files)
;; (add-hook 'clojure-mode-hook (lambda ()
;; 			(cider-mode 1)
;; 			(clj-refactor-mode 1)
;; 			(cljr-add-keybindings-with-prefix "C-c C-o")
;; 			(setq clojure-align-forms-automatically t)))
;; (add-hook 'clojure-mode-hook 'paredit-mode)
;; (add-hook 'cider-repl-mode-hook 'paredit-mode)


;; Add blank line at the end of a file
(setq require-final-newline t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Terminal notifier 
;; requires 'brew install terminal-notifier'
;; stolen from erc-notifier


;; Change duration: defaults write com.apple.notificationcenterui bannerTime 25
(defun terminal-notifier-notify (title message)
  "Show a message with terminal-notifier-command."
  (start-process "terminal-notifier"
                 "terminal-notifier"
                 "terminal-notifier"
                 "-title" title
                 "-message" message
		 "-sound" "default"
                 "-sender" "org.gnu.Emacs"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Warns every N minutes about all the deadlines and scheduled tasks
;; for the current day
(use-package org-alert
	     :ensure t)

;; https://github.com/akhramov/org-wild-notifier.el
(use-package org-wild-notifier
	     :ensure t
	     :init (org-wild-notifier-mode)
	     (setq org-wild-notifier-keyword-whitelist '("TODO" "NEXT"))
	     (setq org-wild-notifier-alert-time 5)
	     )

(defun remind-me-daily (fn time msg wavfile box)
  (when (and (boundp 'daily-reminder)
             (timerp daily-reminder))
    (cancel-timer daily-reminder))
  (let ((daily (* 60 60 24)))
    (setq daily-reminder
          (run-at-time time daily 'funcall fn msg wavfile box))))

(defun reminder-fn (msg wavfile box)  
  (if wavfile
      (start-process-shell-command "lolsound" nil (concat "mplayer ~/.emacs.d/sounds/" wavfile))
      )
  (if box
      (terminal-notifier-notify "Emacs Notification" msg)
      (message msg)))

(remind-me-daily 'reminder-fn "6:58pm" "Bedtime!" nil t)


(defun my-terminal-notifier-notify (info)
  "Show a message with terminal-notifier-command."
  (start-process "terminal-notifier"
                 "terminal-notifier"
                 "terminal-notifier"
                 "-title" (plist-get info :title)
                 "-message" (plist-get info :message)
		 "-sound" "default"
                 "-sender" "org.gnu.Emacs"))

(alert-define-style 'style-name :title "My Style's title"
                    :notifier
		    'my-terminal-notifier-notify
                    ;; Removers are optional.  Their job is to remove
                    ;; the visual or auditory effect of the alert.
                    :remover
                    (lambda (info)
                      ;; It is the same property list that was passed to
                      ;; the notifier function.
                      ))

(setq alert-default-style 'style-name)


;; Node connection
(load "~/Dropbox/Projetos/Emacs/.nu-node.el")


;Wednesday, June 13, 2018
;============================
;==        Clojure         ==
;============================


;; Enable paredit for Clojure
(add-hook 'clojure-mode-hook 'enable-paredit-mode)

;; This is useful for working with camel-case tokens, like names of
;; Java classes (e.g. JavaClassName)
(add-hook 'clojure-mode-hook 'subword-mode)

;; A little more syntax highlighting
(use-package clojure-mode-extra-font-locking
	     :ensure t)

(use-package cider
	     :ensure t)

;; syntax hilighting for midje
(add-hook 'clojure-mode-hook
          (lambda ()
            (setq inferior-lisp-program "lein repl")
            (font-lock-add-keywords
             nil
             '(("(\\(facts?\\)"
                (1 font-lock-keyword-face))
               ("(\\(background?\\)"
                (1 font-lock-keyword-face))))
            (define-clojure-indent (fact 1))
            (define-clojure-indent (facts 1))))

;;;;
;; Cider
;;;;

;; provides minibuffer documentation for the code you're typing into the repl
;; (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

;; go right to the REPL buffer when it's finished connecting
(setq cider-repl-pop-to-buffer-on-connect t)

;; ;; When there's a cider error, show its buffer and switch to it
;; (setq cider-show-error-buffer t)
;; (setq cider-auto-select-error-buffer t)

;; ;; Where to store the cider history.
;; (setq cider-repl-history-file "~/.emacs.d/cider-history")

;; ;; Wrap when navigating history.
;; (setq cider-repl-wrap-history t)

;; enable paredit in your REPL
(add-hook 'cider-repl-mode-hook 'paredit-mode)

;; ;; Use clojure mode for other extensions
;; (add-to-list 'auto-mode-alist '("\\.edn$" . clojure-mode))
;; (add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
;; (add-to-list 'auto-mode-alist '("\\.cljs.*$" . clojure-mode))
;; (add-to-list 'auto-mode-alist '("lein-env" . enh-ruby-mode))


;; ;; key bindings
;; ;; these help me out with the way I usually develop web apps
;; (defun cider-start-http-server ()
;;   (interactive)
;;   (cider-load-current-buffer)
;;   (let ((ns (cider-current-ns)))
;;     (cider-repl-set-ns ns)
;;     (cider-interactive-eval (format "(println '(def server (%s/start))) (println 'server)" ns))
;;     (cider-interactive-eval (format "(def server (%s/start)) (println server)" ns))))


;; (defun cider-refresh ()
;;   (interactive)
;;   (cider-interactive-eval (format "(user/reset)")))

;; (defun cider-user-ns ()
;;   (interactive)
;;   (cider-repl-set-ns "user"))

;; (eval-after-load 'cider
;;   '(progn
;;      (define-key clojure-mode-map (kbd "C-c C-v") 'cider-start-http-server)
;;      (define-key clojure-mode-map (kbd "C-M-r") 'cider-refresh)
;;      (define-key clojure-mode-map (kbd "C-c u") 'cider-user-ns)
;;      (define-key cider-mode-map (kbd "C-c u") 'cider-user-ns)))


;; fix the PATH variable
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "TERM=vt100 $SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

(global-set-key (kbd "C-*")
    (lambda ()
      (interactive)
      (isearch-forward-symbol-at-point)))
