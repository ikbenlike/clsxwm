(in-package #:clsxwm)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (let ((key-map (make-hash-table :test #'equalp)))
    (defun define-binding (binding command)
      (check-type binding kbd-bind)
      (check-type command function)
      (setf (gethash binding key-map) command))

    (defun undefine-bindng (binding)
      (check-type binding kbd-bind)
      (setf (gethash binding key-map) nil))

    (defun get-bind-command (binding)
      (check-type binding kbd-bind)
      (gethash binding key-map))))

(defmacro define-keybind (keybind &body body)
  (define-binding
    keybind
    (lambda () ,@body)))

(defun names-from-mod-list (mods)
  (flet ((convert (key)
           (ecase key
             (:control 'control)
             (:lock 'capslock)
             (:shift 'shift)
             (:mod-1 'alt)
             (:mod-2 'numlock)
             (:mod-4 'meta))))
    (map 'list #'convert mods)))

(defun names-from-state (state)
  (names-from-mod-list (xlib:make-state-keys state)))
