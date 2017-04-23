% cubesum
(defun cubesum (L)
	(cond
		((null L) 0)
		(T (+ (* (car L) (car L) (car L)) (cubesum (cdr L))))
	)
)


% iscube
(defun subiscube (num N)
	(if (> num 0)
		(if (> N num)
			NIL
			(if (= num (* N N N))
				T
				(subiscube num (+ N 1))
			)
		)
		(if (< N num)
			NIL
			(if (= num (* N N N))
				T
				(subiscube num (- N 1))
			)
		)
	)
)
(defun iscube (num)
	(if (atom num)
		(if (= num 0)
			T
			(subiscube num 0)
		)
		NIL
	)
)
 

% nocubes
(defun nocubes (L)
	(cond 
		((NULL L) NIL)
		((atom (car L)) 
			(if (iscube (car L))
				(nocubes (cdr L))
				(append (cons (car L) NIL) (nocubes (cdr L)))
			)
		)
	)
)


% addtriple
(defun addtriple (L)
	(cond
		((NULL L) 0)
		(T (+ (car L) (addtriple (cdr L))))
	)
)


% addlist
(defun addlist (L)
	(cond
		((NULL L) NIL)
		(t (cons (addtriple (car L)) (addlist (cdr L))))
	)
)


% rtriple
(defun f (x y z) (+ x y z))
(defun g (x y z) (* x z))
(defun rtriple (f L)
	(cond
		((eq f 'f) (+ (car L) (cadr L) (caddr L)))
		((eq f 'g) (* (car L) (caddr L)))
	)
)


% rlist
(defun rlist (f L)
	(cond 
		((NULL L) NIL)
		(t (cons (rtriple f (car L)) (rlist f (cdr L))))
	)
)


% nest
(defun nest (N L)
	(cond
		((eq N 0) L)
		(t (cons (nest (- N 1) L) NIL))
	)
)


% inc5
(defun add (n)
	(+ 5 n)
)
(defun inc5 (L)
	(mapcar 'add L)
)