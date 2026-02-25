

(dotimes (x 10) (format t "~a~%" x)) ; (let ((count 0)) #'(lambda () 
 ; (setf count (1+ count)))) 
 

(defparameter *fn* 
  (let ((count 0)) #'(lambda () 
    (setf count (1+ count))))) 
(funcall *fn*) 

(let ((count 0)) 
  (list #'(lambda () (incf count)) #'(lambda () (decf count)) #'(lambda 
() count))) 

(defvar *count* 0 "Count of widgets made so far.") ; Examples of DEFVAR and DEFPARAMETER look like this:
 

(defparameter *gap-tolerance* 0.001 "Tolerance to be allowed in widget gaps.") ; Examples of DEFVAR and DEFPARAMETER look like this:
 
(defvar *gl* 10) 

(defun foo () 
  (format t "The value of *gl* before increment ~a.~%" *gl*) 
  (setf *gl* (+ 1 *gl*)) 
  (format t "The value of *gl* after increment ~a.~%" *gl*)) 

(defun bar () (foo) 
  (let ((*gl* 20)) (foo)) (foo)) ; (bar)
 ; (setf x 1) 
 ; (setf y 2) 
 ; (setf x 1 y 2) 
 ; (setf x (setf y (random 10)))
 ; Simple variable: (setf x 10) 
 ; Array: (setf (aref a 0) 10)
 ; Hash table: (setf (gethash 'key hash) 10)
 ; Slot named 'field': (setf (field o) 10)
 

(defvar *array* 
  (make-array 10 :initial-element 0)) 

(incf 
  (aref *array* 
    (random (length *array*)))) 

(setf 
  (aref *array* 
    (random (length *array*))) 
  (1+ 
    (aref *array* 
      (random (length *array*))))) 
;; (let ((tmp a)) (setf a b b tmp) nil) same as (rotatef a b)