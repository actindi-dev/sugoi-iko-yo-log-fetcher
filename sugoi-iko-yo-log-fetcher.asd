;;;; sugoi-iko-yo-log-fetcher.asd -*- Mode: Lisp; coding: utf-8-unix; -*- 

(cl:in-package :asdf)


(defsystem :sugoi-iko-yo-log-fetcher
  :serial t
  :depends-on (:fiveam
               :cl-date-time-parser
               :zs3)
  :components ((:file "package")
               (:file "sugoi-iko-yo-log-fetcher")
               (:file "test")))


(defmethod perform ((o test-op) (c (eql (find-system :sugoi-iko-yo-log-fetcher))))
  (load-system :sugoi-iko-yo-log-fetcher)
  (or (flet (($ (pkg sym)
               (intern (symbol-name sym) (find-package pkg))))
        (let ((result (funcall ($ :fiveam :run) ($ :sugoi-iko-yo-log-fetcher.internal :sugoi-iko-yo-log-fetcher))))
          (funcall ($ :fiveam :explain!) result)
          (funcall ($ :fiveam :results-status) result)))
      (error "test-op failed") ))


;;; *EOF*
