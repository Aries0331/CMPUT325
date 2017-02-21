;Name: Jinzhu Li
;Student ID: 1461496
;Course: CMPUT 325 B1
;Assignment 2

(defun fl-interp (E P)
  (cond 
	((atom E) E)   ;this includes the case where expr is nil
        (t
           (let ( (f (car E))  (arg (cdr E)) )
	      (cond 
                ; handle built-in functions
                ((eq f 'if)  (if (fl-interp (car arg) P) (fl-interp (cadr arg) P) (fl-interp (caddr arg) P)))
                ((eq f 'null)  (null (fl-interp (car arg) P)))
                ((eq f 'atom)  (atom (fl-interp (car arg) P)))
                ((eq f 'eq)  (eq (fl-interp (car arg) P) (fl-interp (cadr arg) P)))
                ((eq f 'first)  (car (fl-interp (car arg) P)))
                ((eq) f 'rest)  (cdr (fl-interp (car arg) P)) 
	        	((eq f 'cons)  (cons (fl-interp (car arg) P) (fl-interp (cadr arg) P)))
	        	((eq f 'equal)  (equal (fl-interp (car arg) P) (fl-interp (cadr arg) P)))
	        	((eq f 'isnumber)  (isnumber (fl-interp (car arg) P)))
	        	((eq f '+)  (+ (fl-interp (car arg) P) (fl-interp (cadr arg) P)))
	        	((eq f '-)  (- (fl-interp (car arg) P) (fl-interp (cadr arg) P)))
	        	((eq f '*)  (* (fl-interp (car arg) P) (fl-interp (cadr arg) P)))
	        	((eq f '>)  (if (> (fl-interp (car arg) P) (fl-interp (cadr arg) P)) T nil))
	        	((eq f '<)  (if (< (fl-interp (car arg) P) (fl-interp (cadr arg) P)) T nil))
	        	((eq f '=)  (if (= (fl-interp (car arg) P) (fl-interp (cadr arg) P)) T nil))
	        	((eq f 'and)  (if (and (fl-interp (car arg) P) (fl-interp (cadr arg) P)) T nil))
	        	((eq f 'or)  (if (or (fl-interp (car arg) P) (fl-interp (cadr arg) P)) T nil))
	        	((eq f 'not)  (if (not (fl-interp (car arg) P) (cadr (cadr arg) P)) T nil))

	        	; .....
	            ; if f is a user-defined function,
                ;    then evaluate the arguments 
                ;         and apply f to the evaluated arguments 
                ;             (applicative order reduction) 
                

                ; otherwise f is undefined; in this case,
                ; E is returned as if it is quoted in lisp
                ; .....
                (t E)
                )
	      )
           )
        )
  )

