(in-package #:clsxwm)

(define-event-handler :map-request (window)
  ;(setf (xlib:window-event-mask window) (xlib:make-event-mask :override-redirect))
  (format t "window! ~a~%" window)
  #|(let* ((display (xlib:window-display window))
         (screen (first (xlib:display-roots display))))
    (setf (xlib:drawable-y window) 0)
    (setf (xlib:drawable-x window) 0)
    (setf (xlib:drawable-width window) (xlib:screen-width screen))
    (setf (xlib:drawable-height window) (xlib:screen-height screen)))|#
  (xlib:map-window window)
  nil)

(define-event-handler :resize-request (window width height)
  (setf (xlib:drawable-width window) width)
  (setf (xlib:drawable-height window) height)
  nil)

;(register-handler-table (get-display))
