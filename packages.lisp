(in-package :cl-user)

(defpackage :pcg
  (:use :common-lisp)
  (:export :pcg-rand :init-pcg-seed :gen-my-rand-seed :random-number-pcg))
