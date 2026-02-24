

(defun a (x) 
  (if (eql x 3) 
    (format t "The value of x is: ~a" x) 
    (format t "The value of x is not 3."))) 

(defun print-list (lst) 
  (dolist (item lst) (format t "~a " item))) ; (print-list '(1 2 3 4 5))
 
;;;; Four semicolons are used for a file header comment.
 
;;; A comment with three semicolons will usually be a paragraph
 
;;; comment that applies to a large section of code that follows,
 

(defun verbose-sum (x y) "This function takes two numbers and returns their sum." 
  (format t "Summing ~d and ~d.~%" x y) (+ x y)) 

(print 
  (+ 1 (verbose-sum 5 10))) 
(verbose-sum 5 10) 

(defun foo (a b &optional c d) 
  (+ a b (or c 0) (or d 0))) 

(defun foo1 
  (a b &optional (c 10)) (+ a b c)) 

(defun foo2 
  (a b &optional (c 3 c-supplied-p)) 
  (list a b c c-supplied-p)) 
(print (foo2 1 2 3)) 

(defun foo3 (&key a b c) (list a b c)) 
(foo3 :a 1) 
(foo3 :b 1) 
(foo3 :c 1) 
(foo3 :a 1 :c 3) 
(foo3 :a 1 :b 2 :c 3) 
(foo3 :a 1 :c 3 :b 2) 

(defun foo4 
  (&key (a 0) (b 0 b-supplied-p) (c (+ a b))) 
  (list a b c b-supplied-p)) 
(foo4 :a 1) 
(foo4 :b 1) 
(foo4 :b 1 :c 4) 
(foo4 :a 2 :b 1 :c 4) 

(defun foo5 (n) 
  (dotimes (i 10) 
    (dotimes (j 10) (when (> (+ i j) n)) 
      (return-from foo5 (list i j))))) 

(defun plot (fn min max step) 
  (loop for i from min to max by step do 
    (loop repeat (funcall fn i) do (format t "*")) (format t "~%"))) 
(plot #'exp 0 5 1) 
;; The following are equivalent:
 

(funcall #'(lambda (x) (* x x)) 5) 

((lambda (x) (* x x)) 5) 
;; The following are equivalent:
 

(defun double (x) (* 2 x)) 

(plot #'double 0 10 1) 

(plot #'(lambda (x) (* 2 x)) 0 10 1)