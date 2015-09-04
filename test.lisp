;;;; test.lisp -*- Mode: Lisp; coding: utf-8-unix; -*- 

(cl:in-package sugoi-iko-yo-log-fetcher.internal)
;; (in-readtable :sugoi-iko-yo-log-fetcher)

(5am:def-suite sugoi-iko-yo-log-fetcher)
(5am:in-suite sugoi-iko-yo-log-fetcher)


(5am:test compute-date-range
  (5am:is (equal (compute-date-range "2015-08-15" "2015-08-18")
                 '((2015 8 15) (2015 8 16) (2015 8 17) (2015 8 18))))
  (5am:is (equal (compute-date-range "2015-08-18" "2015-08-15")
                 '((2015 8 15) (2015 8 16) (2015 8 17) (2015 8 18))))
  (5am:is (equal (compute-date-range "2015-08-18")
                 '((2015 8 18))))
  (5am:is (equal (length (compute-date-range "2015-01-1" "2016-12-31"))
                 731)))


;;; *EOF*

