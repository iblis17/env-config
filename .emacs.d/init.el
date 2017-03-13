(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-archives
   (quote
    (("melpa" . "http://melpa.org/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/"))))
 '(package-selected-packages
   (quote
    (powerline moe-theme ein company company-c-headers company-emoji company-erlang company-go company-math company-shell company-web julia-shell julia-mode))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'company)

(add-to-list 'company-backends 'company-math-symbols-unicode)
(add-to-list 'company-backends 'company-emoji)

(eval-after-load
    'company
    '(progn
      (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
      (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
      (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
      (define-key company-active-map (kbd "<backtab>") 'company-select-previous)))

(setq company-frontends
      '(company-pseudo-tooltip-unless-just-one-frontend
         company-preview-frontend
         company-echo-metadata-frontend))

(setq company-require-match 'never)


(add-hook 'after-init-hook 'global-company-mode)

(add-hook 'julia-mode-hook
          (lambda ()
            (local-set-key (kbd "TAB") 'company-complete-common-or-cycle)
            (local-set-key (kbd "C-c TAB") 'julia-latexsub-or-indent)))

(global-set-key (kbd "TAB") 'company-complete-common)

(defun run-term (&optional arg)
  (interactive "P")
  (let ((default-directory default-directory))
    (when arg
      (when (string-match "^.*/src/$" default-directory)
        (cd "../")
        (when (file-directory-p "build")
          (cd "build"))))
    (start-process "urxvt" nil "urxvtc")))


(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(require 'powerline)
(require 'moe-theme)
(moe-dark)