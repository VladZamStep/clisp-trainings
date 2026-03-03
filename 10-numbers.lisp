(+ (* (floor    (/ x y)) y) (mod x y)) === x
(+ (* (truncate (/ x y)) y) (rem x y)) === x

;; Increment and decrement operations:
(incf x)    === (setf x (1+ x)) === (setf x (+ x 1))
(decf x)    === (setf x (1- x)) === (setf x (- x 1))
(incf x 10) === (setf x (+ x 10))
(decf x 10) === (setf x (- x 10))

(/= 1 1)        ==> NIL
(/= 1 2)        ==> T
(/= 1 2 3)      ==> T
(/= 1 2 3 1)    ==> NIL
(/= 1 2 3 1.0)  ==> NIL

;; Each argument in compared to the argument to its right:
(< 2 3)       ==> T
(> 2 3)       ==> NIL
(> 3 2)       ==> T
(< 2 3 4)     ==> T
(< 2 3 3)     ==> NIL
(<= 2 3 3)    ==> T
(<= 2 3 3 4)  ==> T
(<= 2 3 4 3)  ==> NIL


; Numeric Analog	Case-Sensitive	Case-Insensitive
; =	CHAR=	CHAR-EQUAL
; /=	CHAR/=	CHAR-NOT-EQUAL
; <	CHAR<	CHAR-LESSP
; >	CHAR>	CHAR-GREATERP
; <=	CHAR<=	CHAR-NOT-GREATERP
; >=	CHAR>=	CHAR-NOT-LESSP

; Numeric Analog	Case-Sensitive	Case-Insensitive
; =	STRING=	STRING-EQUAL
; /=	STRING/=	STRING-NOT-EQUAL
; <	STRING<	STRING-LESSP
; >	STRING>	STRING-GREATERP
; <=	STRING<=	STRING-NOT-GREATERP
; >=	STRING>=	STRING-NOT-LESSP

(string= "foobarqwerty" "abarqwerty1" :start1 2 :start2 1 :end1 10 :end2 9) ==> T
(string/= "lisp" "lissome") ==> 3
(string< "lisp" "lisper") ==> 4
(string< "foobar" "abaz" :start1 3 :start2 1) ==> 5   ; N.B. not 2