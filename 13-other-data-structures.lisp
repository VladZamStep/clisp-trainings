(defparameter *set* ())
(adjoin 1 *set*) ;; ==> Nil
(setf *set* (adjoin 1 *set*)) ;; ==> (1)
(pushnew 2 *set*) ;; ==> (2 1)

(subsetp '(3 2 1) '(1 2 3 4)) ;; ==> T, because every element of the first list is in the second list
(subsetp '(1 2 3 4) '(3 2 1)) ;; ==> NIL, because 4 is not in the second list

(assoc 'a '((a . 1) (b . 2) (c . 3))) ;; ==> (A . 1), because the first element of the list is 'a', and the second element is 1
(assoc 'c '((a . 1) (b . 2) (c . 3))) ;; ==> (C . 3), because the first element of the list is 'c', and the second element is 3
(assoc 'd '((a . 1) (b . 2) (c . 3))) ;; ==> NIL, because there is no element in the list whose first element is 'd'

(cdr (assoc 'a '((a . 1) (b . 2) (c . 3)))) ;; ==> 1, because the cdr of (A . 1) is 1

(assoc "a" '(("a" . 1) ("b" . 2) ("c" . 3)) :test #'string=) ;; ==> ("a" . 1), because the first element of the list is "a", and the second element is 1, and the test function is string=, which compares strings for equality
(assoc 'a '((a . 10) (a . 1) (b . 2) (c . 3))) ;; ==> (A . 10), because the first element of the list is 'a', and the second element is 10, and the test function is eq, which compares symbols for equality

(defparameter *alist* '((a . 1) (b . 2) (c . 3)))
;;same
(cons (cons 'new-key 'new-value) *alist*) ;; ==> ((NEW-KEY . NEW-VALUE) (A . 1) (B . 2) (C . 3))
(print (acons 'new-key 'new-value *alist*)) ;; ==> ((NEW-KEY . NEW-VALUE) (A . 1) (B . 2) (C . 3))
(print *alist*) ;; ==> ((A . 1) (B . 2) (C . 3))
(setf *alist* (acons 'new-key 'new-value *alist*)) ;; ==> ((NEW-KEY . NEW-VALUE) (A . 1) (B . 2) (C . 3))
(push (cons 'new-key 'new-value) *alist*) ;; ==> ((NEW-KEY . NEW-VALUE) (A . 1) (B . 2) (C . 3))


(pairlis '(a b c) '(1 2 3)) ;; ==> ((A . 1) (B . 2) (C . 3))

(defparameter *plist* ())
(setf (getf *plist* :a) 1)  ;; ==> 1
(setf (getf *plist* :a) 2)  ;; ==> 2
(print *plist*) ;; ==> (:A 2)
(remf *plist* :a) ;; ==> T, because the property :a is removed from the plist

;; process-properties is a function that takes a plist and a list of keys, 
;;and processes the key-value pairs in the plist that have keys in the list of keys.
;; It uses get-properties to get the next key-value pair from the plist, 
;; and then processes the key-value pair if the key is not nil. 
;; It then sets the plist to the tail of the plist after removing the key-value pair, 
;;so that it can continue processing the next key-value pair.
(defun process-properties (plist keys)
  (loop while plist do  ; loop while plist is not empty
       (multiple-value-bind (key value tail) (get-properties plist keys) ; get the next key-value pair from the plist, and also get the tail of the plist after removing the key-value pair
         (when key (process-property key value)) ; if the key is not nil, then process the key-value pair
         (setf plist (cddr tail))))) ; set the plist to the tail of the plist after removing the key-value pair, so that we can continue processing the next key-value pair


(destructuring-bind (x y z) '(1 2 3)
  (list :x x :y y :z z)) ; (:X 1 :Y 2 :Z 3)

(destructuring-bind (x y z) '(1 '(2 20) 3)
  (list :x x :y y :z z)) ; (:X 1 :Y (2 20) :Z 3)

(destructuring-bind (x (y1 y2) z) '(1 '(2 20) 3)
  (list :x x :y1 y1 :y2 y2 :z z)) ; (:X 1 :Y1 2 :Y2 20 :Z 3)

(destructuring-bind (x (y1 &optional y2) z) (list 1 (list 2 20) 3)
  (list :x x :y1 y1 :y2 y2 :z z)) ; (:X 1 :Y1 2 :Y2 20 :Z 3)

(destructuring-bind (x (y1 &optional y2) z) (list 1 (list 2) 3)
  (list :x x :y1 y1 :y2 y2 :z z)) ; (:X 1 :Y1 2 :Y2 NIL :Z 3)

(destructuring-bind (&key x y z) (list :x 1 :y 2 :z 3)
  (list :x x :y y :z z)) ; (:X 1 :Y 2 :Z 3)

(destructuring-bind (&key x y z) (list :z 1 :y 2 :x 3)
  (list :x x :y y :z z)) ; (:X 3 :Y 2 :Z 1)

(destructuring-bind (&whole whole &key x y z) (list :z 1 :y 2 :x 3)
  (list :x x :y y :z z :whole whole)) ; (:X 3 :Y 2 :Z 1 :WHOLE (:Z 1 :Y 2 :X 3))