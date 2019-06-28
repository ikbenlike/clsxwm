;;;; ..lisp

(in-package #:clsxwm)

(defun main ()
  (let ((connection (sx-connect)))
    (register-handler-table (sx-display connection))))
