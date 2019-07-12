;;;; clsxwm.asd

(asdf:defsystem #:clsxwm
  :description "Describe . here"
  :author "Your Name <your.name@example.com>"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :depends-on (#:clx)
  :components ((:file "package")
               (:file "display")
               (:file "define-event-handlers")
               (:file "event-handlers")
               (:file "clsxwm")
               (:file "key-codes")
               (:file "keyboard")
               (:file "kbd-parse")
               (:file "log")))
