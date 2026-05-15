;; coment-extras.el --- Convenience functions for making code comments -*- lexical-binding: t -*-

;;; Commentary:
;; These may be obsolete and there might be better implementations out there.

;;; Code:
;;;
;;;

;; Original idea from
;; http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html
(defun comment-dwim-line (&optional arg)
  "Replacement for the `comment-dwim' command, passing ARG when commenting.
If no region is selected and current line is not blank and we
are not at the end of the line, then comment current line.
Replaces default behaviour of `comment-dwim', when it inserts
comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p))
        (not (looking-at "[ \t]*$")))
    (comment-or-uncomment-region
      (line-beginning-position)
      (line-end-position))
    (comment-dwim arg)))


(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line.
Line-only if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
      (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)
    (next-line)))

(defun insert-delimeter-line ()
  "Insert a sequence of integers vertically."
  (interactive
    (let* ((delim (string (read-char-exclusive)))
            (start (- (point) (point-at-bol)))
            (stop (cond ((string-match "PHP" mode-name) 76) (t 70)))
            (dstart (+ start (length comment-start)))
            (dstop (- stop (length comment-end)))
            (c dstart))
      (insert comment-start)
      (while (< c dstop)
        (insert delim)
        (setq c (+ c (length delim))))
      (insert comment-end))))

(defun insert-timestamp ()
  "Insert a comment containing the current time."
  (interactive)
  (insert comment-start)
  (insert (format-time-string "%Y-%m-%d %H:%M:%S"))
  (insert comment-end))


(provide 'comment-extras)

;;; comment-extras.el ends here
