;;;; ..asd

(asdf:defsystem #:clsxwm
  :description "Describe . here"
  :author "Your Name <your.name@example.com>"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :depends-on (#:clx)
  :components ((:file "package")
               (:file "clsxwm")))
