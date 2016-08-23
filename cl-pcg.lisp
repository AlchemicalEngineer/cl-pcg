;;;  Minimal Common Lisp PCG Random Number Generator
;;;  V0.5

#|
Copyright (c) 2016 The Alchemical Engineer

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
|#

(in-package :pcg)

(defstruct pcg32-random-t
  (state 0 :type (unsigned-byte 64)) 
  (inc 0 :type (unsigned-byte 64)))

(defparameter *pcg-rng* (make-pcg32-random-t))

(defun pcg32-srandom-r (rng init-state init-seq)
  (declare (optimize  (safety 0) (speed 3)))
  (declare (pcg32-random-t rng))
  (declare (type (unsigned-byte 64) init-state))
  (declare (type (unsigned-byte 64) init-seq))
  (setf (pcg32-random-t-state rng) 0
        (pcg32-random-t-inc rng) (logior (ash init-seq 1) 1))
  (pcg32-random-r rng)
  (setf (pcg32-random-t-state rng) (+ (pcg32-random-t-state rng) init-state))
  (pcg32-random-r rng)
  (format t "~%Seeded.~%~%"))

(defun pcg32-random-r (rng)
  (declare (optimize  (safety 0) (speed 3)))
  (declare (pcg32-random-t rng))
  (let ((oldstate (pcg32-random-t-state rng))
        (xorshifted 0)
        (rot 0))
    (declare (type (unsigned-byte 64) oldstate))
    (declare (type (unsigned-byte 32) xorshifted))
    (declare (type (unsigned-byte 32) rot))
    (setf (pcg32-random-t-state rng) (mask-field (byte 64 0) (+  (* oldstate 6364136223846793005) (logior (pcg32-random-t-inc rng) 1))))
    (setf xorshifted (mask-field (byte 32 0) (ash (logxor (ash oldstate -18) oldstate) -27)))
    (setf rot (mask-field (byte 32 0) (ash oldstate -59)))
    (mask-field (byte 32 0) (logior (ash xorshifted (* -1 rot)) (ash xorshifted (logand (* -1 rot) 31))))))


(defun ldexp (x ex)
  (* x (expt 2 ex)))

(defun sum-time ()
  (let ((result nil))
    (multiple-value-bind (s mi h d mo y)
        (get-decoded-time)
      (setf result (list s mi h d mo y)))
    (reduce #'+ result)))

(defun gen-my-rand-seed (&optional (init-state (get-universal-time)) (init-seq (sum-time)))
  (pcg32-srandom-r *pcg-rng* init-state init-seq))

(defun init-pcg-seed ()
  "Generates seed using state based on system time."
  (gen-my-rand-seed))


(defun random-number-pcg ()
  (pcg32-random-r *pcg-rng*))

(defun pcg-rand ()
  (ldexp (* 1.0 (random-number-pcg)) -32))
