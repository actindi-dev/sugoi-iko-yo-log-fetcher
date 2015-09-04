(ql:quickload :sugoi-iko-yo-log-fetcher)


(cl:in-package :sugoi-iko-yo-log-fetcher.internal)


(#-:debug progn
 #+:debug let #+:debug ((sb-ext:*posix-argv* '("sbcl" "2015-08-11" "2015-08-22")))

 #+sbcl
 (destructuring-bind (impl start &optional end &rest args)
                     sb-ext:*posix-argv*
   (declare (ignore args))
   (unless (string= impl "sbcl") (error "foo! use SBCL.~%"))
   #+:debug
   (print (data-keys (compute-date-range start end)))
   (data-get (data-keys (compute-date-range start end)))))


(cl-user::quit)
