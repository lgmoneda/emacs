;; Package Management
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
     '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
     '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
   (package-install 'use-package))

;; High contrast Zenburn theme
;; (use-package hc-zenburn-theme
;;   :ensure t)

;; Load Theme
;; Themes to use: monokai, deeper-blue and hc-zenburn 
(setq custom-safe-themes t)
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (load-theme 'monokai)))

;; Custom faces:
;; Make selected text background #012050
;; Set matching parens background color and bold
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-search ((t (:inherit highlight :background "steel blue"))))
 '(company-tooltip-search-selection ((t (:background "steel blue"))))
 '(diff-hl-change ((t (:background "#3a81c3"))))
 '(diff-hl-delete ((t (:background "#ee6363"))))
 '(diff-hl-insert ((t (:background "#7ccd7c"))))
 '(ein:cell-input-area ((t (:background "dim gray"))))
 '(region ((t (:background "#102050"))))
 '(show-paren-match ((t (:background "#5C888B" :weight bold)))))

;; Fast init.el open
(global-set-key (kbd "<f6>") (lambda() (interactive)(find-file "~/.emacs.d/init.el")))

;; Save place
;; Start from the last place you were in a file the next time you visit it
;; It's a emacs24.5 or older way to do it
(require 'saveplace)
(setq-default save-place t)
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

;; Magit
(use-package magit
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

;; Unique color identifier
(use-package color-identifiers-mode
  :ensure t
  :config (add-hook 'after-init-hook 'global-color-identifiers-mode))

;; Rainbow delimiters in Elisp erc
(use-package rainbow-delimiters
  :ensure t
  :config (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode))

;; thing-cmd
(use-package thing-cmds
  :ensure t)
;; Ido
(use-package ido
  :ensure t
  :init (ido-mode)
        (setq ido-enable-flex-matching t)
        (ido-everywhere t)
	(setq ido-file-extensions-order '(".py" ".org" ".txt" ".emacs" ".xml" ".el" ".ini" ".cfg" ".cnf")))

(setq ido-use-faces nil)

;; Ido-vertical
(use-package ido-vertical-mode
  :ensure t
  :init (ido-vertical-mode))

;; Ido ubiquitous
(use-package ido-ubiquitous
  :ensure t
  :init (ido-ubiquitous-mode))

;; Ido ubiquitous
(use-package flx-ido
  :ensure t
  :init (flx-ido-mode))

;; imenu-anywhere
;; Changes the C-c C-j behavior
(use-package imenu-anywhere
  :ensure t
  :init (imenu-anywhere))

;; Smex
(use-package smex
  :ensure t
  :init (smex-initialize)
  :config
  (global-set-key (kbd "M-X") 'smex)
  ;;(global-set-key (kbd "M-X") 'smex-major-mode-commands)
  ;; This is your old M-x.
  ;;(global-set-key (kbd "M-x") 'execute-extended-command)
  )

;; Projectile
(use-package projectile
  :ensure t
  :init (projectile-global-mode)
  :config (setq projectile-mode-line '(:eval (format " Proj[%s]" (projectile-project-name))))
  :bind (("C-c p s" . projectile-ag)
         ("C-c p g" . projectile-grep)))

;; Neotree
(use-package neotree
  :ensure t
  :bind ([f8] . neotree-toggle))

;; Anaconda Anaconda+Eldoc
(use-package anaconda-mode
    :ensure t
    :diminish anaconda-mode
    :config
    (add-hook 'python-mode-hook 'anaconda-mode)
    (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
    (add-hook 'python-mode-hook 'python--add-debug-highlight)
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

(+ 2 (- 10 2)) 
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
(setq display-time-format "%Hh%M")
(display-time-mode 0)

;; To activate pytevec environment
(defun anpytevec ()
  (interactive)
  (pythonic-activate "~/miniconda2/envs/npytevec")
  )

;; Check if i'm at work and activate
;; the right environment
(defun activate-work-env ()
  (if (string= (system-name) "deb3550")
      (pythonic-activate "~/miniconda2/envs/npytevec"))
  (if (string= (system-name) "rc530")
      (pythonic-activate "~/miniconda2/envs/ml")
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
(fringe-mode '(4 . 4))

;; Enable paren mode at start
(show-paren-mode 1)

;; Enable line numbers
(global-linum-mode 0)

;; Defining switch tabs commands
(global-set-key [C-iso-lefttab] 
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

;;Beacon minor mode
(use-package beacon
  :ensure t
  :diminish beacon-mode
  :init (beacon-mode 1)
        ;; For deeper-blue theme
        ;;(setq beacon-color "#00ff00")
        ;; For monokai theme
        (setq beacon-color "#AE81FF")
        (setq beacon-size 60)
	(setq beacon-blink-delay 0.5))

;; Emacs Ipython Notebook
(use-package ein
  :ensure t
  :init (setq ein:use-auto-complete t)
;;  (setq ein:use-smartrep t)
  (setq auto-complete-mode t)
  )

(setq ein:use-auto-complete-superpack t)
;;(setq ein:use-smartrep t)

(setq ein:notebook-modes '(ein:notebook-multilang-mode ein:notebook-python-mode))


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


;; Change selected text highlight color #102050
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-quickhelp-color-background "dark slate gray")
 '(company-quickhelp-color-foreground "wheat")
 '(markdown-command "/usr/bin/pandoc")
 '(org-agenda-files (quote ("~/Dropbox/Agenda/todo.org")))
 '(region ((t (:background "#102050"))))
 '(show-paren-match ((t (:weight (quote extra-bold))))))

;; Disable edebug key binds

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
(use-package which-func
  :ensure t
  :config
  (setq which-func-modes '(python-mode))
  (add-hook 'python-mode-hook '(lambda () (which-func-mode t))))

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

;; ERC
(add-to-list 'load-path "~/.emacs.d/elisp/erc-extras" t)
(use-package erc-hl-nicks
  :ensure t)
(require 'erc-hl-nicks)
(require 'erc-nicklist)
(require 'erc-notify)
(require 'erc-match)

(erc-spelling-mode 1)
(add-hook 'erc-mode-hook (lambda () (auto-fill-mode 0)))
(make-variable-buffer-local 'erc-fill-column)
 (add-hook 'window-configuration-change-hook 
	   '(lambda ()
	      (save-excursion
	        (walk-windows
		 (lambda (w)
		   (let ((buffer (window-buffer w)))
		     (set-buffer buffer)
		     (when (eq major-mode 'erc-mode)
		       (setq erc-fill-column (- (window-width w) 2)))))))))

(erc :server "irc.freenode.net" :port 6667 :nick "lgmoneda")

(load "~/.ercfile")
(require 'erc-services)
(erc-services-mode 1)
(setq erc-prompt-for-nickserv-password nil)
(setq erc-nickserv-passwords
      `((freenode (("lgmoneda" . ,lgmonedanick)))))

;; Prevents Erc buffers flashing at start
(erc-autojoin-mode t)
(setq erc-autojoin-timing :ident)
(setq erc-autojoin-delay 20)
(setq erc-join-buffer 'bury)
(setq erc-autojoin-channels-alist
      '(("freenode.net" "#emacs" "#sptk" "##machinelearning"
	 "#scikit-learn" "#tensorflow")))
(erc-autojoin-after-ident "irc.freenode.net" "lgmoneda")

(add-hook 'erc-nickserv-identified-hook 'erc-autojoin-after-ident)
;;(erc :server "irc.freenode.net" :port 6667 :nick "lgmoneda")


;; Log in a buffer when people talk to me
(setq erc-log-matches-flag t)
(setq erc-log-matches-types-alist
          '((keyword . "### Keywords Log ###")
            (current-nick . "### Me Log ###")))

(setq erc-keywords '("keras" "bayes" "bayesian" "causality" "reinforcement"))

;; Erc-tracking
;; Exclude not interesting messages
;; Blue for keyword
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"))
				;; "324" "329" "332" "333" "353" "477"))

;; Ignore Server Buffer
(setq erc-track-exclude-server-buffer t)

;; Track only mentions and keywords
(setq erc-track-use-faces t)
(setq erc-format-query-as-channel-p t)

;;Show pvt, current-nick and keyword
(setq erc-track-faces-priority-list
      '(erc-current-nick-face
	erc-keyword-face
	erc-direct-msg-face))

(setq erc-track-priority-faces-only 'all)

;; That fixes the modeline notification for nick mention
(setq erc-current-nick-highlight-type 'nick)

;;(setq erc-query-display 'bury)
;; Prevent the new created buffer from pvt to be brought visible
(setq erc-auto-query 'bury)

;; Both defadvices to track pvts using channels mode-line face
(defadvice erc-track-find-face (around erc-track-find-face-promote-query activate)
  (if (erc-query-buffer-p) 
      (setq ad-return-value (intern "erc-current-nick-face"))
    ad-do-it))

(defadvice erc-track-modified-channels (around erc-track-modified-channels-promote-query activate)
  (if (erc-query-buffer-p) (setq erc-track-priority-faces-only 'nil))
  ad-do-it
  (if (erc-query-buffer-p) (setq erc-track-priority-faces-only 'all)))

;; bk's toggle nicklist!
(defun bk/nicklist-toggle ()
  "Function to toggle the nicklist in ERC mode."
  (interactive)
  (let ((nicklist-buffer-name (format " *%s-nicklist*" (buffer-name))))
    (if (get-buffer nicklist-buffer-name)
        (kill-buffer nicklist-buffer-name)
      (erc-nicklist))))

(define-key erc-mode-map (kbd "<f7>") 'bk/nicklist-toggle)

;; Smarter beep
;; Remember to apt-get install mplayer!
;; todo: no beep when buffer is visible
(add-hook 'erc-text-matched-hook 'erc-sound-if-not-server)
(defun erc-sound-if-not-server (match-type nickuserhost msg)
      (unless (or (string-match "Server" nickuserhost) (string-match nickuserhost (erc-current-nick)))
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


(defun notify-privmsg-mode-line (proc parsed)
  (let ((nick (car (erc-parse-user (erc-response.sender parsed))))
        (target (car (erc-response.command-args parsed)))
        (msg (erc-response.contents parsed)))
    (when (and (erc-current-nick-p target)
               (not (erc-is-message-ctcp-and-not-action-p msg)))
      (setq mode-line-end-spaces (format "[pvt:%s]" nick)
                         msg
                         nil)
      ))
  nil)


;; TODO
;; 
(setq unread-pvt-msgs '())
(defun notify-privmsg-mode-line (proc parsed)
  (let ((nick (car (erc-parse-user (erc-response.sender parsed))))
        (target (car (erc-response.command-args parsed)))
        (msg (erc-response.contents parsed)))
    (when (and (erc-current-nick-p target)
               (not (erc-is-message-ctcp-and-not-action-p msg)))
      ;; (setq mode-line-end-spaces (format "[last pvt:%s]" nick)
      ;;                    msg
      ;;                    nil)
      (if (eq (cdr (assoc nick unread-pvt-msgs)) nil)
	  (add-to-list 'unread-pvt-msgs `(,nick . 1))
	(progn
	  (setq new-value  (+ (cdr (assoc nick unread-pvt-msgs)) 1)    )
	  (setf (cdr (assoc nick unread-pvt-msgs)) new-value)
	  )
	)
	(setq mode-line-end-spaces (format "[%s:%s (%d)]"
					   (format-time-string "%Hh%M" (date-to-time (current-time-string)))
					   nick
					   (cdr (assoc nick unread-pvt-msgs)) )
	      msg
	      nil)
	(display-unread-pvts)      
      ;;(print unread-pvt-msgs)
      ))
  nil)

(add-hook 'after-change-major-mode-hook 'read-erc-msgs)

(defun display-unread-pvts ()
  (interactive)
  (setq pvt-status-string "[unread pvt:")
  (mapcar (lambda (element)
	    (print element)
	   (setq pvt-status-string (concat pvt-status-string (format " %s(%d)," (car element) (cdr element))))	    
	    )
	  unread-pvt-msgs
	  )
  (setq pvt-status-string (subseq pvt-status-string 0 (- (length pvt-status-string) 1)))

  (setq pvt-status-string (concat  pvt-status-string "]"))
  (message pvt-status-string)
  )

;; Reference: https://www.emacswiki.org/emacs/SwitchToErc
;; Use erc-query-buffer-p
(defun read-erc-msgs ())

(add-hook 'erc-server-PRIVMSG-functions 'notify-privmsg-mode-line t)

;; E-mail config
(setq user-mail-address "lg.moneda@gmail.com")
(setq user-full-name "Luis Moneda")

(setq send-mail-function 'smtpmail-send-it)
(setq smtpmail-auth-credentials (expand-file-name "~/.authinfo"))
(setq smtpmail-smtp-server "smtp.gmail.com")
(setq smtpmail-smtp-service 587)
(setq message-signature "Luis Moneda
http://lgmoneda.github.io/")

;; Mode line α
(defvar mode-line-cleaner-alist
  `((auto-complete-mode . "")
    (yas/minor-mode . " υ")
    (paredit-mode . " π")
    (eldoc-mode . "")
    (hs-minor-mode . "")
    (which-key-mode . "")
    (smartparens-mode . "")
    (abbrev-mode . "")
    (company-mode . "")
    (eldoc-mode . "")
    (visual-line-mode . "")
    (flyspell-mode . "")
    (color-identifiers-mode . "")
    (auto-revert-mode . "")
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

;; ORG MODE
(require 'org)

;; New states to to-do
(setq org-todo-keywords
      ;;      '((sequence "TODO(t)" "STARTED(s)"  "WAIT(w)" "|" "DONE(d)" "CANCELED(c)" "FAIL(f)")))
            '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "CANCELED(c)" "FAIL(f)")))

(setq org-todo-keyword-faces
      '(("TODO" . org-warning)
;;	("STARTED" . "yellow")
	("WAIT" . "purple") 
        ("CANCELED" . (:foreground "blue" :weight bold))
        ("FAIL" . (:foreground "blue" :weight bold))))

;; No line number in org mode, please
(add-hook 'org-mode-hook (linum-mode 0))
(add-hook 'after-init-hook 'org-agenda-list)
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

;; Start with my to-do
;; The org mode file is opened with
(find-file "~/Dropbox/Agenda/todo.org")

;; Org Journal
(use-package org-journal
  :ensure t
  :init (setq org-journal-dir "~/Dropbox/Agenda/Journal"))

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
          (hide-sublevels (org-journal-time-entry-level))
        (show-all))

      ;; open the recent entry when the prefix is given
      (when should-add-entry-p
        (show-entry))

      (set-buffer-modified-p unsaved))))

(defun journal-get-modification-date ()
  "Returns the last modified date of the current memento file."
  (format-time-string "%Y-%m-%d"
                      (nth 5 (file-attributes journal-file))))

(defun journal-check-when-quit ()
  (interactive)
  (if (file-exists-p journal-file)
      ;; Check if there was a log written today. If this is not the case, then check if it's already tonight except the night.
      (if (and (string< (journal-get-modification-date) (format-time-string "%Y-%m-%d")) (or (string< (format-time-string "%k") " 6") (string< "20" (format-time-string "%k"))))
          ;; Invoke Memento if the user wants to proceed. 
          (if (yes-or-no-p "Do you want to write your Journal?")
              (progn (call-interactively 'lgm/org-journal-new-today-entry))))
    ;; If the Memento file doesn't exist yet, create a file and proceed with creating a log.
    (write-region "" nil journal-file)
    (progn (call-interactively 'lgm/org-journal-new-today-entry))))


(add-hook 'kill-emacs-hook 'journal-check-when-quit)

;; Dict.cc wrap
(add-to-list 'load-path "~/.emacs.d/elisp/dict-cc" t)
(require 'dict-cc)
;; PATH append
(setenv "PATH" (concat "/home/lgmoneda/miniconda2/bin:" (getenv "PATH")))

;; Python Experiment!
;; (add-to-list 'load-path "~/.emacs.d/site-packages/python-experiment")
;; (require 'python-experiment)

;; (global-set-key (kbd "<f9>") 'python-experiment)
;; (global-set-key (kbd "<f10>") 'python-experiment-lived-too-long)
;; (global-set-key (kbd "<f11>") 'python-experiment-reload)
;; (global-set-key (kbd "<f12>") 'python-experiment-buffer-to-file)


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

(global-set-key (kbd "C-ç") 'mark-a-word-or-thing)
(global-set-key (kbd "C-=") 'er/expand-region)


;; Fix it later
;; (setq package-enable-at-startup nil)
;; (package-initialize)

;; ;; Enable arrow keys in some modes
;; (defun arrow-keys-disable ()
;; (mapc 'global-unset-key '([left] [right] [up] [down]))

;; (let ((arrow-key-mode-maps '(help-mode-map org-agenda-mode-map Info-mode-map org-mode-map)))
;;   (mapc
;;    (lambda (map)
;;      (define-key (symbol-value map) [left] 'left-char)
;;      (define-key (symbol-value map) [right] 'right-char)
;;      (define-key (symbol-value map) [up] 'previous-line)
;;      (define-key (symbol-value map) [down] 'next-line))
;;    arrow-key-mode-maps)))

;; (add-hook 'after-init-hook 'arrow-keys-disable)

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
(custom-set-faces
 `(lazy-highlight ((t (:foreground "white" :background "SteelBlue"))))
 `(isearch ((t (:foreground "white" :background "DarkOrchid")))))
