;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one
 doom-font (font-spec :family "DejaVu Sans Mono for Powerline" :size 22)
 doom-big-font (font-spec :family "DejaVu Sans Mono for Powerline" :size 36)
 )

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(require 'which-key)
(setq which-key-idle-delay 0.2)

(require 'company)
(setq company-idle-delay 0.0
      company-minimum-prefix-length 2)

(setq evil-escape-key-sequence "df"
      evil-escape-unordered-key-sequence t)

(define-key evil-normal-state-map (kbd "M-w") #'avy-goto-word-1)

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(map! :leader
      :desc "Toggle neotree file viewer"
      "t n" #'neotree-toggle)
;; doesn't work when in ctrl+z mode
;; (map! :ne "SPC j c" #'avy-goto-char-2)

(setq
 default-directory "~"
 projectile-project-search-path '("~/code/")
 js-indent-level 2
 web-mode-markup-indent-offset 2
 web-mode-code-indent-offset 2
 web-mode-css-indent-offset 2
 )

;; (add-hook!
;;   js2-mode 'prettier-js-mode)

(map! :leader
      :desc "Copy to register"
      "r c" #'copy-to-register
      :leader
      :desc "Frameset to register"
      "r f" #'frameset-to-register
      :leader
      :desc "Insert contents of register"
      "r i" #'insert-register
      :leader
      :desc "Jump to register"
      "r j" #'jump-to-register
      :leader
      :desc "List registers"
      "r l" #'list-registers
      :leader
      :desc "Number to register"
      "r n" #'number-to-register
      :leader
      :desc "Interactively choose a register"
      "r r" #'counsel-register
      :leader
      :desc "View a register"
      "r v" #'view-register
      :leader
      :desc "Window configuration to register"
      "r w" #'window-configuration-to-register
      :leader
      :desc "Increment register"
      "r +" #'increment-register
      :leader
      :desc "Point to register"
      "r SPC" #'point-to-register)

(map! :leader
      :desc "Dired"
      "d d" #'dired
      :leader
      :desc "Dired jump to current"
      "d j" #'dired-jump)

;; (setq centaur-tabs-height 20)

(map! :leader
      :desc "Toggle tabs on/off"
      "t c" #'centaur-tabs-local-mode)

(map! :leader
      :desc "no highlight"
      "s c" #'evil-ex-nohighlight)

;; (require 'sublimity)
;; (require 'sublimity-scroll)
;; (setq sublimity-scroll-weight 10
;;       sublimity-scroll-drift-length 5)
;; (sublimity-mode 1)

;; vim like scroll-off
;; (setq scroll-step 4)
;; (setq scroll-margin 4)
