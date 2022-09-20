(setq prelude-theme 'misterioso)
(setq prelude-whitespace nil)
(setq prelude-format-on-save nil)

;;font
(set-face-attribute 'default nil :font "Bm437 ToshibaSat8x14-14")

;;CUA keys
(cua-mode t)

;;79 column ruler
(setq-default display-fill-column-indicator-column 79)
(global-display-fill-column-indicator-mode 1)

(setq-default tab-width 8)
(setq c-default-style "linux"
      c-basic-offset 8)

(defun indent-region-custom(numSpaces)
  (progn
    ;; default to start and end of current line
    (setq regionStart (line-beginning-position))
    (setq regionEnd (line-end-position))
    ;; if there's a selection, use that instead of the current line
    (when (use-region-p)
      (setq regionStart (region-beginning))
      (setq regionEnd (region-end))
      )

    (save-excursion ; restore the position afterwards
      (goto-char regionStart) ; go to the start of region
      (setq start (line-beginning-position)) ; save the start of the line
      (goto-char regionEnd) ; go to the end of region
      (setq end (line-end-position)) ; save the end of the line

      (indent-rigidly start end numSpaces) ; indent between start and end
      (setq deactivate-mark nil) ; restore the selected region
      )
    )
  )

(defun untab-region (N)
  (interactive "p")
  (indent-region-custom -8)
  )

(defun tab-region (N)
  (interactive "p")
  (if (active-minibuffer-window)
      (minibuffer-complete)    ; tab is pressed in minibuffer window -> do completion
    (if (use-region-p)    ; tab is pressed is any other buffer -> execute with space insertion
        (indent-region-custom 8) ; region was selected, call indent-region-custom
      (insert "        ") ; else insert four spaces as expected
      )
    )
  )

(global-set-key (kbd "<backtab>") 'untab-region)
(global-set-key (kbd "<tab>") 'tab-region)
