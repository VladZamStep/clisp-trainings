(defclass bank-account0 ()
  (customer-name
  account-number))

(defparameter *account0* (make-instance 'bank-account0))
(setf (slot-value *account0* 'customer-name) "Alice")
(setf (slot-value *account0* 'account-number) "12345")


(defclass bank-account1 () 
  ((customer-name 
    :initarg :customer-name)
  (account-number 
    :initarg :account-number
    :initform 0
  )))

(defparameter *account* (make-instance 'bank-account1 :customer-name "Bob" :account-number 67890))

(slot-value *account* 'customer-name); ==> "Bob"
(slot-value *account* 'account-number); ==> 67890

(defvar *account-numbers* 0)

(defclass bank-account ()
  ((customer-name
    :initarg :customer-name
    :initform (error "Must supply a customer name.")
    :accessor customer-name
    :documentation "Customer's name")
   (balance
    :initarg :balance
    :initform 0
    :reader balance
    :documentation "Current account balance")
   (account-number
    :initform (incf *account-numbers*)
    :reader account-number
    :documentation "Unique account number")
    account-type
    :reader account-type
    :documentation "Account type (gold, silver, bronze)"))

(defmethod initialize-instance :after ((account bank-account) &key)
  (let ((balance (slot-value account 'balance)))
    (setf (slot-value account 'account-type)
          (cond 
            ((>= balance 100000) :gold)
            ((>= balance 50000) :silver)
            (t :bronze)))))

(defmethod initialize-instance :after ((account bank-account)
                                       &key opening-bonus-percentage)
  (when opening-bonus-percentage
    (incf (slot-value account 'balance)
          (* (slot-value account 'balance) (/ opening-bonus-percentage 100)))))

(defparameter *acct* (make-instance
                                'bank-account
                                 :customer-name "Sally Sue"
                                 :balance 1000
                                 :opening-bonus-percentage 5))
(slot-value *acct* 'balance) ;; ==> 1050

(defmethod access-low-balance-penalty ((account bank-account))
  (when (< (balance account ) *minimum-balance*)
    (decf (slot-value account 'balance) (* (balance account) .01))))

(defmethod assess-low-balance-penalty ((account bank-account))
  (when (< (slot-value account 'balance) *minimum-balance*)
    (decf (slot-value account 'balance) (* (slot-value account 'balance) .01))))

;; WITH-SLOTS
(defmethod assess-low-balance-penalty ((account bank-account))
  (with-slots (balance) account
    (when (< balance *minimum-balance*)
      (decf balance (* balance .01)))))
;; OR
(defmethod assess-low-balance-penalty ((account bank-account))
  (with-slots ((bal balance)) account
    (when (< bal *minimum-balance*)
      (decf bal (* bal .01)))))

;; WITH-ACCESSORS
(defmethod assess-low-balance-penalty ((account bank-account))
  (with-accessors ((balance balance)) account
    (when (< balance *minimum-balance*)
      (decf balance (* balance .01)))))

(defmethod merge-accounts ((account1 bank-account) (account2 bank-account))
  (with-accessors ((balance1 balance)) account1
    (with-accessors ((balance2 balance)) account2
      (incf balance1 balance2)
      (setf balance2 0))))

(defclass money-market-account (checking-account savings-account) ())

(money-market-account
 checking-account
 savings-account
 bank-account
 standard-object
 t)

; (defgeneric balance (account))
; (defmethod get-balance ((account bank-account))
;   (slot-value account 'balance))

; (defgeneric (setf customer-name) (value account))
; (defmethod (setf customer-name) (value (account bank-account))
;   (setf (slot-value account 'customer-name) value))

; (defgeneric customer-name (account))
; (defmethod customer-name ((account bank-account))
;   (slot-value account 'customer-name))

; (setf (customer-name *account*) "Sally Sue") ;==> "Sally Sue"
; (customer-name *account*)                    ;==> "Sally Sue"