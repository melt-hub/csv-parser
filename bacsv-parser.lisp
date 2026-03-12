; bacsv-parser.lisp

#!/usr/bin/sbcl --script

(defun print-lines (f)
 (let ((line (read-line f nil)))
   (unless (null line)
     (format t "~a~%" line)
     (print-lines f))))

; field production
(defun prod-field (word)
  (let ((code (char-code (char word 0)))
        (rst (subseq word 1)))
    (if (and (>= code 32) ; Space.
             (<= code 126) ; Tilde.
             (not (= code 44))) ; Comma.
        (prod-field rst)
        t)))
; end field production

; record production
(defun prod-record (word) t)
; end record production

; parse record
(defun parse-record (str)
  (format t "~a~%" str))
; end parse record

; parse records 
(defun parse-records (file)
  (let ((line (read-line file nil)))
    (unless (null line)
      (format t "~a~%" (prod-field line))
      (parse-records file))))
; end parse records 

; parse csv
(defun parse-csv (fname)
  (with-open-file (f fname)
    (parse-records f)))
; end parse csv

; usage
(defun usage ()
  (format t "Usage: parse-csv.lisp FILE~%"))
; end usage

; main
(defun main (args)
  (if (= (length args) 2)
      (parse-csv (cadr args))
      (usage)))
; end main

;; Only works with SBCL.
(main *posix-argv*)

; bacsv-parser.lisp
