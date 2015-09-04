;;;; package.lisp -*- Mode: Lisp; coding: utf-8-unix; -*- 

(cl:in-package :cl-user)


(defpackage :sugoi-iko-yo-log-fetcher
  (:use)
  (:export :data-get :data-keys :compute-date-range))


(defpackage :sugoi-iko-yo-log-fetcher.internal
  (:use :sugoi-iko-yo-log-fetcher :cl :zs3 :cl-date-time-parser))

