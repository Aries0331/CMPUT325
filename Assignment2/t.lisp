;The function "pleng" takes a list 'L' as a parameter, the 'L' is actually a fun function
;It returns the number of the parameters in the fun function in the given 'L'.
;Example: 
;(pleng '(f x = (+ x 1))) => 1
;(pleng '(f a b c = (+ a (+ b c)))) => 3
(defun pleng(L)
  (cond
     ((equal '= (car L)) -1)
     (t  (+ 1 (pleng (cdr L))))
  )
)


;The function "leng" takes a list 'l' as a parameter
;It returns the length of the list 'l'.
;Example: 
;(leng '(a b c)) => 2
;(leng '(a)) => 1
;(leng nil) => 0
(defun leng (l)
    (if (null l)
        0
        (+ 1 (leng (cdr l)))
    )
)         
        

;The function "exist" takes a given function F, the number of parameters param, the list of user-defined functions UD as parameters. 
;It returns whether the F exists in user-defined function if the parameters numbers match.
(defun exist (F param UD)
    (cond 
        ((null UD) nil)
        ;if the length of param is equal to the param number in UD
	    ((and (eq (leng param) (pleng (car UD))) (eq F (caar UD))) (car UD))
        ;find next
	    (t (exist F param (cdr UD)))
    )
)


;The function "indexof" takes a list 'l' and a atom 'a' as parameters
;It returns the index of a in this list.
;The index range is from 0 to the length of list - 1
;Example: 
;(indexof '(a b c) 'c) => 2
;(indexof '(a b c) 'a) => 0
(defun indexof (l a)
  (cond
     ((null l) 0)
     ((eq (car l) a)  0)
     (t (+ 1 (indexof (cdr l) a)))
  )
)


;The function "getindex" takes a list 'l' and a number 'n' as parameters 
;It returns the (n-1)th item in list.
;The index range is from 0 to the length of list - 1
;Example: 
;(getindex '0 '(a b c)) => a
;(getindex '2 '(a b c)) => c
(defun getindex(n l)
    (cond
        ((null l) nil)
        ((eq n 0) (car l))
        (t (getindex (- n 1) (cdr l)))
    )
)


;The function "closure" does the substitution for the closure of a user-defined funciton.
;It takes param as the parameter list, value as the value list, and exp as the expression.
;It returns the expression after substituting all the param with their value
;Example:
;(closure '(a b) '(+ a b) '(5 2)) => (+ 5 2)
(defun closure(param exp value)
    (cond
        ((null exp) exp)
        ((and (atom (car exp)) (> (leng param) (indexof param (car exp))))  
            (cons (getindex (indexof param (car exp)) value) (closure param (cdr exp) value)))
        ((atom (car exp))
            (cons (car exp) (closure param (cdr exp) value)))
        (t (cons (closure param (car exp) value) (closure param (cdr exp) value)))
   )
)



;The function "applyf" takes the arguments and the user-define function. 
;Store the list of arguments and the list of parameters in Q and ex respectively.

(defun applyf (arg P Q ex UP)
    (cond
        ((equal '= (car P))	(fl-interp (closure ex (cadr p) q) UP))
        (t (applyf (cdr arg) (cdr P) (append Q (cons (fl-interp (car arg) UP) nil)) (append ex (cons (car P) nil)) UP))
    )
)


; The interpreter function
(defun fl-interp (E P)
  (cond 
	((atom E) E)   
        (t
            (let ( (f (car E))  (arg (cdr E)) )
                (cond 
                    ; handle built-in functions
                    ((eq f 'null) (null (fl-interp (car arg) P)))
                    ((eq f 'atom) (atom (fl-interp (car arg) P)))
                    ((eq f 'eq) (eq (fl-interp (car arg) P) (fl-interp (cadr arg) P)))
                    ((eq f 'first) (car (fl-interp (car arg) P)))
                    ((eq f 'rest) (cdr (fl-interp (car arg) P)))
                    ((eq f 'cons) (cons (fl-interp (car arg) P) (fl-interp (cadr arg) P)))
                    ((eq f 'equal) (equal (fl-interp (car arg) P) (fl-interp (cadr arg) P)))
                    ((eq f 'number) (numberp (fl-interp (car arg) P)))
                    ((eq f '+) (+ (fl-interp (car arg) P) (fl-interp (cadr arg) P)))
                    ((eq f '-) (- (fl-interp (car arg) P) (fl-interp (cadr arg) P)))
                    ((eq f '*) (* (fl-interp (car arg) P) (fl-interp (cadr arg) P)))
                    ((eq f '>) (> (fl-interp (car arg) P) (fl-interp (cadr arg) P)))
                    ((eq f '<) (< (fl-interp (car arg) P) (fl-interp (cadr arg) P)))
                    ((eq f '=) (= (fl-interp (car arg) P) (fl-interp (cadr arg) P)))
                    ((eq f 'and) (and (fl-interp (car arg) P) (fl-interp (cadr arg) P)))
                    ((eq f 'or) (or (fl-interp (car arg) P) (fl-interp (cadr arg) P)))
                    ((eq f 'not) (not (fl-interp (car arg) P)))
                    ((eq f 'if) (if (fl-interp (car arg) P) 
                                    (fl-interp (cadr arg) P) 
                                    (fl-interp (caddr arg) P)
                                )
                    )

                    ; if f is a user-defined function,
                    ;    then evaluate the arguments 
                    ;         and apply f to the evaluated arguments 
                    ;             (applicative order reduction) 
                    ((exist F arg P) (applyf arg (cdr (exist F arg P)) nil nil P))

                    ; otherwise f is undefined; in this case,
                    ; E is returned as if it is quoted in lisp
                    (t E)
                )
	        )
	    )
    )
)