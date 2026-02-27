; (when (spam-p current-message)
 ; (file-in-spam-folder current-message)
 ; (update-spam-database current-message))
 

(defmacro when 
  (condition &rest body) `(if ,condition (progn ,@body))) 

(defmacro unless 
  (condition &rest body) `(if (not ,condition) (progn ,@body))) 
;; (cond (test-1 form*) . . . (test-N form*)) - conditions
 

(dolist (x '(1 2 3)) 
(print x) 

(if (evenp x) (return))) 

;; Same two examples using DO and DOTIMES:
(dotimes (i 4) (print i))

(do ((i 0 (1+ i)))
    ((>= i 4))
  (print i))

(do ((n 0 (1+ n))
     (cur 0 next)
     (next 1 (+ cur next)))
    ((= 10 n) cur))

;; In this example, there is no variables list.
;; Two exables below are the same, one using DO and the other using LOOP:
(do ()
    ((> (get-universal-time) *some-future-date*))
  (format t "Waiting~%")
  (sleep 60)) 

(loop
  (when (> (get-universal-time) *some-future-date*)
    (return))
  (format t "Waiting~%")
  (sleep 60))

;; An idiomatic DO loop that collects the numbers from 1 to 10 into a list
(do ((nums nil) (i 1 (1+ i)))
  ((> i 10) (nreverse nums))
(push i nums))

(loop for i from 1 to 10 collecting i)

;; The following are some more examples of simple uses of LOOP. This sums the first ten squares:
(loop for x from 1 to 10 summing (expt x 2)) ==> 385

;; This counts the number of vowels in a string:
(loop for x across "the quick brown fox jumps over the lazy dog"
      counting (find x "aeiou")) ==> 11

;; This computes the eleventh Fibonacci number, similar to the DO loop used earlier:
(loop for i below 10
      and a = 0 then b
      and b = 1 then (+ b a)
      finally (return  a))