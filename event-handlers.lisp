(in-package #:clsxwm)

(defvar *event-handlers* (make-hash-table :test #'equal))

(defmacro define-event-handler (event args &body body)
  `(setf *event-handlers*
         (lambda args
           ,@body)))