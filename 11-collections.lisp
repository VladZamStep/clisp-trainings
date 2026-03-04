(make-array 10 :initial-element nil)  ;; a vector of 10 nils

(make-array 5 :fill-pointer 0) ;; a vector of 5 nils, but the fill pointer is at 0, so it is considered empty

(defparameter *x* (make-array 5 :fill-pointer 0))

(vector-push 'a *x*)
(vector-push 'b *x*)
(vector-push 'c *x*)
(vector-pop *x*)
(vector-pop *x*)
(vector-pop *x*)

(make-array 5 :fill-pointer 0 :adjustable t) ;; ==> #()

(make-array 5 :fill-pointer 0 :adjustable t :element-type 'character) ;; the element type is character

(defparameter *y* (vector 1 2 3))

(length *y*) ;; ==> 3
(elt *y* 0) ;; ==> 1
(elt *y* 1) ;; ==> 2
(elt *y* 2) ;; ==> 3
; (elt *y* 3) ;; ==> error

(setf (elt *y* 0) 10) ;; ==> (10 2 3)

(count 1 #(1 2 1 2 3 1 2 3 4))         ;; ==> 3
(remove 1 #(1 2 1 2 3 1 2 3 4))        ;; ==> #(2 2 3 2 3 4)
(remove 1 '(1 2 1 2 3 1 2 3 4))        ;; ==> (2 2 3 2 3 4)
(remove #\a "foobarbaz")               ;; ==> "foobrbz"
(substitute 10 1 #(1 2 1 2 3 1 2 3 4)) ;; ==> #(10 2 10 2 3 10 2 3 4)
(substitute #\x #\b "foobarbaz")       ;; ==> "fooxarxaz"
(find 1 #(1 2 1 2 3 1 2 3 4))          ;; ==> 1
(find 10 #(1 2 1 2 3 1 2 3 4))         ;; ==> NIL
(position 1 #(1 2 1 2 3 1 2 3 4))      ;; ==> 0

(count "foo" '("foo" "bar" "baz" "foo") :test 'string=) ;; ==> 2
(find 'c #((a 10) (b 20) (c 30)) :key 'first) ;; ==> (C 30)

(find 'a #((a 10) (b 20) (a 30) (b 40)) :key #'first)             ;; ==> (A 10)
(find 'a #((a 10) (b 20) (a 30) (b 40)) :key #'first :from-end t) ;; ==> (A 30)

(remove #\a "foobarbaz" :count 1)             ;; ==> "foobrbaz"
(remove #\a "foobarbaz" :count 1 :from-end t) ;; ==> "foobarbaz" (only the last 'a' is removed)

(defparameter *v* #((a 10) (b 20) (c 30)))
(defun verbose-first (x) (format t "Looking at ~s~%" x) (first x))

(count 'a *v* :key #'verbose-first) ;; ==> 1, and prints "Looking at (A 10)", "Looking at (B 20)", "Looking at (C 30)"
(count 'a *v* :key #'verbose-first :from-end t) ;; ==> 1, and prints "Looking at (C 30)", "Looking at (B 20)", "Looking at (A 10)"

(count-if #'evenp #(1 2 3 4 5)) ;; ==> 2

(count-if-not #'evenp #(1 2 3 4 5)) ;; ==> 3

(position-if #'digit-char-p "abcd0001") ;; ==> 4

(remove-if-not #'(lambda (x) (char= (elt x 0) #\f))
  #("foo" "bar" "baz" "foom")) ;; ==> #("foo" "foom")

(count-if #'evenp #((1 a) (2 b) (3 c) (4 d) (5 e)) :key #'first)   ;;  ==> 2
(count-if-not #'evenp #((1 a) (2 b) (3 c) (4 d) (5 e)) :key #'first) ;;==> 3

(remove-if-not #'alpha-char-p #("foo" "bar" "1baz") :key #'(lambda (x) (elt x 0))) ;; ==> #("foo" "bar")

(remove-duplicates '(1 2 3 2 1)) ;; ==> (1 2 3)

(concatenate 'vector #(1 2 3) '(4 5 6))    ;; ==> #(1 2 3 4 5 6)
(concatenate 'list #(1 2 3) '(4 5 6))      ;; ==> (1 2 3 4 5 6)
(concatenate 'string "abc" '(#\d #\e #\f)) ;; ==> "abcdef"

(sort #("foo" "bar" "baz") #'string<) ;; ==> #("bar" "baz" "foo")

; (setf my-sequence (sort my-sequence #'string<)) ;; sorts my-sequence in place

(merge 'vector #(1 2 3) #(4 5 6) #'<) ;; ==> #(1 2 3 4 5 6)
(merge 'list #(1 3 5) #(2 4 6) #'<)   ;; ==> (1 2 3 4 5 6)

(subseq "foobarbaz" 3)  ;; ==> "barbaz"
(subseq "foobarbaz" 3 6) ;; ==> "bar"

(defparameter *xy* (copy-seq "foobarbaz"))
(setf (subseq *xy* 3 6) "xxx")  ; subsequence and new value are same length
;;*xy* ==> "fooxxxbaz"
(setf (subseq *xy* 3 6) "abcd") ; new value too long, extra character ignored.
;;*xy* ==> "fooabcbaz"
(setf (subseq *xy* 3 6) "xx")   ; new value too short, only two characters changed
;;*xy* ==> "fooxxcbaz"

(position #\b "foobarbaz") ; ==> 3
(search "bar" "foobarbaz") ; ==> 3

(mismatch "foobar" "foobaz") ;; ==> 5
(mismatch "foobar" "bar" :from-end t) ; ==> 3

(every #'evenp #(1 2 3 4 5))  ;  ==> NIL
(some #'evenp #(1 2 3 4 5))   ;  ==> T
(notany #'evenp #(1 2 3 4 5))   ; ==> NIL
(notevery #'evenp #(1 2 3 4 5)) ; ==> T

(every #'> #(1 2 3 4) #(5 4 3 2))  ;  ==> NIL
(some #'> #(1 2 3 4) #(5 4 3 2))   ;  ==> T
(notany #'> #(1 2 3 4) #(5 4 3 2))  ; ==> NIL
(notevery #'> #(1 2 3 4) #(5 4 3 2)) ; ==> T

(map 'vector #'* #(1 2 3 4 5) #(10 9 8 7 6)) ; ==> #(10 18 24 28 30)
(map-into a #'+ a b c) ;; adds the corresponding elements of a, b, and c, and stores the result in a

(reduce #'+ #(1 2 3 4 5 6 7 8 9 10)) ; ==> 55

(reduce #'max '(1 2 3 4 5 6 7 8 9 10)) ;; ==> 10

(defparameter *h* (make-hash-table))
(gethash 'a *h*) ;; ==> NIL
(setf (gethash 'a *h*) 'hello) ;; ==> 'hello
(gethash 'a *h*) ;; ==> 'hello

(defun show-value (key hash-table)
  (multiple-value-bind (value present) (gethash key hash-table)
    (if present
      (format nil "Value ~a actually present." value)
      (format nil "Value ~a because key not found." value))))

(setf (gethash 'bar *h*) nil) ; provide an explicit value of NIL

(show-value 'foo *h*) ; ==> "Value QUUX actually present."
(show-value 'bar *h*) ; ==> "Value NIL actually present."
(show-value 'baz *h*) ; ==> "Value NIL because key not found."

(maphash #'(lambda (k v) (format t "~a => ~a~%" k v)) *h*) ; prints "A => HELLO" and "BAR => NIL"

(maphash #'(lambda (k v) (when (< v 10) (remhash k *h*))) *h*)

(loop for k being the hash-keys in *h* using (hash-value v)
  do (format t "~a => ~a~%" k v))