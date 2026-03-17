; (directory (make-pathname :name :wild :type :wild :defaults home-dir))

 ;; A helper function to check if a component is present in a pathname
(defun component-present-p (value)
  (and value (not (eql value :unspecific))))

;; This tests whether a pathname represents a directory rather than a file.
(defun directory-pathname-p (pathname)
  (and (not (component-present-p (pathname-name pathname)))
       (not (component-present-p (pathname-type pathname)))
       pathname))

(defun pathname-as-file (name)
  (let ((pathname (pathname name)))
    (when (wild-pathname-p pathname)
      (error "Cannot convert a wildcard pathname to a file pathname."))
    (if (directory-pathname-p pathname)
      (let* ((directory (pathname-directory pathname))
            (name-and-type (pathname (first (last directory)))))
        (make-pathname
          :directory (butlast directory)
          :name (pathname-name name-and-type)
          :type (pathname-type name-and-type)
          :defaults pathname))
      pathname)))

(defun pathname-as-directory (name) ;; Example usage: (pathname-as-directory "/home/user/file.txt") ==> #p"/home/user/file.txt/"
  (let ((pathname (pathname name)))
    (when (wild-pathname-p pathname)
      (error "Cannot convert a wildcard pathname to a directory pathname."))
    (if (not (directory-pathname-p name))
      (make-pathname
        :directory (append (or (pathname-directory pathname) '(:relative))
                           (list (file-namestring pathname)))
        :name nil
        :type nil
        :defaults pathname)
      pathname)))

(defun directory-wildcard (dirname) ;; Example usage: (directory-wildcard "/home/user/") ==> #p"/home/user/*.*"
  (make-pathname 
    :name :wild
    :type #-clisp :wild #+clisp nil ; In SBCL/CCL/Allegro/ECL/etc.: :type :wild In CLISP: :type nil
    :defaults (pathname-as-directory dirname)))

#+clisp
(defun clisp-subdirectories-wildcard (wildcard) ;; Example usage: (clisp-subdirectories-wildcard (directory-wildcard "/home/user/")) ==> #p"/home/user/*/"
  (make-pathname
   :directory (append (pathname-directory wildcard) (list :wild))
   :name nil
   :type nil
   :defaults wildcard))

(defun list-directory (dirname) ;; Example usage: (list-directory "/home/user/") ==> ("file1.txt" "file2.txt" "subdir/")
  (when (wild-pathname-p dirname)
    (error "Cannot list a directory with a wildcard pathname."))
  (let ((wildcard (directory-wildcard dirname)))
  #+(or sbcl cmu lispworks)
    (directory wildcard) ; In SBCL/CMU/LispWorks, we can use the directory function directly with the wildcard pathname
  #+openmcl
    (directory wildcard :directories t) ; In OpenMCL, we need to specify :directories t to include directories in the results
  #+allegro
    (directory wildcard :directories-are-files nil)
  #+clisp
    (nconc
     (directory wildcard)
     (directory (clisp-subdirectories-wildcard wildcard))) ; In CLISP, we need to do two separate directory calls to get files and subdirectories, and then concatenate the results
  #-(or sbcl cmu lispworks openmcl allegro clisp)
    (error "list-directory not implemented")))

(defun file-exists-p (pathname) ;; Example usage: (file-exists-p "/home/user/file.txt") ==> T if the file exists, NIL otherwise
  #+(or sbcl lispworks openmcl)
  (probe-file pathname)
  #+(or allegro cmu)
  (or (probe-file (pathname-as-directory pathname))
      (probe-file pathname))
  #+clisp
  (or (ignore-errors
        (probe-file (pathname-as-file pathname)))
      (ignore-errors
        (let ((directory-form (pathname-as-directory pathname)))
          (when (ext:probe-directory directory-form)
            directory-form))))
  #-(or sbcl cmu lispworks openmcl allegro clisp)
  (error "file-exists-p not implemented"))

(defun walk-directory (dirname fn &key directories (test (constantly t)))
  (labels
    ((walk (name)
      (cond
        ((directory-pathname-p name)
          (when (and directories (funcall test name))
            (funcall fn name))
          (dolist (x (list-directory name)) (walk x)))
          ((funcall test name) (funcall fn name)))))
    (walk (pathname-as-directory dirname))))
    
(walk-directory #P"/Users/320312634/OneDrive - Philips/Documents/clisp"
                #'(lambda (p)
                    (format t "~A~%" p))) ;; This will print the pathnames of all files in the specified directory and its subdirectories.

