(defun sum (L)
	(cond
		((null L) 0)
		((atom L) L)
		(t (+ (sum (car L)) (sum (cdr L))))
	)
)

(defun createPair (L)
	(cond
		((null L) NIL)
		(t (cons (list (car L) (car L)) (createPair (cdr L))))
	)
)

#|
(defun member0 (A L)
	(if (atom (car L))
		(if (eq A (car L)) 
			t
			(member0 A (cdr L))
		)
		(or (member0 A (car L)) (member0 A (cdr L)))
	)
)
|#

(defun member0 (A L)
	(cond 
		((null L) NIL)
		((not (atom L)) (or (member0 A (car L)) (member0 A (cdr L))))
		(t (eq A L))
	) 
)

(defun insert (A L)
	(cond
		((null L) ())
		(t (cons (append (list A) L) (insert A (cdr L))))
	)
)

; A is one element in L, recover function return a list
; including element from the beginning of L to A 
(defun recover (A L)
	(cond
		((eq A (car L)) NIL)
		(t (cons (car L) (recover A (cdr L))))
	)
)