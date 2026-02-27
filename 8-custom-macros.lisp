(defun primep (number)
  (when (> number 1)
    (loop for i from 2 to (isqrt number) never (zerop (mod number i)))))

(defun next-prime (number)
  (loop for n from number when (primep n) return n))

;; Two below are the same
(defmacro do-primes (var-and-range &rest body)
  (let ((var (first var-and-range))
        (start (second var-and-range))
        (end (third var-and-range)))
        `(do ((,var (next-prime ,start) (next-prime (1+ ,var))))
             ((> ,var ,end))
           ,@body)))

(defmacro do-primes ((var start end) &body body)
  (let ((ending-value-name (gensym)))
    `(do ((,var (next-prime ,start) (next-prime (1+ ,var))))
          ((,ending-value-name ,end))
          ((> ,var ,ending-value-name))
        ,@body)))

(defmacro with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))

(defmacro do-primes-v2 ((var start end) &body body)
  (with-gensyms (ending-value-name)
    `(do ((,var (next-prime ,start) (next-prime (1+ ,var))))
          ((,ending-value-name ,end))
          ((> ,var ,ending-value-name))
        ,@body)))

;; To see macro directly, use macroexpand-1:
(print(macroexpand-1 '(do-primes (p 0 19) (format t "~d " p))))

