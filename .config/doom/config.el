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

;;(set-face-attribute 'default nil
;;                    :family "Sarasa Mono SC Nerd"
;;                    :height 140
;;                    )
;;
;;(setq doom-font (font-spec :family "Source Han Sans" :weight 'medium :size 13.0))

;;(setq doom-font (font-spec :family "JetBrainsMono NFM" :size 14 :weight 'medium)
;;      doom-serif-font doom-font
;;      doom-symbol-font (font-spec :family "MesloLGS Nerd Font")
;;      doom-variable-pitch-font (font-spec :family "Sarasa Term SC Nerd" :size 14 :weight 'extra-bold))

(setq doom-font (font-spec :family "Iosevka NF" :size 14 :weight 'medium)
      doom-serif-font doom-font
      doom-symbol-font (font-spec :family "Iosevka NF")
      doom-variable-pitch-font (font-spec :family "Iosevka NF" :size 14 :weight 'extra-bold))

(setq use-default-font-for-symbolsi nil) 
;;(setq doom-font (font-spec :family "JetBrains Mono" :size 14 :weight 'medium)
;;         doom-variable-pitch-font (font-spec :family "Noto Sans" :size 14))

;;(setq doom-font (font-spec :family "Sarasa Mono SC Nerd Font" :size 14 :weight 'medium))
;;(setq doom-font (font-spec :family "JetBrainsMono NFM" :size 14 :weight 'medium))
;;(setq doom-font (font-spec :family "Sarasa Term SC Nerd" :size 14 :weight 'medium))
;;(setq doom-font (font-spec :family "MesloLGS Nerd Font Mono" :weight 'medium :size 13)
;;      doom-variable-pitch-font (font-spec :family "Sarasa Term SC Nerd" :size 13))

(defun my-cjk-font()
  (dolist (charset '(kana han cjk-misc hangul kanbun symbol bopomofo))
    (set-fontset-font t charset (font-spec :family "LXGW Wenkai Mono")))
  (dolist (charset '((#x2018 . #x2019)      ;; Curly single quotes "‘’"
                     (#x201c . #x201d)))))  ;; Curly double quotes "“”"

;;(add-hook 'after-setting-font-hook #'my-cjk-font)

(add-hook! 'after-setting-font-hook
           #'my-cjk-font
           (set-fontset-font t 'latin (font-spec :family "Iosevka NF"))
           (set-fontset-font t 'symbol (font-spec :family "Iosevka NF"))
           (set-fontset-font t 'mathematical (font-spec :family "Iosevka NF"))
           (set-fontset-font t 'emoji (font-spec :family "Iosevka NF")))

;;(setq doom-font (font-spec :family "Sarasa Fixed SC" :size 12 :weight 'medium)
;;      doom-variable-pitch-font (font-spec :family "Sarasa Gothic SC" :size 12))
;;(setq doom-font (font-spec :family "Iosevka" :weight 'medium :size 13.0))
;;(setq doom-font (font-spec :family "LXGW Wenkai Mono" :size 12 :weight 'medium)
;;      doom-variable-pitch-font (font-spec :family "LXGW Wenkai Gothic" :size 12))
;;(setq doom-font (font-spec :family "Noto Sans Mono CJK SC" :weight 'medium :size 13.0))

;;(defun my-cjk-font()
;;  (dolist (charset '(kana han cjk-misc symbol bopomofo))
;;    (set-fontset-font t charset (font-spec :family "Sarasa Mono SC"))))
;;(set-fontset-font t charset (font-spec :family "Sarasa Term SC Nerd"))
;;(set-fontset-font t charset (font-spec :family "Sarasa Mono SC Nerd"))


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

;;(setq with-editor-emacsclient-executable "/c/Users/xinbinjian.sh/scoop/apps/emacs-kl/current/bin/emacsclient.exe")
;; (concat (getenv "HOME") "/.org.d/agenda/managements.org")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;;(use-package! lemon
;;  :config
;;  (setq lemon-mode 1))
;;(setq display-time-mode t)
;;(use-package all-the-icons
;;  :if (display-graphic-p))

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

;;(add-hook 'magit-status-sections-hook #'magit-insert-status-headers)
;;(add-hook 'magit-status-sections-hook #'magit-insert-ignored-files) ;; enable ignored files in status section
;;(add-hook 'magit-status-headers-hook #'magit-insert-ignored-files) ;; enable ignored files in status section
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

;; (use-package pyim
;;   :ensure nil
;;   :config
;;   ;; 激活 basedict 拼音词库
;;   (use-package pyim-basedict
;;     :ensure nil
;;     :config (pyim-basedict-enable))

;;   ;; 五笔用户使用 wbdict 词库
;;   ;; (use-package pyim-wbdict
;;   ;;   :ensure nil
;;   ;;   :config (pyim-wbdict-gbk-enable))

;;   (setq default-input-method "pyim")
;;   (global-set-key (kbd "C-\\") 'toggle-input-method)

;;   ;; 我使用全拼
;;   (setq pyim-default-scheme 'quanpin)
;;   ;;(setq pyim-default-scheme 'pyim-shuangpin)
;;   ;;(setq pyim-default-scheme 'microsoft-shuangpin)

;;   ;;(setq pyim-cloudim 'baidu)
;;   (setq pyim-cloudim 'google)
;;   ;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
;;   ;; 我自己使用的中英文动态切换规则是：
;;   ;; 1. 光标只有在注释里面时，才可以输入中文。
;;   ;; 2. 光标前是汉字字符时，才能输入中文。
;;   ;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
;;   (setq-default pyim-english-input-switch-functions
;;                 '(pyim-probe-dynamic-english
;;                   pyim-probe-isearch-mode
;;                   pyim-probe-program-mode
;;                   pyim-probe-org-structure-template))

;;   (setq-default pyim-punctuation-half-width-functions
;;                 '(pyim-probe-punctuation-line-beginning
;;                   pyim-probe-punctuation-after-punctuation))

;;  ;; 开启拼音搜索功能
;;   (pyim-isearch-mode 1)

;;   (setq-default pyim-punctuation-translate-p '(auto))

;;   (setq pyim-indicator-list (list  #'pyim-indicator-with-cursor-color #'pyim-indicator-with-modeline))
;;   ;; 使用 pupup-el 来绘制选词框
;;   (setq pyim-page-tooltip 'popup)

;;   ;; 选词框显示5个候选词
;;   (setq pyim-page-length 5)

;;   ;; 让 Emacs 启动时自动加载 pyim 词库
;;   (add-hook 'emacs-startup-hook
;;             #'(lambda () (pyim-restart-1 t)))
;;   :bind
;;   (("M-j" . pyim-convert-code-at-point) ;与 pyim-probe-dynamic-english 配合
;;    ("C-;" . pyim-delete-word-from-personal-buffer)))

;;(require 'pyim)
;;(require 'pyim-basedict)
;;(require 'pyim-cregexp-utils)

;; ;; 如果使用 popup page tooltip, 就需要加载 popup 包。
;;(require 'popup)
;;(setq pyim-page-tooltip 'popup)

                                        ; 如果使用 pyim-dregcache dcache 后端，就需要加载 pyim-dregcache 包。
;;(require 'pyim-dregcache)
;;(setq pyim-dcache-backend 'pyim-dregcache)

;;(pyim-basedict-enable)

;;(setq default-input-method "pyim")
;; (global-set-key (kbd "C-\\") 'toggle-input-method)

;; 显示5个候选词。
;;(setq pyim-page-length 5)

;; 金手指设置，可以将光标处的编码，比如：拼音字符串，转换为中文。
;; (global-set-key (kbd "M-j") 'pyim-convert-string-at-point)

;; ;; 按 "C-<return>" 将光标前的 regexp 转换为可以搜索中文的 regexp.
;; ;;(define-key minibuffer-local-map (kbd "C-<return>") 'pyim-cregexp-convert-at-point)

;; 我使用全拼
;; (pyim-default-scheme 'quanpin)
;;(pyim-default-scheme 'wubi)
;;(pyim-default-scheme 'cangjie)
;;(pyim-default-scheme 'pyim-shuangpin)

;; ;; 我使用云拼音
;; (setq pyim-cloudim 'google)

;; (define-key pyim-mode-map "." 'pyim-page-next-page)
;; (define-key pyim-mode-map "," 'pyim-page-previous-page)

;; (define-key pyim-mode-map ";"
;;   (lambda ()
;;     (interactive)
;;     (pyim-select-word-by-number 2)))

;; ;; pyim 探针设置
;; ;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
;; ;; 我自己使用的中英文动态切换规则是：
;; ;; 1. 光标只有在注释里面时，才可以输入中文。
;; ;; 2. 光标前是汉字字符时，才能输入中文。
;; ;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
;; ;; (setq-default pyim-english-input-switch-functions
;; ;;               '(pyim-probe-dynamic-english
;; ;;                 pyim-probe-isearch-mode
;; ;;                 pyim-probe-program-mode
;; ;;                 pyim-probe-org-structure-template))

;; ;; (setq-default pyim-punctuation-half-width-functions
;; ;;               '(pyim-probe-punctuation-line-beginning
;; ;;                 pyim-probe-punctuation-after-punctuation))

;; ;; 开启代码搜索中文功能（比如拼音，五笔码等）
;; (pyim-isearch-mode 1)

(setq dired-dwim-target t)

(with-eval-after-load 'info
  (info-initialize) ; Consult INFOPATH.
  ;; Always add the default value, regardless of what INFOPATH says.
  (dolist (info-dir (Info-default-dirs))
    (add-to-list 'Info-directory-list info-dir)))

;; WSL autostart Chrome when org exporting to html
(setq org-file-apps '(("\\.x?html?\\'" . browse-url)))
;;(setq browse-url-browser-function 'browse-url-chrome-program)
(setq browse-url-browser-function 'browse-url-generic-program)
;;(setq browse-url-generic-program "/usr/bin/google-chrome")
(setq browse-url-generic-program "/c/Program Files/Google/Chrome/Application/chrome.exe")
;;(setq browse-url-generic-program "/snap/bin/chromium")

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;;(setq org-directory (concat (getenv "HOME") "/.org.d/"))
;;(setq org-directory '(concat (getenv "HOME") "/org"))
(setq org-directory "/d/05-doc/org")

;; set export path
(setq org-publish-project-alist
      '(("org-notes"
         :base-directory "/d/05-doc/org/"
         :publishing-function org-html-publish-to-html
         :publishing-directory "/d/05-doc/org/exports"
         )

        ("org-static"
         :base-extension "png"
         :base-directory "/d/05-doc/org"
         :publishing-function org-publish-attachment
         :publishing-directory "/d/05-doc/org/exports"
         )

        ("org" :components ("org-notes" "org-static"))))


(after! org
  (load-library "ox-reveal")
  (setq org-todo-keywords
        '((sequence "TODO(t)" "STARTED(s!)" "|" "DONE(d!)" "WAITING(w@/!)" "DELEGATED(g@/!)" "CANCELLED(c@)" "DEFERRED(f@)"))))

(setq org-agenda-files (list "/d/05-doc/org/agenda/projects.org"
                             "/d/05-doc/org/agenda/managements.org"
                             "/d/05-doc/org/agenda/research.org"))


(setq org-tag-alist '(("battery" . ?b) ("veos" . ?v) ("simulation" . ?s) ("research" . ?r)))

;; set org-roam directory
(setq org-roam-directory "/d/05-doc/org/roam")
;;(setq org-roam-directory (file-truename "~/org/roam"))


(setq org-element-use-cache nil)

;;(setcar org-emphasis-regexp-components " \t('\"{[:nonascii:]")
;;(setcar org-emphasis-regexp-components " \t('\"{[:alpha:]")
;;(setcar (nthcdr 1 org-emphasis-regexp-components) "- \t.,:!?;'\")}\\[[:nonascii:]")
;;(setcar (nthcdr 1 org-emphasis-regexp-components) "[:alpha:]- \t.,:!?;'\")}\\")
;;(org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)


;;(setq org-preview-html-viewer 'xwidget)
;;(setq org-preview-html-viewer 'eww)
(setq browse-url-browser-function 'eww-browse-url)

;;(setq yas-snippet-dirs '(
;;	         (concat (getenv "HOME") "/.org.d/snippets/doom-suite")
;;                         (concat (getenv "HOME") "/.org.d/snippets/andreacrotti-suite/snippets")
;;                         (concat (getenv "HOME") "/.org.d/snippets/mooerslab-org")
;;                         (concat (getenv "HOME") "/.org.d/snippets/madsdk-latex") ))
(yas-global-mode 1)



;;(setq org-babel-default-header-args:jupyter-typescript '(
;;                                                        (:session . "ts")
;;                                                        (:kernel . "tslab")))

;; this seems to add syntax-highlighting to jupyter-python and jupyter-typescript blocks
;;(after! org-src
;;(dolist (lang '(python typescript jupyter))
;;(cl-pushnew (cons (format "jupyter-%s" lang) lang)
;;               org-src-lang-modes :key #'car))
;; (org-babel-jupyter-override-src-block "python") ;; alias all python to jupyter-python
;; (org-babel-jupyter-override-src-block "typescript") ;; alias all python to jupyter-python
;; )
;; go-translate

;;(setq go-translate-base-url "https://translate.google.cn")
;;(setq go-translate-local-language "zh-CN")
;;(setq go-translate-buffer-follow-p t)       ; focus the result window
;;(setq go-translate-buffer-source-fold-p t)  ; fold the source text in the result window
;;(setq go-translate-buffer-line-wrap-p nil)
;; (setq go-translate-buffer-window-config ..) ; config the result window as your wish
;; (setq go-translate-inputs-function #'go-translate-inputs-current-or-prompt)
;;
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;


;;(setq miktex-path (concat (getenv "HOME") "/AppData/Local/Programs/MiKTeX/bin/x64"))

;;(setenv "PATH" (concat (getenv "HOME") "/AppData/Local/Programs/MiKTeX/bin/x64:"
;;                      (getenv "PATH")))
;;(add-to-list 'exec-path (concat (getenv "HOME") "/AppData/Local/Programs/MiKTeX/bin/x64")

(latex-preview-pane-enable)
;;(setq lsp-tex-server 'digestif)
;; set XeTeX mode in TeX/LaTeX
(add-hook 'LaTeX-mode-hook
          (lambda()
            (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
            (setq TeX-command-default "XeLaTeX")
            (setq TeX-save-query nil)
            (setq TeX-show-compilation t)))

(setq browse-url-browser-function 'browse-url-default-windows-browser)
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

;;(use-package! nov
;;  :mode ("\\.epub\\'" . nov-mode)
;;  :config
;;  (setq nov-save-palce-file (concat doom-cache-dir "nov-places")))
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(setq org-journal-dir "/d/05-doc/org/journal"
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
;;(require 'tomatinho)
;;(global-set-key (kbd "<f12>") 'tomatinho)

;;(setq alert-default-style 'toaster)
;;(setq alert-toaster-command (expand-file-name "/d/Programme/toaster/toast/bin/Release/toast"))
;;(setq alert-toaster-default-icon (expand-file-name "/c/Users/xinbinjian.sh/scoop/apps/emacs-kl/current/share/icons/hicolor/128x128/apps/emacs.png"))
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
(make-directory "/d/05-doc/org/agenda/jira" 'ignore-if-exists)
;;(setq jiralib-url "https://jira.newrizon.work/")

;; This is an Emacs package that creates graphviz directed graphs from
;; the headings of an org file
;;(use-package org-mind-map
;;  :init
;;  (require 'ox-org)
;;  :ensure t
;; Uncomment the below if 'ensure-system-packages` is installed
;;:ensure-system-package (gvgen . graphviz)
;;  :config
;;  (setq org-mind-map-engine "dot")       ; Default. Directed Graph
;; (setq org-mind-map-engine "neato")  ; Undirected Spring Graph
;; (setq org-mind-map-engine "twopi")  ; Radial Layout
;; (setq org-mind-map-engine "fdp")    ; Undirected Spring Force-Directed
;; (setq org-mind-map-engine "sfdp")   ; Multiscale version of fdp for the layout of large graphs
;; (setq org-mind-map-engine "twopi")  ; Radial layouts
;; (setq org-mind-map-engine "circo")  ; Circular Layout
;;  )

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

;;(usepackage! flycheck-markdown-mdl-executable
;;        :after flycheck
;;        :config
;;        (setq flycheck-markdown-mdl-executable "/home/is/.local/bin/mdl"))
;;
;;
;;(setq exec-path (append exec-path '("/dpt/.pyenv/bin")))
;;(use-package pyenv-mode
;;  :ensure t
;;  :init
;;  (add-to-list 'exec-path "/dpt/.pyenv/shims")
;;  (setenv "WORKON_HOME" "/dpt/.pyenv/versions/")
;;  :config
;;  (pyenv-mode))

;;(use-package! flycheck
;;  :ensure t
;;  :diminish ""
;;  :init
;;  (progn
;;    (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))
;;  :config
;;  (global-flycheck-mode 1))

;;
;;
;;
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))
;;(require 'conda) ;; if you want interactive shell support, include:
;;(conda-env-initialize-interactive-shells)
;; if you want eshell support, include:
;;(conda-env-initialize-eshell)
;; if you want auto-activation (see below for details), include:
;;(conda-env-autoactivate-mode t)


;;(custom-set-variables
;; '(conda-anaconda-home "/d/miniconda3/"))

;;(setq conda-env-home-directory (expand-file-name "/d/miniconda3")
;;     conda-env-subdirectory "envs")

;;(require 'company-org-roam)
;;(use-package company-org-roam
;;  :when (featurep! :completion company)
;;  :after org-roam--current-buffer:config
;;  (set-company-ba wvckend! 'org-mode '(company-org-roam company-yasnippet)))
;; to get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'k' (non-evil users must press 'c-c c k').
;; this will open documentation for it, including demos of how they are used.
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;(setq url-proxy-services
;;      '(("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)")
;;        ("http" . "http:\\127.0.0.1:20171")
;;        ("https" . "http:\\127.0.0.1:20171")
;;        ("ftp" . "127.0.0.1:20170")
;;        ("socks" . "127.0.0.1:20171")))

;;(setq url-http-proxy-basic-auth-storage
;;    (list (list "127.0.0.1:20171"
;;                (cons "Input your LDAP UID !"
;;                      (base64-encode-string "LOGIN:PASSWORD")))))

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
(setq custom-tab-width 4)

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

;;(when (eq window-system 'w32)
;;  (setq tramp-default-method "plink")
;;  (when (and (not (string-match putty-directory (getenv "PATH")))
;;             (file-directory-p putty-directory))
;;    (setenv "PATH" (concat putty-directory ";" (getenv "PATH")))
;;    (add-to-list 'exec-path putty-directory)))

;;(use-package! beacon)
;;(after! beacon (beacon-mode 1))

(use-package! focus)

(add-to-list 'load-path "~/.emacs.d/impatient-mode")
(require 'impatient-mode)

(use-package! python-black
  :demand t
  :after python
  :hook (python-mode . python-black-on-save-mode-enable-dwim))

(setq org-plantuml-jar-path "/d/Programme/plantuml-1.2024.8.jar")
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

(setenv "NODE_PATH"
        (concat
         "/d/programme/node_modules"  ":"
         (getenv "NODE_PATH")
         )
        )

(setq ob-mermaid-cli-path "/c/Users/xinbinjian.sh/scoop/apps/nodejs/current/bin/mmdc")

(setq org-excalidraw-directory "/d/05-doc/org/excalidraw")

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

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)
              ("C-n" . 'copilot-next-completion)
              ("C-p" . 'copilot-previous-completion))
  :config
  (add-to-list 'copilot-indentation-alist '(prog-mode 2))
  (add-to-list 'copilot-indentation-alist '(org-mode 2))
  (add-to-list 'copilot-indentation-alist '(text-mode 2))
  (add-to-list 'copilot-indentation-alist '(closure-mode 2))
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2)))

(after! (evil copilot)
  ;; Define the custom function that either accepts the completion or does the default behavior
  (defun my/copilot-tab-or-default ()
    (interactive)
    (if (and (bound-and-true-p copilot-mode)
             ;; Add any other conditions to check for active copilot suggestions if necessary
             )
        (copilot-accept-completion)
      (evil-insert 1))) ; Default action to insert a tab. Adjust as needed.

  ;; Bind the custom function to <tab> in Evil's insert state
  (evil-define-key 'insert 'global (kbd "<tab>") 'my/copilot-tab-or-default))

(require 'powerline)
(powerline-default-theme)

(require 'multi-term)
(setq multi-term-program "/bin/zsh")

;;(setq lsp-headerline-breadcrumb-mode-hook 'flyspell-mode-off)
(setq lsp-headerline-breadcrumb-enable-diagnostics nil)

;; change font to MesloLGS NF
;;(add-hook 'vterm-mode-hook
;;          (lambda ()
;;            (set (make-local-variable 'buffer-face-mode-face) '"MesloLGS NF")
;;            (buffer-face-mode t)))
;; (setq! doom-unicode-font (font-spec :family "MesloLGS NF" :size 11))

                                        ; Add to ~/.doom.d/config.el
;;(setq doom-font (font-spec :family "Input Mono Narrow" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans") ; inherits `doom-font''s :size
;;      doom-unicode-font (font-spec :family "MesloLGS NF" :size 12)
;;      doom-big-font (font-spec :family "Fira Mono" :size 19))


;;(setq doom-font (font-spec :family "Input Mono Narrow" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans") ; inherits `doom-font''s :size
;;      doom-unicode-font (font-spec :family "Input Mono Narrow" :size 12)
;;      doom-big-font (font-spec :family "Fira Mono" :size 19))

;;(setq frame-resize-pixelwise t)
;; Drag-and-drop to `dired`
;; (after! org-download
;;   (setq-default org-download-image-dir "~/.org.d/roam/img"))

;; https://emacs.stackexchange.com/questions/108/how-do-i-drag-and-drop-files-into-emacs
;; (add-hook 'dired-mode-Hook 'org-download-enable)

;; (setq-default org-download-method 'directory
;;               org-download-image-org-width 300
;;               org-download-heading-lvl 1)

(after! org-download
  (setq org-download-method 'directory
        org-download-image-dir "/d/05-doc/org/mode/img"
        org-download-image-org-width 300
        org-download-heading-lvl 1))

;; (setq-default org-download-method 'directory)
;; (setq-default org-download-image-dir (concat (getenv "HOME") "/.org.d/roam/img"))
;; (setq-default org-download-heading-lvl nil)
;; (setq-default org-download-screenshot-method "flameshot gui")
;; (setq-default org-download-timestamp "%Y%m%d_%H%M%S")

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

(setq openai-key (getenv "OPENAI_EMACS_KEY"))
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

(use-package org-ai
  :ensure t
  :commands (org-ai-mode
             org-ai-global-mode)
  :init
  (add-hook 'org-mode-hook #'org-ai-mode) ; enable org-ai in org-mode
  (org-ai-global-mode) ; installs global keybindings on C-c M-a
  :config
  (setq org-ai-default-chat-model "gpt-4") ; if you are on the gpt-4 beta:
  (setq org-ai-image-directory "/d/05-doc/org/roam/img/org-ai-images/")
  (setq org-ai-sd-endpoint-base "http://localhost:7861/")
  (org-ai-install-yasnippets)) ; if you are using yasnippet and want `ai` snippets
;;(use-package jupyter
;;  :commands (jupyter-run-server-repl
;;             jupyter-run-repl
;;             jupyter-server-list-kernels)
;;  :init (eval-after-load 'jupyter-org-extensions ; conflicts with my helm config, I use <f2 #>
;;          '(unbind-key "C-c h" jupyter-org-interaction-mode-map)))
;;
(setq org-ai-openai-api-token (getenv "OPENAI_ORG_AI_KEY"))
