(defsystem "cl-audio-programming"
  :version "0.1.0"
  :author "Ben Postlethwaite"
  :license ""
  :depends-on (:cl-collider :cl-fad)
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "cl-audio-programming/tests"))))

(defsystem "cl-audio-programming/tests"
  :author ""
  :license ""
  :depends-on ("cl-audio-programming"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for cl-audio-programming"
  :perform (test-op (op c) (symbol-call :rove :run c)))
