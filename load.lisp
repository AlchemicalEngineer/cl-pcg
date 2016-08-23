
(if (probe-file "cl-pcg.lisp")
    (progn
      (load "packages.lisp")
      (load (compile-file "cl-pcg.lisp")))
  (format t "~%Need to change to directory containing \"cl-pcg.lisp.\"~%~%"))