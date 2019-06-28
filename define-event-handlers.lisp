(in-package #:clsxwm)

(let ((event-handlers (make-hash-table)))
  (defun add-event-handler (event function)
    (setf (gethash event event-handlers) function))

  (defun get-event-handler (event)
    (gethash event event-handlers)))

(defmacro define-event-handler (event args &body body)
  (let ((keys (gensym)))
    `(add-event-handler
       ,event
       (lambda (&rest ,keys &key ,@args &allow-other-keys)
         (declare (ignore ,keys))
         ,@body))))

(defun register-handler-table (display)
  (flet ((handler (&rest rest &key event-key &allow-other-keys)
           (let ((event-handler (get-event-handler event-key)))
             (when (functionp event-handler)
                 (apply event-handler rest)))))
    (xlib:process-event display :handler #'handler :force-output-p t)))
