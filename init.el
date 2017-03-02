;; Load Theme
;; Use 'monokai when missing sublime
(setq custom-safe-themes t)
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (load-theme 'monokai)))

;; Package Management
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
     '("melpa" . "https://melpa.org/packages/"))
     ;; '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives
     '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)


;; Fast jump to elisp function
(global-set-key (kbd "C-h C-f") 'jump-to-elisp-func-def)

(defun jump-to-elisp-func-def ()
  (interactive)
  (find-function (function-called-at-point))
  ) 

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Helm
(use-package helm
  :ensure t)

;; Auto Complete
(use-package auto-complete
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

;; Spotify
;; (use-package helm-spotify
;;   :ensure t)

;; (use-package todochiku
;;   :ensure t
;;   :config (setq todochiku-icons-directory "~/.emacs.d/todochiku-icons"))

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
    ;;    '(add-to-list 'company-backends '(company-anaconda company-dabbrev company-capf))))
    '(add-to-list 'company-backends '(company-anaconda))))

;;(add-hook 'python-mode-hook 'company-mode)

;; enable eldoc in programming modes
;;(add-hook 'prog-mode-hook 'turn-on-eldoc-mode)

;; enable eldoc in your programming modes
(use-package eldoc
  :ensure t
  :diminish 
  :commands eldoc-mode
  :init
  (setq eldoc-idle-delay 0.1
	eldoc-echo-area-use-multiline-p nil)
  :config
  (add-hook 'prog-mode-hook 'turn-on-eldoc-mode))

;; (add-hook 'python-mode-hook 'anaconda-eldoc-mode)

;; Jedi
;; (setq jedi-mode t)
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:complete-on-dot t)


;; Enable hide definitions functions
(add-hook 'prog-mode-hook 'hs-minor-mode)
(global-set-key [f4] 'hs-toggle-hiding)

;; Company to display pop-ups 
;; (use-package company
;;   :ensure t)

;; (add-hook 'after-init-hook 'global-company-mode)
;; (setq company-minimum-prefix-length 2)

(use-package company
  :ensure t
  :diminish
  :defer 4
  :init (progn
          (global-company-mode)
          (setq company-global-modes '(not python-mode cython-mode sage-mode))
          )
  :config (progn
            (setq company-tooltip-limit 6
                  company-idle-delay .3
                  company-echo-delay 0.3
                  company-begin-commands '(self-insert-command)
                  company-transformers '(company-sort-by-occurrence)
                  company-selection-wrap-around t
                  company-minimum-prefix-length 3
                  company-dabbrev-downcase nil
                  )
            (bind-keys :map company-active-map
                       ("C-n" . company-select-next)
                       ("C-p" . company-select-previous)
                       ("C-d" . company-show-doc-buffer)
                       ("<tab>" . company-complete)
                       ("<escape>" . company-abort)
                       )
            )
  )


;; Pair parenthesis
(use-package smartparens
  :ensure t
  :init (smartparens-global-mode)
  (sp-pair "'" nil :actions :rem)
  (sp-pair "`" nil :actions :rem))

  ;; Disable smartparens for most pairs, my editing style doesn't play well with it
  ;; (eval-after-load 'smartparens
  ;;   '(progn
  ;;      (sp-pair "(" nil :actions :rem)
  ;;      (sp-pair "[" nil :actions :rem)
  ;;      (sp-pair "'" nil :actions :rem)
;;      (sp-pair "\"" nil :actions :rem)))

;; Display time in the mode-line
(setq display-time-format "%Hh%M")
(display-time-mode 0)

;; To activate pytevec environment
(defun apytevec ()
  (interactive)
  (pythonic-activate "~/miniconda2/envs/pytevec")
  )

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

;; Run python first time 
;; (defun run-python-once ()
;;   (remove-hook 'python-mode-hook 'run-python-once)
;;   (run-python (python-shell-parse-command)))

;; (add-hook 'python-mode-hook 'run-python-once)

;; Hiding menu and tool bar
(menu-bar-mode -99)
(tool-bar-mode -99)

;; Defining switch tabs commands
(global-set-key [C-iso-lefttab] 
    (lambda ()
      (interactive)
      (other-window -1)))

;Defining switch tabs commands
(global-set-key [C-tab] 
    (lambda ()
      (interactive)
      (other-window 1)))

;Defining switch buffer command
(global-set-key (kbd "C-1")
    (lambda ()
      (interactive)
      (switch-to-prev-buffer)))

;Defining switch buffer command
(global-set-key (kbd "C-'")
    (lambda ()
      (interactive)
      (bury-buffer)))

;Defining switch frames command
(global-set-key (kbd "C-2")
    (lambda ()
      (interactive)
      (other-frame 1)))

;Initialize in full screen
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(put 'upcase-region 'disabled nil)

;Which-key minor mode
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

(require 'comint)
(setq comint-password-prompt-regexp
		    (concat comint-password-prompt-regexp
			    "\\|^Password for .*:\\s *\\'"))

;; Enable paren mode at start
(show-paren-mode 1)

;; Enable line numbers
(global-linum-mode 1)

;; avy
(use-package avy
  :ensure t)

(global-set-key (kbd "C-:") 'avy-goto-char)
(global-set-key (kbd "C-?") 'avy-goto-line)


;; custom package
;; load the custom helm-spotify-plus
(use-package multi
  :ensure t)

(load-file "~/repos/helm-spotify-plus/helm-spotify-plus.el")

;; Replace highlighted text
(delete-selection-mode 1)

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


;; (setq pop-up-frames nil)
;; (defun my-python-shell-run ()
;;   (interactive)
;;   (python-shell-send-buffer)
;;   (python-shell-switch-to-shell)
;;   )

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

;; (define-key ein:notebook-mode-map (kbd "TAB") 'ein:completer-complete)

(setq ein:notebook-modes '(ein:notebook-multilang-mode ein:notebook-python-mode))


(defun fancy-tab (arg)
  (interactive "P")
  (setq this-command last-command)
  (if (or (eq this-command 'hippie-expand) (looking-at "\\_>"))
      (progn
	(setq this-command 'hippie-expand)
	(hippie-expand arg))
    (setq this-command 'indent-for-tab-command)
    (indent-for-tab-command arg)))


;; (define-key read-expression-map [(tab)] 'hippie-expand)
;; (global-set-key (kbd "TAB") 'fancy-tab)

;; (add-hook 'python-mode-hook
;;   (lambda () (setq indent-tabs-mode t)))
;; (setq company-idle-delay nil)

;; (setq company-idle-begin 0)
;; (setq-default tab-always-indent 'complete)

;;(define-key company-mode-map (kbd "TAB") 'company-complete-common)

;; (defun indent-or-complete ()
;;   "Complete if point is at end of line, and indent line."
;;   (interactive)
;;   (if (and (looking-at "$") (not (looking-back "^\\s-*")))
;;       (hippie-expand nil))
;;   (indent-for-tab-command)
;;   )

;; Adjusting Mouse sensitivity
(setq mouse-wheel-progressive-speed nil)

;; Trying to reproduce arrow keys
;; (define-key key-translation-map (kbd "C-l") (kbd "\C-b"))
;; (define-key key-translation-map (kbd "M-l") (kbd "M-b"))
;; (define-key key-translation-map (kbd "<C-dead-tilde>") (kbd "\C-f"))
;; (define-key key-translation-map (kbd "<C-dead-tilde>") (kbd "M-f"))
;; (define-key key-translation-map (kbd "C-ç") (kbd "\C-n"))


;; Pair parenthesis
;; (use-package autopair
;;   :ensure t)

;; (autopair-global-mode)

;; ERC
(add-to-list 'load-path "~/.emacs.d/elisp/erc-extras" t)
(require 'erc-hl-nicks)
(require 'erc-nicklist)
(require 'erc-notify)
(require 'erc-match)

(erc-spelling-mode 1)

(erc :server "irc.freenode.net" :port 6667 :nick "lgmoneda")

(load "~/.ercfile")
(require 'erc-services)
(erc-services-mode 1)
(setq erc-prompt-for-nickserv-password nil)
(setq erc-nickserv-passwords
      `((freenode     (("lgmoneda" . ,lgmonedanick)))))


;; Prevents Erc buffers flashing at start
(erc-autojoin-mode t)
(setq erc-autojoin-timing :ident)
(setq erc-autojoin-delay 20)
(setq erc-join-buffer 'bury)
(setq erc-autojoin-channels-alist
          '(("freenode.net" "#emacs" "#sptk" "##machinelearning")))
(erc-autojoin-after-ident "irc.freenode.net" "lgmoneda")

(add-hook 'erc-nickserv-identified-hook 'erc-autojoin-after-ident)
;;(erc :server "irc.freenode.net" :port 6667 :nick "lgmoneda")


;; Log in a buffer when people talk to me
(setq erc-log-matches-flag t)
(setq erc-log-matches-types-alist
          '((keyword . "### Keywords")
            (current-nick . "### Me")))

(setq erc-keywords '("keras" "bayes" "causality" "tensorflow" "python"))

;; Smarter beep
(add-hook 'erc-text-matched-hook 'erc-sound-if-not-server)
(defun erc-sound-if-not-server (match-type nickuserhost msg)
      (unless (or (string-match "Server" nickuserhost) (string-match nickuserhost (erc-current-nick)))
	(start-process-shell-command "lolsound" nil "mplayer ~/.emacs.d/sounds/icq-message.wav")
	;;(setq mode-line-end-spaces
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
		      ))))

;; Beep when mention me
;; (add-hook 'erc-text-matched-hook 'erc-beep-on-match)
;; (setq erc-beep-match-types '(current-nick keyword))

;; Sound for private msg
;; (defun erc-my-privmsg-sound (proc parsed)
;;   (let* ((tgt (car (erc-response.command-args parsed)))
;; 	 (privp (erc-current-nick-p tgt)))
;;     (and
;;      privp
;;      (sound)
;;      nil))) ;We must return nil. See help for `erc-server-PRIVMSG-functions'

;; (add-hook 'erc-server-PRIVMSG-functions
;; 	  'erc-my-privmsg-sound)

;; (setq sound-default "~/.emacs.d/sounds/beep.wav")

;; (defun sound (&optional path)
;;   (start-process-shell-command
;;    "sound"
;;    nil
;;    (concat "mplayer -fcd " (or path sound-default))))

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

(setq unread-pvt-msgs '(("placeholder" . 1)))
(defun notify-privmsg-mode-line (proc parsed)
  (let ((nick (car (erc-parse-user (erc-response.sender parsed))))
        (target (car (erc-response.command-args parsed)))
        (msg (erc-response.contents parsed)))
    (when (and (erc-current-nick-p target)
               (not (erc-is-message-ctcp-and-not-action-p msg)))
      (setq mode-line-end-spaces (format "[pvt:%s]" nick)
                         msg
                         nil)
      (if (eq (cdr (assoc nick unread-pvt-msgs)) nil)
	  (add-to-list 'unread-pvt-msgs `(,nick . 1))
	(progn
	  (setq new-value  (+ (cdr (assoc nick unread-pvt-msgs)) 1)    )
	  (setf (cdr (assoc nick unread-pvt-msgs)) new-value)
	  (setq mode-line-end-spaces (format "[pvt:%s (%d)]" nick (cdr (assoc nick unread-pvt-msgs)) )
		msg
		nil)
	  )
	)
      ;;(print unread-pvt-msgs)
      ))
  nil)

;; (+ (cdr (assoc "nick" unread-pvt-msgs)) 1

(add-hook 'erc-server-PRIVMSG-functions 'notify-privmsg-mode-line t)

;; (setq amigo "amigo")
;; (setq minha-lista `(("amigo" . 1)))
;; (setq x (+ (cdr (assoc amigo minha-lista)) 1))
;; (add-to-list 'minha-lista `("amigo" . ,x))


;; E-mail config
(setq user-mail-address "lg.moneda@gmail.com")
(setq user-full-name "Luis Moneda")

(setq send-mail-function 'smtpmail-send-it)
(setq smtpmail-auth-credentials (expand-file-name "~/.authinfo"))
(setq smtpmail-smtp-server "smtp.gmail.com")
(setq smtpmail-smtp-service 587)
(setq message-signature "Luis Moneda
http://lgmoneda.github.io/")

;; Mode line

(defvar mode-line-cleaner-alist
  `((auto-complete-mode . " α")
    (yas/minor-mode . " υ")
    (paredit-mode . " π")
    (eldoc-mode . "")
    (hs-minor-mode . "")
    (which-key-mode . "")
    (smartparens-mode . "")
    (abbrev-mode . "")
    (company-mode . "")
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
