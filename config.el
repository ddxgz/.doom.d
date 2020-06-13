;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "Cong Peng"
      user-mail-address "ddxgz19880813@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 14)
      ;; doom-variable-pitch-font (font-spec :family "sans" :size 13)
      )

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-solarized-light)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/Dropbox/Textnotes/")
(setq org-roam-directory "~/Dropbox/Textnotes/org-roam")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;;;;

(define-key evil-insert-state-map (kbd "C-d") 'evil-delete-char)

;; for upcase and downcase
;; to set it to only in text mode
;; (spacemacs/declare-prefix "]" "bracket-prefix")
(global-set-key (kbd "C-x t u") 'upcase-region)
(global-set-key (kbd "C-x t d") 'downcase-region)
(global-set-key (kbd "C-x t c") 'capitalize-region)
(global-set-key (kbd "C-x t U") 'upcase-word)
;; (global-set-key (kbd "C-x t d") 'downcase-word)
;; (global-set-key (kbd "C-x t c") 'capitalize-word)
;;
(map! :leader
      :desc "Comment line" "c l" #'comment-line
      :desc "Copy and comment line" "c y" #'evilnc-copy-and-comment-lines
      )


(map! (:prefix-map ("C-c f" . "File shortcuts")
       :desc "quicknote" "q" (lambda () (interactive)(find-file "~/Dropbox/Textnotes/quicknote.org" ))
       :desc "handbook" "h" (lambda () (interactive)(find-file "~/Dropbox/Textnotes/handbook.org" ))
       :desc "notebook" "n" (lambda () (interactive)(find-file "~/Dropbox/Textnotes/notebook.org" ))
       :desc "unread-papers" "u" (lambda () (interactive)(find-file "~/Dropbox/Textnotes/unread-papers.org" ))
       :desc "research process" "r" (lambda () (interactive)(find-file "~/Dropbox/Textnotes/PhD/research process.org" ))
       :desc "notes-papers" "p" (lambda () (interactive)(find-file "~/Dropbox/Papers/notes-papers.org" ))
       :desc "course notes" "c" (lambda () (interactive)(find-file "~/Dropbox/Textnotes/courses/course notes.org" ))
       :desc "notes-machine-learning" "m" (lambda () (interactive)(find-file "~/Dropbox/Textnotes/Machine Learning/notes-machine-learning.org" ))
       :desc "job-notes" "j" (lambda () (interactive)(find-file "~/Dropbox/Textnotes/Job/job-notes.org" ))
       ))

(map! (:when (featurep! :completion company) ; Conditional loading
        :i "C-@" #'+company/complete
        (:after company
         (:map company-active-map
          "C-l" #'company-complete-selection))
        (:prefix "C-x"                       ; Use a prefix key
          :i "C-l" #'+company/whole-lines)))

;; change what face is used to display bold (or any other) markup by adding a new entry to org-emphasis-alist
;; refer to Font section in Documentation:
;; https://github.com/syl20bnr/spacemacs/blob/master/doc/DOCUMENTATION.org#font
;; Here is a list of common font properties:
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Fonts.html
;; 'slant'
;;   One of 'italic', 'oblique', or 'roman'.
;; 'weight'
;;   One of 'light', 'medium', 'demibold', 'bold' or 'black'.
;; 'style'
;;    Some fonts define special styles which are a combination of slant and weight. For instance, 'Dejavu Sans' defines the 'book' style, which overrides the slant and weight properties.
;; 'width'
;;     One of 'condensed', 'normal', or 'expanded'.
;; 'spacing'
;;      One of 'monospace', 'proportional', 'dual-width', or 'charcell'.
;;
;; colors refer to:
;; https://github.com/syl20bnr/spacemacs/tree/master/layers/%2Bthemes/colors
;; (setq org-emphasis-alist
;;   '(
;;     ("*" (:weight bold :foreground "red"))
;;     ("/" :slant italic :foreground "blue")
;;     ("_" underline)
;;     ("=" (:background "maroon" :foreground "white"))
;;     ("~" (:background "deep sky blue" :foreground "MidnightBlue"))
;;     ("+" (:strike-through t))
;;     ))
(use-package! org
  :defer t
  :config
    (add-to-list 'org-emphasis-alist
                  ;; '("*" (:weight bold :foreground "#d13632")
                  '("*" (:weight bold :foreground "#ECBE7B")
                    ))
    (add-to-list 'org-emphasis-alist
                  '("/" (:slant italic :foreground "#51afef")
                    ))
    (add-to-list 'org-emphasis-alist
                  '("_" (:underline t :foreground "#a9a1e1")
                    ))
    )


(custom-set-faces!
 '(org-roam-link :foreground "salmon")
 '(org-roam-link-current :foreground "salmon"))


(setq org-capture-templates
      '(
        ;; ("a" "Appointment" entry (file  "~/Dropbox/Textnotes/gcal.org" "Appointments")
        ;;  "* TODO %?\n:PROPERTIES:\n\n:END:\nDEADLINE: %^T \n %i\n")
        ;; ("n" "Note" entry (file+headline "~/Dropbox/Textnotes/notes.org" "Captured Notes")
        ("n" "Note" entry (file+headline "~/Dropbox/Textnotes/handbook.org" "Captured Notes")
          "* [Note] %? \n:PROPERTIES:\n:Created: %U\n:END:\n\n\n")
        ;; ("l" "Link" entry (file+headline "~/Dropbox/Textnotes/links.org" "Links")
        ;;  "* %? %^L %^g \n%T" :prepend t)
        ;; ("b" "Blog idea" entry (file+headline "~/Dropbox/Textnotes/i.org" "Blog Topics:")
        ;;  "* %?\n%T" :prepend t)
        ("p" "Paper" entry (file+headline "~/Dropbox/Textnotes/PhD/unread-papers.org" "Papers Captured")
          "* TODO %? \n:PROPERTIES:\nCreated: %T\n:END:\n" :prepend t)
        ;; ("t" "TODO Item" entry (file+headline "~/Dropbox/Orgzly/handbook.org" "Captured TODO Items")
        ("t" "TODO Item" entry (file+headline "~/Dropbox/Textnotes/handbook.org" "Captured TODO Items")
          "* TODO %? \n:PROPERTIES:\n:Created: %T\n:END:\n\n\n")

        ("l" "LinkedInfo TODO Item" entry (file+headline "~/code/linkedinfo/TODOs.org" "Captured TODO Items")
          "*** TODO %? %^g \n:PROPERTIES:\n:Created: %U\n:END:\n\n")

        ("a"               ; key
          "Article"         ; name
          entry             ; type
          (file+headline "~/Dropbox/Textnotes/PhD/articles.org" "Article Captured")  ; target
          "* TODO %? \n:PROPERTIES:\n:Created: %U\n:Linked: %a\n:END:\n%i\n"  ; template
          ;; :prepend t        ; properties
          :empty-lines 1    ; properties
          ;; :created t        ; properties
          )

        ;; ("j" "Journal" entry (file+datetree "~/Dropbox/journal.org")
        ;;  "* %?\nEntered on %U\n  %i\n  %a")
        ;; ("s" "Screencast" entry (file "~/Dropbox/Textnotes/screencastnotes.org")
        ;;  "* %?\n%i\n")
        ))

;; ;; use tabnine
(use-package! company-tabnine
  ;; :ensure t
  :config
  (add-to-list 'company-backends #'company-tabnine)
  (setq company-idle-delay 0)
  (setq company-show-numbers t)
  )


(use-package! deft
    ;; :bind ("C-c n d" . deft)
    ;; :commands (deft)
    :config (setq deft-directory "~/Dropbox/org-roam/"
                  deft-recursive t
                  ;; deft-extensions '("md" "org")
                  ;; deft-use-filter-string-for-filename t
                  ;; deft-use-filename-as-title nil
                  )
    )


;; use org-id for store-link, ref to
;; https://stackoverflow.com/questions/27132422/reference-unique-id-across-emacs-org-mode-files
;; https://github.com/emacs-helm/helm-org/pull/9
;; This allows inserting links based on unique IDs if org-id-link-to-org-use-id is set to t.
(use-package! org-id)
;;TODO do i still need this for doom-emacs?
(setq org-id-link-to-org-use-id t)
;; update id file on startup
;; The .orgids file is in the directory set by `org-directory'
(org-id-update-id-locations '("~/dropbox/textnotes/machine learning/notes-machine-learning.org"
                                  "~/dropbox/textnotes/machine learning/notes-machine-learning-projects.org"
                                  "~/dropbox/org-roam/20200610171705-nlp_topic_modeling.org"
                                  ))

