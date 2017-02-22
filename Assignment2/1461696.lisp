;Name: Jinzhu Li
;Student ID: 1461496
;Course: CMPUT 325 B1
;Assignment 2

#|
The main interpreter function
|#
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
                ; .....


                ; otherwise f is undefined; in this case,
                ; E is returned as if it is quoted in lisp

                (t E)
                )
	      )
           )
        )
  )


#|
the function countArg get the number of parameters in the function
Example: 
(countArg '(f x = (+ x 2))) -> 1
(countArg '(f x y = (+ x y))) -> 2
|#
(defun countArg (L)
	(cond
		((NULL (cdr L)) 0)
		((equal '= (car L)) -1)
		(t (+ 1 (countArg (cdr L))))
	)
)

#|
the function getIndex takes into two arguments, a list and one of the element in the list
return the index of given element in the list
the index is range from 0 to len(list)-1
--Assume the element must be one of the elements in the list L
Example:
(getIndex '(a b c) 'a) -> 0
(getIndex '(a b c) 'b) -> 1
|#
(defun getIndex (L x)
	(cond
		((NULL L) 0)
		((eq (car L) x) 0)
		(t (+ 1 (getIndex (cdr L) x)))
	)
)

#|
the function getElement takes into two arguments, a list and an index
returns an element which is at the position of index+1
since the index is range from 0 to len(L)-1
--Assume the index n is always valid
Example:
(getElement '(a b c) '2) -> c
(getElement '(a b c) '1) -> b
|#
(defun getElement (L n)
	(cond
		((NULL L) 0)
		((eq n 0) (car L))
		(t (getElement (cdr L) (- n 1)))
	)
)

#|
the function bind map the value to the variables respectively
Example:

|#
(defun bind )

#|
the function isUD checks if the function is user defined or not
if it is user defined, return the function body
else, it returns NIL
Example:
(isUD '(add 1 2) '((add x y = (+ x y)))) -> (+ x y)
(isUD '(add 1) '((add x y = (+ x y)))) -> nil
|#
(defun isUD (f UD)
	(cond
		((NULL UD) NIL)
		((and (eq (car f) (caar UD)) (eq (countArg f) (countArg (car UD)))) (car UD))
		(t (isUD f (cdr UD)))
	)
)
















