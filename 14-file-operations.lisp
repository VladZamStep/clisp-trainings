(open "C:/Users/320312634/OneDrive - Philips/Documents/clisp/test.txt")

(let ((in (open "C:/Users/320312634/OneDrive - Philips/Documents/clisp/test.txt" :if-does-not-exist nil)))
  (when in
    (loop for line = (read-line in nil)
         while line do (format t "~a~%" line))
    (close in)))

(defparameter *s* (open "C:/Users/320312634/OneDrive - Philips/Documents/clisp/name.txt"))
(read *s*) ; (1 2 3)
(read *s*) ; 456
(read *s*) ; "a string"
(read *s*) ; ((A B) (C D))
(close *s*) ;T

; (open "C:/Users/320312634/OneDrive - Philips/Documents/clisp/name.txt" :direction :output :if-exists :supersede)

(with-open-file (stream "C:/Users/320312634/OneDrive - Philips/Documents/clisp/test.txt")
  (format t "~a~%" (read-line stream)))
;;To create a new file, you can write something like this:

(with-open-file (stream "C:/Users/320312634/OneDrive - Philips/Documents/clisp/delete_me.txt" :direction :output)
  (format stream "Some text."))

; (pathname-directory (pathname "/foo/bar/baz.txt")) ==> (:ABSOLUTE "foo" "bar")
; (pathname-name (pathname "/foo/bar/baz.txt"))      ==> "baz"
; (pathname-type (pathname "/foo/bar/baz.txt"))      ==> "txt"
(pathname-device (pathname "C:/Users/320312634/OneDrive - Philips/Documents/clisp/test.txt")) ;; ==> "C:"


(pathname "/foo/bar/baz.txt") ; #p"/foo/bar/baz.txt"
(namestring #p"/foo/bar/baz.txt")          ; "/foo/bar/baz.txt"
(directory-namestring #p"/foo/bar/baz.txt") ;"/foo/bar/"
(file-namestring #p"/foo/bar/baz.txt")      ; "baz.txt"

(make-pathname
  :directory '(:absolute "foo" "bar")
  :name "baz"
  :type "txt") ; #p"/foo/bar/baz.txt"

(make-pathname :type "html" :defaults "C:/Users/320312634/OneDrive - Philips/Documents/clisp/test.txt")
(make-pathname :type "html" :version :newest :defaults "C:/Users/320312634/OneDrive - Philips/Documents/clisp/test.txt")
(make-pathname :directory '(:relative "backups") :defaults "/input-file")

(make-pathname :directory '(:relative "backups")
               :defaults #p"/foo/bar/baz.txt") ; #p"backups/baz.txt"

(merge-pathnames #p"foo/bar.html" #p"/www/html/") ; #p"/www/html/foo/bar.html"

(enough-namestring #p"/www/html/foo/bar.html" #p"/www/") ; "html/foo/bar.html"

(merge-pathnames
  (enough-namestring #p"/www/html/foo/bar/baz.html" #p"/www/")
  #p"/www-backups/") ; #p"/www-backups/html/foo/bar/baz.html"

(merge-pathnames #p"foo.txt") ; #p"/home/peter/foo.txt"

(make-pathname :directory '(:absolute "foo") :name "bar") ; file form
(make-pathname :directory '(:absolute "foo" "bar"))       ; directory form

; (with-open-file (in filename :element-type '(unsigned-byte 8))
;   (file-length in))

(let ((s (make-string-input-stream "1.23")))
  (unwind-protect (read s)
    (close s)))

(with-input-from-string (s "1.23")
  (read s))

(with-output-to-string (out)
  (format out "hello, world ")
  (format out "~s" (list 1 2 3))) ; "hello, world (1 2 3)"

(with-open-file (in "C:/Users/320312634/OneDrive - Philips/Documents/clisp/test.txt")
  (loop while (read-char in nil) count t))

;; something more efficient like this:
(with-open-file (in "C:/Users/320312634/OneDrive - Philips/Documents/clisp/test.txt")
  (let ((scratch (make-string 4096)))
    (loop for read = (read-sequence scratch in)
          while (plusp read) sum read)))