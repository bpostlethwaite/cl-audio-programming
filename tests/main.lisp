(defpackage cl-audio-programming/tests/main
  (:use :cl
        :cl-audio-programming
        :rove))
(in-package :cl-audio-programming/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :cl-audio-programming)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
