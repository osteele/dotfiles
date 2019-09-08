(defun auto-detect-wrap ())

(setq xemacsp nil)
(setq toggle-debug-on-error t)
(load-file "~/dotfiles/emacs/init.el")
(load-file "~/dotfiles/emacs/init-mac.el")


;;;
;;; Evaluation
;;;

;;; This was installed by package-install.el.  This provides support
;;; for the package system and interfacing with ELPA, the package
;;; archive.  Move this code earlier if you want to reference packages
;;; in your .emacs.
;(when
;    (load
;     (expand-file-name "~/.emacs.d/elpa/package.el"))
;  (package-initialize))



(load-library "sourcepair")
(setq sourcepair-source-path '("../src")
      sourcepair-header-path '("../include"))
;sourcepair-recurse-ignore

(define-key global-map "\C-xx" 'sourcepair-load)

;(load-file "~/dotfiles/emacs/packages/cedet-1.0/common/cedet.el")
;(global-ede-mode 1)
;(semantic-load-enable-minimum-features)
;(semantic-load-enable-code-helpers)
;(semantic-load-enable-gaudy-code-helpers)

(add-to-list 'load-path "~/dotfiles/emacs/packages/ecb-2.40")
(require 'ecb-autoloads)

(global-set-key (kbd "C-c j") 'flyspell-check-previous-highlighted-word)


;;;
;;; Cleanup
;;;

(setq toggle-debug-on-error nil)
