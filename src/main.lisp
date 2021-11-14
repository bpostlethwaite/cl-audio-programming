(defpackage cl-audio-programming
  (:use #:cl #:sc)
  (:nicknames #:audio))
(in-package :cl-audio-programming)

(named-readtables:in-readtable :sc)

(defun init ()
  (setf *s* (make-external-server "localhost" :port 48800))
  (server-boot *s*)
  (jack-connect)
  (load-synthdefs)
  (hello))

;; (stop) frees all nodes

(defun quit ()
  (server-quit *s*))


(defun load-synthdefs ()
  (cl-fad:walk-directory
   (merge-pathnames #P"synthdefs" (asdf:system-source-directory :cl-audio-programming))
   (lambda (name) (load name))
   :test (lambda (name)
           (equal "lisp" (pathname-type name)))
   :directories nil))
