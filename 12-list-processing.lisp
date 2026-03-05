(defparameter *cons* (cons 1 2))
*cons*                 ;==> (1 . 2)
(setf (car *cons*) 10) ;==> 10
*cons*                 ;==> (10 . 2)
(setf (cdr *cons*) 20); ==> 20
*cons*                 ;==> (10 . 20)

(cons 1 nil)                   ;==> (1)
(cons 1 (cons 2 nil))          ;==> (1 2)
(cons 1 (cons 2 (cons 3 nil))) ;==> (1 2 3)

(defparameter *list* (list 1 2 3 4))
(first *list*)        ;==> 1
(rest *list*)         ;==> (2 3 4)
(first (rest *list*)) ;==> 2

(list "foo" (list 1 2) 10) ;; ==> ("foo" (1 2) 10)

(setf *list* (reverse *list*)) ; garbage collects the old list, and *list* now points to the reversed list

(defparameter *x* (list 1 2 3))

(nconc *x* (list 4 5 6)) ;==> (1 2 3 4 5 6)

*x* ;==> (1 2 3 4 5 6)

(defun upto (n)
  (let ((result nil))
    (dotimes (i n)
      (push i result))
    (nreverse result)))

(upto 5) ;; ==> (0 1 2 3 4)

(defparameter *list* (list 1 2 3 4 5))
(sort *list* #'>) ;; ==> (5 4 3 2 1)

; (caar list) === (car (car list))
; (cadr list) === (car (cdr list))
; (cadadr list) === (car (cdr (car (cdr list))))

; (caar (list 1 2 3))                  ==> error
(caar (list (list 1 2) 3))          ; ==> 1
(cadr (list (list 1 2) (list 3 4)))  ; ==> (3 4)
(caadr (list (list 1 2) (list 3 4))) ; ==> 3

(mapcar #'(lambda (x) (* 2 x)) '(1 2 3 4)) ; ==> (2 4 6 8)
(mapcar #'+ '(1 2 3) '(4 5 6))              ; ==> (5 7 9)