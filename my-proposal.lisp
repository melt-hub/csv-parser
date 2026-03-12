; my-proposal.lisp

; reading test
(defun reading-test (csv-file)
  (let ((line (read-line csv-file nil)))
    (unless (null line)
      (format t "reading: ~a~%" line)
      (reading-test csv-file))))
; end reading test

; ===============| HEADER PARSING |===============

; header profuction 
(defun header (line)
  (let ((line (read-line csv-file nil)))
    (unless (null line)
      (names line))))
; end header production

; names production
(defun names (line cursor)
  (let ((name-pos (name line cursor)))
    (when name-pos 
      (or 
        (let ((comma-pos (comma line name-pos)))
          (names line comma-pos))
        (clrf line name-pos)))))
; end names production

; name production
(defun name (line cursor)
  (if (or (field line cursor) 
          (enclosed-field line cursor))
    t
    nil))
; end name production

; comma production
(defun comma (line cursor) t)
; end comma production

; clrf production
(defun clrf (line cursor) t)
; end clrf production

; ===============| END HEADER PARSING |===============

; records production
(defun records (csv-file) t)
; end recors production

; file production
(defun file (csv-file)
  (if (and (header csv-file) (records csv-file))
    t
    nil))
; end file production

; usage
(defun usage () (format t "ERR: Usage: bacsv-parser.lisp FILE~%"))
; end usage

; main
(defun main (args)
  (cond
      ((= (length args) 2)
       (with-open-file (f (second args))
       (file f)))
    (t (usage))))
; end main

(main sb-ext:*posix-argv*)


; end my-proposal.lisp
