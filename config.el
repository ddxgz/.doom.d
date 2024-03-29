;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


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
(setq doom-font (font-spec :family "monospace" :size 16)
      ;; doom-variable-pitch-font (font-spec :family "sans" :size 13)
      )

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-solarized-light)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/Dropbox/Textnotes/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
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

(setq which-key-idle-delay 0.6)
(setq evil-ex-substitute-global nil)

;; (defun add-company-tabnine ()
;;   (add-to-list (make-local-variable 'company-backends) 'company-tabnine))

;; (use-package! company-tabnine
;;   :config
;;   (setq company-idle-delay 0
;;         company-show-numbers t)
;;   (add-hook! (c-mode-local-vars
;;               c++-mode-local-vars
;;               emacs-lisp-mode-local-vars
;;               python-mode-local-vars)
;;     #'add-company-tabnine))

(use-package! company-tabnine
  :after company
  :config
  (cl-pushnew 'company-tabnine (default-value 'company-backends)))

;;;;
;; (map! :map evil-insert-state-map "C-d" nil)
;; (map! :map evil-insert-state-map "C-d" #'evil-delete-char)
(map! :map evil-org-mode-map :i "C-d" #'evil-delete-char)
;; REVIEW when evil-respect-visual-line-mode improved
(map! :map org-mode-map :n "C-c v" #'evil-visual-screen-line)
(map! :map org-mode-map :n "V" #'evil-visual-line)

(map! :map org-mode-map :n "C-c r r" #'helm-org-rifle)
(map! :map org-mode-map :n "C-c r o" #'helm-org-rifle-org-directory)
(map! :map org-mode-map :n "C-c r b" #'helm-org-rifle-current-buffer)

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
(map! :map org-mode-map
      "C-c l" #'org-store-link)

(map! :map org-mode-map
      :localleader
      "t" nil)
(map! :map org-mode-map
      :localleader
      (:prefix ("t" . "toggle")
       "x" #'org-latex-preview
       "e" #'org-toggle-pretty-entities
       ))

(map! :leader
      :desc "Comment line" "c l" #'comment-line
      :desc "Copy and comment line" "c y" #'evilnc-copy-and-comment-lines
      :desc "Kill buffer and close window" "w x" #'kill-buffer-and-window
      :desc "Search buffer (Helm)" "s b" #'swiper-helm
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
       :desc "cards" "c" (lambda () (interactive)(find-file "~/Dropbox/Textnotes/cards.org" ))
       :desc "programming" "g" (lambda () (interactive)(find-file "~/Dropbox/Textnotes/programming/programming.org" ))
       ))

(map! (:when (featurep! :completion helm)
    (:after helm-files :map (helm-find-files-map helm-read-file-map)
            "C-h"      #'helm-find-files-up-one-level
            "C-l"      #'helm-ff-RET
            )))

(map! (:when (featurep! :completion company) ; Conditional loading
        :i "C-@" #'+company/complete
        (:after company
         (:map company-active-map
          "C-l" #'company-complete-selection
          "TAB"     #'company-complete-selection
          [tab]     #'company-complete-selection
          ))
        (:prefix "C-x"                       ; Use a prefix key
          :i "C-l" #'+company/whole-lines)))


(after! spell-fu
  (setq spell-fu-idle-delay 1.5))  ; default is 0.25

;; (sp-local-pair 'org-mode "=" "=")
;; (sp-local-pair 'org-mode "~" "~")
;; (sp-local-pair 'org-mode "/" "/")
;; (sp-local-pair 'org-mode "*" "*")

;; (sp-local-pair 'org-mode "_" "_")
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
;;

(use-package! org
  :defer t
  :config
    (add-to-list 'org-emphasis-alist
                  ;; '("*" (:weight bold :foreground "#d13632")
                  '("*" (:weight bold :foreground "#ECBE7B")
                    ))
    (add-to-list 'org-emphasis-alist
                  ;; '("/" (:slant italic :foreground "#51afef")
                  '("/" (:slant italic :foreground "lightskyblue")
                    ))
    (add-to-list 'org-emphasis-alist
                  ;; '("_" (:underline t :foreground "#a9a1e1")
                  '("_" (:underline t :foreground "lightBlue")
                    ))
    ;;
    ;; If you find that using a different bullet for a sub-list—than that
    ;; used for the current list-level—improves readability, customize the
    ;; variable org-list-demote-modify-bullet.
    (setq org-list-demote-modify-bullet nil)
    )


;; (custom-set-faces!
;;  '(org-roam-link :underline t :weight bold :foreground "salmon")
;;  '(org-roam-link-current :underline t :weight bold :foreground "salmon"))


(after! org
  ;; https://orgmode.org/manual/Structure-Editing.html#Structure-Editing
  (setq org-M-RET-may-split-line t)

  (setq org-list-demote-modify-bullet nil)

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

        ("c" "Card" entry (file "~/Dropbox/Textnotes/cards.org")
          "* %? \n:PROPERTIES:\n:Created: %T\n:CreatedFrom:  %a\n:END:\n:Ref:\n:END:\n")
        ;; ("j" "Journal" entry (file+datetree "~/Dropbox/journal.org")
        ;;  "* %?\nEntered on %U\n  %i\n  %a")
        ;; ("s" "Screencast" entry (file "~/Dropbox/Textnotes/screencastnotes.org")
        ;;  "* %?\n%i\n")
        ))
)

(use-package! ox-latex
  :config
        (setq org-latex-listings 'minted
              org-latex-packages-alist '(("" "minted"))
              ;; org-latex-pdf-process
              ;; '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
              ;;   "bibtex %b"
              ;;   "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
              ;;   "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
              org-latex-pdf-process
              '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                "bibtex %b"
                "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))


      ;; refer to https://github.com/tkf/org-mode/blob/master/lisp/org-latex.el
      (with-eval-after-load 'ox-latex
        (add-to-list 'org-latex-classes
                     '("awesome-cv"
                       "\\documentclass{awesome-cv}
                        [NO-DEFAULT-PACKAGES]
                        [PACKAGES]
                        [EXTRA]"
                       ))
        (add-to-list 'org-latex-classes
                     '("bth-thesis"
                       "\\documentclass{bth-thesis}
                        [NO-DEFAULT-PACKAGES]
                        [PACKAGES]
                        [EXTRA]"
                       ("\\chapter{%s}" . "\\chapter*{%s}")
                       ("\\section{%s}" . "\\section*{%s}")
                       ("\\subsection{%s}" . "\\subsection*{%s}")
                       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                       ("\\paragraph{%s}" . "\\paragraph*{%s}")
                       ;; ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
                       ))
        (add-to-list 'org-latex-classes
                     '("mdpi"
                       "\\documentclass{Definitions/mdpi}
                        [NO-DEFAULT-PACKAGES]
                        [PACKAGES]
                        [EXTRA]"
                       ("\\section{%s}" . "\\section*{%s}")
                       ("\\subsection{%s}" . "\\subsection*{%s}")
                       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                       ("\\paragraph{%s}" . "\\paragraph*{%s}")
                       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
                       ))
        (add-to-list 'org-latex-classes
                     '("sagej"
                       "\\documentclass{sagej}
                        [NO-DEFAULT-PACKAGES]
                        [PACKAGES]
                        [EXTRA]"
                       ("\\section{%s}" . "\\section*{%s}")
                       ("\\subsection{%s}" . "\\subsection*{%s}")
                       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                       ("\\paragraph{%s}" . "\\paragraph*{%s}")
                       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
                       ))
        (add-to-list 'org-latex-classes
                     '("elsarticle"
                       "\\documentclass{elsarticle}
                        [NO-DEFAULT-PACKAGES]
                        [PACKAGES]
                        [EXTRA]"
                       ("\\section{%s}" . "\\section*{%s}")
                       ("\\subsection{%s}" . "\\subsection*{%s}")
                       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                       ("\\paragraph{%s}" . "\\paragraph*{%s}")
                       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
                       ))
        (add-to-list 'org-latex-classes
                     '("IEEEtran"
                       "\\documentclass{IEEEtran}"
                       ("\\section{%s}" . "\\section*{%s}")
                       ("\\subsection{%s}" . "\\subsection*{%s}")
                       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                       ("\\paragraph{%s}" . "\\paragraph*{%s}")
                       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
                       )))

  )


;; remove spell check auto turn on in org-mode, it casues performance issue when the file is big
;; (remove-hook! 'org-mode-hook #'flyspell-mode #'flycheck-mode)

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
    :config (setq deft-directory "~/Dropbox/Textnotes/"
                  deft-recursive t
                  deft-extensions '("md" "org")
                  ;; deft-use-filter-string-for-filename t
                  ;; deft-use-filename-as-title nil
                  )
    )

;; ;; REVIEW when the option added by roam https://github.com/org-roam/org-roam/issues/507
;; (setq org-roam-open-buffer-on-find-file nil)
;; (use-package! org-roam
;;     :custom
;;     (org-roam-directory "~/Dropbox/Textnotes/")
;;     (org-roam-index-file "~/Dropbox/Textnotes/org-roam/index.org")
;;     ;; (org-roam-link-title-format "[[%s]]")
;;     (org-roam-tag-sources '(prop last-directory))
;;     (org-roam-capture-templates '(("d" "default" plain (function org-roam--capture-get-point)
;;                                  "%?"
;;                                  :file-name "org-roam/%<%Y%m%d%H%M%S>-${slug}"
;;                                  :head "#+title: ${title}\n#+roam_alias:\n#+roam_tags:\n"
;;                                  :unnarrowed t)))
;;     (org-roam-ref-capture-templates
;;           '(("r" "ref" plain (function org-roam-capture--get-point)
;;              "%?"
;;              :file-name "webpages/${slug}"
;;              :head "#+ROAM_KEY: ${ref}\n#+TITLE: ${title}\n\n- source :: ${ref}"
;;              :unnarrowed t)))
;;     )


;; use org-id for store-link, ref to
;; https://stackoverflow.com/questions/27132422/reference-unique-id-across-emacs-org-mode-files
;; https://github.com/emacs-helm/helm-org/pull/9
;; This allows inserting links based on unique IDs if org-id-link-to-org-use-id is set to t.
(use-package! org-id)
  ;;TODO do i still need this for doom-emacs? yes!
  (setq org-id-link-to-org-use-id t)
;;
;; ;; update id file on startup
;; The .orgids file is in the directory set by `org-directory'
;; (org-id-update-id-locations '("~/dropbox/textnotes/machine learning/notes-machine-learning.org"
;;                                   "~/dropbox/textnotes/machine learning/notes-machine-learning-projects.org"
;;                                   "~/dropbox/org-roam/20200610171705-nlp_topic_modeling.org"
;;                                   ))

;; have completion when insert link of id:
;; source: https://emacs.stackexchange.com/questions/12391/insert-org-id-link-at-point-via-outline-path-completion
;; (defun org-id-complete-link (&optional arg)
(defun org-id-complete-link ()
  "Create an id: link using completion"
  (concat "id:"
          (org-id-get-with-outline-path-completion)))
(org-link-set-parameters "id"
                         :complete 'org-id-complete-link)


(after! ivy
  (setq ivy-use-virtual-buffers t))

(use-package! org-ref
        ;; bibtex
        :config
        ;; (setq reftex-default-bibliography '("~/Dropbox/bibliography/library.bib"))

          (setq org-ref-default-bibliography '("~/Dropbox/bibliography/library.bib")
                org-ref-pdf-directory "~/Dropbox/bibliography/pdfs/"
                org-ref-bibliography-notes "~/Dropbox/bibliography/biblio-notes.org"
                ;; org-ref-notes-directory "~/Dropbox/Textnotes/papernotes"
                )

          ;; If you use helm-bibtex as the citation key completion method you should set these variables too.

          ;; (setq bibtex-completion-bibliography '("~/Dropbox/bibliography/library.bib")
          (setq bibtex-completion-bibliography org-ref-default-bibliography
                ;;       bibtex-completion-library-path '("~/Dropbox/bibliography/pdfs", "~/Dropbox/Articles")
                ;; bibtex-completion-notes-path "~/Dropbox/bibliography/bibtex-notes.org"
                org-ref-completion-library 'org-ref-ivy-cite
                )

          ;; open pdf with system pdf viewer (works on mac)
          (setq bibtex-completion-pdf-open-function
                (lambda (fpath)
                  (start-process "open" "*open*" "open" fpath)))

          ;; ;org-ref links are designed to export to the corresponding LaTeX
          ;; (setq org-latex-pdf-process
          ;;       '("pdflatex -interaction nonstopmode -output-directory %o %f"
          ;;         "bibtex %b"
          ;;         "pdflatex -interaction nonstopmode -output-directory %o %f"
          ;;         "pdflatex -interaction nonstopmode -output-directory %o %f"))

          ;; (setq reftex-external-file-finders
          ;;       '(("tex" . "~/Dropbox/bibliography -format=.tex %f")
          ;;         ("bib" . "~/Dropbox/bibliography -format=.bib %f")))
       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
)



;; (setq menu-bar-mode nil)
;; (menu-bar-mode -1)
