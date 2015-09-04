;;;; sugoi-iko-yo-log-fetcher.lisp -*- Mode: Lisp; coding: utf-8-unix; -*- 


(cl:in-package :sugoi-iko-yo-log-fetcher.internal)


(in-package :sugoi-iko-yo-log-fetcher.internal)


(defvar *credential-file* (merge-pathnames (user-homedir-pathname)
                                           ".ai_s3log"))

(progn
  ;; KLUGE
  (setf *credentials* (file-credentials *credential-file*))
  (with-open-file (in *credential-file*)
    (with-slots (access-key secret-key) 
                *credentials*
      (setf access-key (read-line in)
            secret-key (read-line in)))))


(defun compute-date-range (start &optional end)
  (let* ((start (cl-date-time-parser:parse-date-time start))
         (end (if end
                  (cl-date-time-parser:parse-date-time end)
                  start)))
    (destructuring-bind (start end)
                        (sort (list start end) #'<)
      (loop :for d :from start :to end :by #.(* 60 60 24)
            :collect (multiple-value-bind (s- m- h- d m y)
                                          (decode-universal-time d)
                       (declare (ignore s- m- h-))
                       (list y m d))))))


(defun data-keys (range)
  (let* ((ans (list nil))
         (tem ans))
    (dolist (date range (cdr ans))
      (destructuring-bind (y m d)
                          date
        (setf (cdr tem)
              (setq tem
                    (list (all-keys "iko-yo.net"
                                    :prefix (format nil
                                                    "logs/app/~D/~2,'0D/~2,'0D_"
                                                    y
                                                    m
                                                    d)))))))))


(defun data-get (keys)
  (let ((files '()))
    (dolist (k keys)
      (map nil
	   (lambda (x)
	     (block nil
	       (when (probe-file (name x))
		 (format T "~&skip exist file: ~A~%" (name x))
		 (return))
	       (format T "~&get: ~A... ~A~%" x (name x))
	       (ensure-directories-exist
		(make-pathname :directory (pathname-directory (name x))))
	       (get-file "iko-yo.net" x (name x)))
	     (push (name x) files))
	   k))
    (format T "~2&zgrep \"REGEX\" ~{~S ~^~}~2%" (nreverse files))))


;;; *EOF*
