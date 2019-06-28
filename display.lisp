(in-package #:clsxwm)

(defclass sx-connection ()
  ((display
    :initarg :display
    :accessor sx-display)
   (screen
    :initarg :screen
    :accessor sx-screen)
   (root
    :initarg :root
    :accessor sx-root)
   (colormap
    :initarg :colormap
    :accessor sx-colormap)))

(defun sx-connect ()
  (let* ((display (xlib:open-default-display))
         (screen (xlib:display-default-screen display))
         (colormap (xlib:screen-default-colormap screen))
         (root (xlib:screen-root screen)))
    (setf (xlib:window-event-mask root) (xlib:make-event-mask
                                          :substructure-notify
                                          :structure-notify
                                          :substructure-redirect
                                          :resize-redirect))
    (make-instance
        'sx-connection
        :display display
        :screen screen
        :root root
        :colormap colormap)))

(defun sx-disconnect (sx-connection)
  (xlib:close-display (sx-display sx-connection)))
