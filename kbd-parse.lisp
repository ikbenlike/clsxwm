(in-package #:clsxwm)

(defclass kbd-bind ()
  ((keychar
    :initarg :keychar
    :accessor kkeychar)
   (shift
    :initarg :shift
    :accessor kshift
    :initform nil)
   (meta
    :initarg :meta
    :accessor kmeta
    :initform nil)
   (alt
    :initarg :alt
    :accessor kalt
    :initform nil)
   (control
    :initarg :control
    :accessor kcontrol
    :initform nil)))

(defun modkey-p (s)
  (if (and (= (length s) 2)
           (member s
             '("C-" "A-" "M-" "S-" "s-")
             :test #'string=))
    t
    nil))

(defun modkey-to-keyword (modkey)
  (ecase (elt modkey 0)
        (#\C ':control)
        (#\A ':meta)
        (#\M ':meta)
        (#\S ':shift)
        (#\s ':super)))

(defun parse-modkey (s)
  (if (and (<= (2 (length s)))
           (modkey-p (subseq s 0 2)))
      (cons (modkey-to-keyword s) 2)
      nil))

(let ((named-keys (make-hash-table :test #'equal)))

  (setf (gethash "SPC" named-keys) #\space)
  (setf (gethash "RET" named-keys) #\return)
  (setf (gethash "TAB" named-keys) #\tab)
  (setf (gethash "DEL" named-keys) #\del)
  (setf (gethash "ESC" named-keys) #\esc)
  (setf (gethash "BS" named-keys) #\backspace)

  (defun parse-named (s)
    ))

(defun spc-p (s)
  (and (<= 3 (length s))
       (string= s "SPC" :end1 3)))

(defun parse-spc (s)
  (if (spc-p s)
      (cons #\space 3)
      nil))

(defun ret-p (s)
  (and (<= 3 (length s))
       (string= (subseq s 0 3)
                "RET")))

(defun parse-ret (s)
  (if (ret-p s)
      (cons #\return 3)
      nil))

(defun parse-character (s)
  (let ((c (elt s 0)))
    (if (and (or (lower-case-p c)
                 (not (both-case-p c)))
             (not (char= kbd-space c)))
        (cons c 1)
        (or (parse-spc s)
            (parse-ret s)))))

(defun empty-string-p (s)
  (string= s ""))

(defun c->acc (c acc)
  (vector-push-extend c acc)
  acc)

(defun acc->tokens (acc tokens)
  (push (make-array (fill-pointer acc)
                    :element-type 'character
                    :initial-contents acc)
        tokens)
  (setf (fill-pointer acc) 0)
  tokens)

(defun finalize-tokens (acc tokens)
  (if (not (empty-string-p acc))
      (nreverse (acc->tokens acc tokens))
      (nreverse tokens)))

(defun kbd-tokenize (s &aux
                        (l (length s))
                        (acc (make-array 0 :element-type 'character :adjustable t :fill-pointer 0)))
  (labels
      ((rec (acc tokens i)
         (if (< i l)
             (let ((c (char s i)))
               (case c
                 (#\space
                  (if (empty-string-p acc)
                      (rec acc tokens (1+ i))
                      (rec acc (acc->tokens acc tokens) (1+ i))))
                 (#\-
                  (if (empty-string-p acc)
                      (rec (c->acc c acc) tokens (1+ i))
                      (rec acc (acc->tokens (c->acc c acc) tokens) (1+ i))))
                 (otherwise
                  (rec (c->acc c acc) tokens (1+ i)))))
             (finalize-tokens acc tokens))))
    (rec acc '() 0)))

(defun kbd-parse (bind)
  (let ((meta nil) (super nil)
        (shift nil) (control nil))
    ))

(defun kbd (bind)
  (kbd-parse bind))
