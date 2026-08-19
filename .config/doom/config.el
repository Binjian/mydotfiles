;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")
(setq user-full-name "Binjian Xin"
      user-mail-address "binjian.xin@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

(setq doom-font (font-spec :family "Iosevka NF" :size 14 :weight 'medium)
      doom-serif-font doom-font
      doom-symbol-font (font-spec :family "Iosevka NF")
      doom-variable-pitch-font (font-spec :family "Iosevka NF" :size 14 :weight 'extra-bold))

(setq use-default-font-for-symbols nil) 

(defun my-cjk-font()
  (dolist (charset '(kana han cjk-misc hangul kanbun symbol bopomofo))
    (set-fontset-font t charset (font-spec :family "LXGW Wenkai Mono")))
  (dolist (charset '((#x2018 . #x2019)      ;; Curly single quotes "‘’"
                     (#x201c . #x201d)))))  ;; Curly double quotes "“”"


(add-hook! 'after-setting-font-hook
           #'my-cjk-font
           (set-fontset-font t 'latin (font-spec :family "Iosevka NF"))
           (set-fontset-font t 'symbol (font-spec :family "Iosevka NF"))
           (set-fontset-font t 'mathematical (font-spec :family "Iosevka NF"))
           (set-fontset-font t 'emoji (font-spec :family "Iosevka NF")))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'leuven-dark)

(defhydra doom-window-resize-hydra (:hint nil)
  "
             _k_ increase height
_h_ decrease width    _l_ increase width
             _j_ decrease height
"
  ("h" evil-window-decrease-width)
  ("j" evil-window-increase-height)
  ("k" evil-window-decrease-height)
  ("l" evil-window-increase-width)

  ("q" nil))

(map!
 (:prefix "w"
  :desc "Hydra resize" :n "SPC" #'doom-window-resize-hydra/body))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


(setq persp-emacsclient-init-frame-behaviour-override "main")

;; Command to list ignored files:
;; $ git ls-files --others --ignored --exclude-standard --directory
(defun magit-ignored-files ()
  (magit-git-items "ls-files" "--others" "--ignored" "--exclude-standard" "-z" "--directory"))

(defun magit-insert-ignored-files ()
  (-when-let (files (magit-ignored-files))
    (magit-insert-section (ignored)
      (magit-insert-heading "Ignored files:")
      (magit-insert-un/tracked-files-1 files nil)
      (insert ?\n))))

(setq magit-status-headers-hook '(magit-insert-error-header
                                  magit-insert-diff-filter-header
                                  magit-insert-head-branch-header
                                  magit-insert-upstream-branch-header
                                  magit-insert-push-branch-header
                                  magit-insert-tags-header
                                  magit-insert-ignored-files
                                  ))

(defun magit-add-current-buffer ()
  "Adds (with force) the file from the current buffer to the git repo"
  (interactive)
  (shell-command (concat "git add -f "
                         (shell-quote-argument buffer-file-name))))


(setq dired-dwim-target t)

(with-eval-after-load 'info
  (info-initialize) ; Consult INFOPATH.
  ;; Always add the default value, regardless of what INFOPATH says.
  (dolist (info-dir (Info-default-dirs))
    (add-to-list 'Info-directory-list info-dir)))


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory  (concat (getenv "HOME") "/.org.d"))

;; set export path
(setq org-publish-project-alist
      '(("org-notes"
         :base-directory (concat (getenv "HOME") "/.org.d")
         :publishing-function org-html-publish-to-html
         :publishing-directory (concat (getenv "HOME") "/.org.d/exports")
         )

        ("org-static"
         :base-extension "png"
         :base-directory (concat (getenv "HOME") "/.org.d")
         :publishing-function org-publish-attachment
         :publishing-directory (concat (getenv "HOME") "/.org.d/exports")
         )

        ("org" :components ("org-notes" "org-static"))))


(after! org
  (load-library "ox-reveal")
  (setq org-todo-keywords
        '((sequence "TODO(t)" "STARTED(s!)" "|" "DONE(d!)" "WAITING(w@/!)" "DELEGATED(g@/!)" "CANCELLED(c@)" "DEFERRED(f@)"))))

(setq org-agenda-files (list (concat (getenv "HOME") "/.org.d/agenda/projects.org")
                             (concat (getenv "HOME") "/.org.d/agenda/managements.org")
                             (concat (getenv "HOME") "/.org.d/agenda/research.org")))


(setq org-tag-alist '(("battery" . ?b) ("veos" . ?v) ("simulation" . ?s) ("research" . ?r)))

;; set org-roam directory
(setq org-roam-directory (concat (getenv "HOME") "/.org.d/roam"))


(setq org-element-use-cache nil)

;;(setq yas-snippet-dirs '(
;;	         (concat (getenv "HOME") "/.org.d/snippets/doom-suite")
;;                         (concat (getenv "HOME") "/.org.d/snippets/andreacrotti-suite/snippets")
;;                         (concat (getenv "HOME") "/.org.d/snippets/mooerslab-org")
;;                         (concat (getenv "HOME") "/.org.d/snippets/madsdk-latex") ))
(yas-global-mode 1)


(latex-preview-pane-enable)
;;(setq lsp-tex-server 'digestif)
;; set XeTeX mode in TeX/LaTeX
(add-hook 'LaTeX-mode-hook
          (lambda()
            (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
            (setq TeX-command-default "XeLaTeX")
            (setq TeX-save-query nil)
            (setq TeX-show-compilation t)))

                                        ;(setq browse-url-browser-function 'browse-url-default-windows-browser)
;;(add-hook LaTeX-mode-hook 'xenops-mode)

(use-package! websocket
  :after org-roam2)

(use-package! org-roam-ui
  :after org-roam2
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-completion-everywhere t
        org-roam-ui-open-on-start t))
(setq org-superstar-headline-bullets-list '("⁖" "◉" "○" "✸" "✿"))
(setq org-superstar-item-bullet-alist '((?- . "•") (?+ . "☞") (?* . "★")))

(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(setq org-journal-dir (concat (getenv "HOME") "/.org.d/journal")
      org-journal-date-prefix "#+TITLE: "
      org-journal-time-prefix "* "
      org-journal-date-format "%a, %Y-%m-%d"
      org-journal-file-format "%Y-%m-%d.org")
(setq org-journal-enable-agenda-integration t)
(setq auto-save-default t
      make-backup-files t)

(setq confirm-kill-emacs nil)
(let ((alternatives '("doom-emacs-bw-light.svg"
                      "doom-emacs-flugo-slant_out_purple-small.png"
                      "doom-emacs-flugo-slant_out_bw-small.png")))
  (setq fancy-splash-image
        (concat doom-user-dir "splash/"
                (nth (random (length alternatives)) alternatives))))

(after! org
  (setq org-special-ctrl-a/e t)
  (setq org-special-ctrl-k t))

(use-package! org-super-agenda
  :after org-agenda
  :config
  (setq org-super-agenda-groups '((:auto-dir-name t)))
  (org-super-agenda-mode))

(use-package! org-archive
  :after org--file-cache
  :config
  (setq org-archive-location "archive.org::datetree/"))

(after! org-clock
  (setq org-clock-persist t)
  (setq org-clock-sound (concat (getenv "HOME") "/.local/resources/long-ding.wav"))
  (org-clock-persistence-insinuate))

;;(after! org-pomodoro
;;  (setq org-pomodoro-long-break-sound (concat (getenv "HOME") "/.local/resource/long-ding.wav")))
;; Tomatinho Pomodoro Timer

(after! org-pomodoro
  (setq org-pomodoro-audio-player "/usr/bin/aplay")
  (setq org-pomodoro-ticking-sound-p nil)
  (setq org-pomodoro-finished-sound-p t)
  ;;(setq org-pomodoro-overtime-sound (concat (getenv "HOME") "/.local/resources/Free-electro-house-drum-loop.wav"))
  (setq org-pomodoro-overtime-sound (concat (getenv "HOME") "/.local/resources/bell.wav"))
  (setq org-pomodoro-short-break-sound (concat (getenv "HOME") "/.local/resources/bell.wav"))
  (setq org-pomodoro-long-break-sound  (concat (getenv "HOME") "/.local/resources/bell_mulitple.wav"))
  (setq org-pomodoro-finished-sound  (concat (getenv "HOME") "/.local/resources/long-ding.wav"))
  (setq org-pomodoro-ticking-sound (concat (getenv "HOME") "/.local/resources/tick.wav"))
                                        ;(setq org-pomodoro-ticking-sound "/home/betsy/emacs.d/sms-alert-1-daniel_simon.wav")
                                        ;  (setq org-pomodoro-ticking-sound "/home/betsy/emacs.d/elpa/org-pomodoro-20220318.1618/resources/tick.wav")
  (setq org-pomodoro-start-sound (concat (getenv "HOME") "/.local/resources/bell.wav"))
  (setq org-pomodoro-start-sound-p t)
  (setq org-pomodoro-keep-killed-pomodoro-time t)
  (setq org-pomodoro-manual-break t)
  (setq org-pomodoro-clock-break t)
  (setq org-pomodoro-ticking-frequency 1)
  (setq org-pomodoro-ticking-sound-states '(:pomodoro :overtime))
  (setq org-pomodoro-length 25
        org-pomodoro-short-break-length 5)
  )

(use-package! org-jira
  :after org)
(make-directory (concat (getenv "HOME") "/.org.d/agenda/jira") 'ignore-if-exists)
;;(setq jiralib-url "https://jira.newrizon.work/")

(setq request-log-level 'blather)
(setq request-message-level 'blather)

;;(use-package! lsp-pyright
;;  :hook (python-mode . (lambda () (require 'lsp-pyright)))
;;  :custom
;;  (lsp-pyright-multi-root nil))

(setq clippy-tip-show-function #'clippy-popup-tip-show)
;;(use-package! highlight-indent-guides
;;  :hook 'prog-mode-hook 'highlight-indent-guides-mode)


;;(setq exec-path (append exec-path '("/d/miniconda3/bin")))
;;(setq exec-path (append exec-path '("/dpt/micromamba/bin")))
;;(setq exec-path (append exec-path '("/dpt/.pyenv/shims/")))
;; (setq hightlight-indent-guides-method 'fill)
;;(use-package! lsp-pyright
;;  :ensure t
;;  :hook (python-mode . (lambda ()
;;                         (require 'lsp-pyright)
;;                         (lsp))))  ; or lsp-deferred

;;(setq lsp-pyright-use-library-code-for-types t) ;; set this to nil if getting too many false positive type errors
;;(setq lsp-pyright-stub-path (concat (getenv "HOME") "/src/python-type-stubs")) ;; example
;;(setq poetry-tracking-mode nil)
;;(setq lsp-enable-file-watchers nil)

;;(setq grip-binary-path "/home/is/.local/bin/grip")
;;(add-hook 'markdown-mode-hook #'grip-mode)
;;(add-hook 'org-mode-hook #'grip-mode)
;;(setq grip-url-browser "google-chrome")
;;(setq grip-update-after-chage nil)

(setq markdown-split-window-direction 'right)
(setq markdown-enable-wiki-links t
      markdown-enable-math t
      markdown-italic-underscore t
      markdown-asymmetric-header t
      markdown-make-gfm-checkboxes-buttons t)

'(+markdown-compile-pandoc
  +markdown-compile-marked
  +markdown-compile-markdown
  +markdown-compile-multimarkdown)

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

(use-package! pdf-tools
  :config
  (setq-default pdf-view-display-size 'fit-width)
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
  :custom
  (pdf-annot-activate-created-annotations t "automatically annotate highlights"))

(setq pdf-view-use-scaling t
      pdf-view-use-imagemagick nil)

(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))
      TeX-source-correlate-start-server t)

(add-hook 'TeX-after-compilation-finished-functions
          #'TeX-revert-document-buffer)

                                        ; START TABS CONFIG
;; Create a variable for our preferred tab width
(setq custom-tab-width 2)

(setq centaur-tabs-icon-type 'nerd-icons)

;; Two callable functions for enabling/disabling tabs in Emacs
(defun disable-tabs () (setq indent-tabs-mode nil))
(defun enable-tabs  ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode t)
  (setq tab-width custom-tab-width))

;; Hooks to Enable Tabs
(add-hook 'prog-mode-hook 'enable-tabs)
;; Hooks to Disable Tabs
(add-hook 'lisp-mode-hook 'disable-tabs)
(add-hook 'emacs-lisp-mode-hook 'disable-tabs)

;; Language-Specific Tweaks
(setq-default python-indent-offset custom-tab-width) ;; Python
(setq-default js-indent-level custom-tab-width)      ;; Javascript
;;(setq +python-ipython-repl-args '("-i" "--simple-prompt" "--no-color-info"))
;;(setq +python-jupyter-repl-args '("--simple-prompt"))

;; Making electric-indent behave sanely
(setq-default electric-indent-inhibit t)
;; C indent
(setq-default c-basic-offset custom-tab-width)
;; Make the backspace properly erase the tab instead of
;; removing 1 space at a time.
(setq backward-delete-char-untabify-method 'hungry)

;; (OPTIONAL) Shift width for evil-mode users
;; For the vim-like motions of ">>" and "<<".
(setq-default evil-shift-width custom-tab-width)

;; WARNING: This will change your life
;; (OPTIONAL) Visualize tabs as a pipe character - "|"
;; This will also show trailing characters as they are useful to spot.
(setq whitespace-style '(face tabs tab-mark trailing))
(custom-set-faces
 '(whitespace-tab ((t (:foreground "#636363")))))
(setq whitespace-display-mappings
      '((tab-mark 9 [124 9] [92 9]))) ; 124 is the ascii ID for '\|'
(global-whitespace-mode) ; Enable whitespace mode everywhere
                                        ; END TABS CONFIG

(require 'logview) ;; if you want interactive shell support, include:
(setq doom-themes-neotree-file-icons t)

(setq tramp-default-method "ssh")
(after! tramp
  (setenv "SHELL" "/bin/zsh")
  (setq tramp-shell-prompt-pattern "\\(?:^\\|\\)[^]#$%>\0]*#?[]#$%>].* *\\(\\[[n-9;]*[a-zA-Z] *\\)*")) ;; default + ?
;; (eval-after-load 'tramp '(setenv "SHELL" "/bin/zsh"))


(use-package! focus)

;;(add-to-list 'load-path "~/.emacs.d/impatient-mode")
(require 'impatient-mode)

(use-package! python-black
  :demand t
  :after python
  :hook (python-mode . python-black-on-save-mode-enable-dwim))

;;(setq org-plantuml-jar-path "/d/Programme/plantuml-1.2024.8.jar")
;;(defun my/pretty-symbols ()
;;  (setq prettify-symbols-alist
;;          '(("#+begin_src python" . "🐍")
;;            ("#+begin_src elisp" . "λ")
;;            ("#+begin_src jupyter-python" . "🐍")
;;            ("#+end_src" . "―")
;;            ("#+results:" . "🔨")
;;            ("#+RESULTS:" . "🔨"))))
;;
(eval-after-load 'js-mode
  '(add-hook 'js-mode-hook #'add-node-modules-path))

;;(setenv "NODE_PATH"
;;        (concat
;;         "/d/programme/node_modules"  ":"
;;         (getenv "NODE_PATH")
;;         )
;;        )
;;
(setq ob-mermaid-cli-path "/d/.asdf/shims/mmdc")
;;
;;(setq org-excalidraw-directory "/d/05-doc/org/excalidraw")

;;(add-hook 'org-mode-hook 'my/pretty-symbols)
;;(global-prettify-symbols-mode +1)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (julia .t)
   (python . t)
   (latex. t)
   (ipython . t)
   (jupyter . t)
   (mermaid . t)
   (plantuml . t)
   (dot . t)
   (scheme . t)))

;;(org-babel-jupyter-override-src-block "python")


(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("ctexart" "\\documentclass[11pt]{ctexart}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
;;(setq org-latex-default-class "ctexart")
;;(setq org-latex-compiler "xelatex"))
(setq org-element-use-cache t)

;;(require 'atomic-chrome)
(atomic-chrome-start-server)
;;(add-transient-hook! 'after-focus-change-function (atomic-chrome-start-server))
(setq atomic-chrome-default-major-mode 'markdown-mode)
(setq atomic-chrome-url-major-mode-alist
      '(("github\\.com" . gfm-mode)
        ("stackexchange\\.com" . gfm-mode)
        ("stackoverflow\\.com" . gfm-mode)
        ("reddit\\.com" . gfm-mode)
        ("twitter\\.com" . gfm-mode)
        ("youtube\\.com" . gfm-mode)
        ("google\\.com" . gfm-mode)
        ("newrizon\\.work" . gfm-mode)))
(setq atomic-chrome-buffer-open-style 'frame)
(setq atomic-chrome-server-ghost-text-port 4001)

(setq emacs-everywhere-major-mode-function #'org-mode)
(setq emacs-everywhere-frame-name-format "emacs-everywhere")

;; httpd
(use-package! simple-httpd
  :ensure t)
(setq httpd-port 8080)


(use-package! company-box
  :hook (company-mode . company-box-mode))

;;;; accept completion from copilot and fallback to company
;;(use-package! copilot
;;  :hook (prog-mode . copilot-mode)
;;  :bind (:map copilot-completion-map
;;              ("<tab>" . 'copilot-accept-completion)
;;              ("TAB" . 'copilot-accept-completion)
;;              ("C-TAB" . 'copilot-accept-completion-by-word)
;;              ("C-<tab>" . 'copilot-accept-completion-by-word)
;;              ("C-n" . 'copilot-next-completion)
;;              ("C-p" . 'copilot-previous-completion))
;;  :config
;;  (add-to-list 'copilot-indentation-alist '(prog-mode 2))
;;  (add-to-list 'copilot-indentation-alist '(org-mode 2))
;;  (add-to-list 'copilot-indentation-alist '(text-mode 2))
;;  (add-to-list 'copilot-indentation-alist '(closure-mode 2))
;;  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2)))
;;
;;(after! (evil copilot)
;;  ;; Define the custom function that either accepts the completion or does the default behavior
;;  (defun my/copilot-tab-or-default ()
;;    (interactive)
;;    (if (and (bound-and-true-p copilot-mode)
;;             ;; Add any other conditions to check for active copilot suggestions if necessary
;;             )
;;        (copilot-accept-completion)
;;      (evil-insert 1))) ; Default action to insert a tab. Adjust as needed.
;;
;;  ;; Bind the custom function to <tab> in Evil's insert state
;;  (evil-define-key 'insert 'global (kbd "<tab>") 'my/copilot-tab-or-default))

(require 'powerline)
(powerline-default-theme)

(require 'multi-term)
(setq multi-term-program "/bin/zsh")

;;(setq lsp-headerline-breadcrumb-mode-hook 'flyspell-mode-off)
(setq lsp-headerline-breadcrumb-enable-diagnostics nil)


(after! org-download
  (setq org-download-method 'directory
        org-download-image-dir (concat (getenv "HOME") "/.org.d/mode/img")
        org-download-image-org-width 300
        org-download-heading-lvl 1))

;; youtube video embedding
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

;;(use-package gpt)
;;(add-to-list 'load-path "/home/n/.emacs.d/.local/straight/repos/gpt.el")
;;(require 'gpt)

;;(setq openai-key (getenv "OPENAI_EMACS_KEY"))
;;(setq gpt-openai-api-key (getenv "OPENAI_EMACS_KEY"))
;;(setq gpt-openai-engine "text-davinci-003")
;;(setq gpt-openai-max-tokens 2000)
;;(setq gpt-openai-temperature 0)

;;(global-set-key (kbd "C-c g") 'gpt)
;;
;;

;;(package! chatgpt
;;  :recipe (:local-repo "/vlt/devel/misc/emacs-openai/chatgpt"))


;;(use-package chatgpt :ensure t)
;;(use-package codegpt :ensure t)
;;
;;(require 'chatgpt)
;;(require 'codegpt)

(require 'epc)

(use-package! chatgpt
  :defer t
  :config
  (unless (boundp 'python-interpreter)
    (defvaralias 'python-interpreter 'python-shell-interpreter))
  (setq chatgpt-repo-path (expand-file-name "straight/repos/ChatGPT.el/" doom-local-dir))
  (set-popup-rule! (regexp-quote "*ChatGPT*")
    :side 'bottom :size .5 :ttl nil :quit t :modeline nil)
  :bind ("C-c q" . chatgpt-query))


(require 'zmq)

;;(use-package org-ai
;;  :ensure t
;;  :commands (org-ai-mode
;;             org-ai-global-mode)
;;  :init
;;  (add-hook 'org-mode-hook #'org-ai-mode) ; enable org-ai in org-mode
;;  (org-ai-global-mode) ; installs global keybindings on C-c M-a
;;  :config
;;  (setq org-ai-default-chat-model "gpt-4") ; if you are on the gpt-4 beta:
;;  (setq org-ai-image-directory "/d/05-doc/org/roam/img/org-ai-images/")
;;  (setq org-ai-sd-endpoint-base "http://localhost:7861/")
;;  (org-ai-install-yasnippets)) ; if you are using yasnippet and want `ai` snippets
;;(use-package jupyter
;;  :commands (jupyter-run-server-repl
;;             jupyter-run-repl
;;             jupyter-server-list-kernels)
;;  :init (eval-after-load 'jupyter-org-extensions ; conflicts with my helm config, I use <f2 #>
;;          '(unbind-key "C-c h" jupyter-org-interaction-mode-map)))
;;
;;(setq org-ai-openai-api-token (getenv "OPENAI_ORG_AI_KEY"))
;;(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;;                         ("melpa" . "http://melpa.milkbox.net/packages/"))))
(push (substitute-in-file-name "path-to-ztree-directory") load-path)
(require 'ztree)
(use-package! magit-lfs
  :ensure t
  :pin melpa
  :after magit
  :config
  (require 'magit-lfs))

(use-package! ai-code
  :config
  ;; The shell PATH inherited by GUI Emacs can put the asdf `codex' shim
  ;; before the standalone CLI.  That shim exits 126 when no Node.js version
  ;; is selected, so bypass PATH lookup for AI Code sessions.
  (setq ai-code-codex-cli-program
        (expand-file-name "~/.local/bin/codex"))
  (ai-code-set-backend 'codex)
  ;; Optional: use a narrower transient menu on smaller frames
  ;; (setq ai-code-menu-layout 'two-columns)
  (global-set-key (kbd "C-c a") #'ai-code-menu))
