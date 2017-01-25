;Name: Jinzhu Li
;Student ID: 1461496
;Course: CMPUT 325 B1
;Assignment 1

#| QUESTION 1
The function xmember takes two elements X and Y. X must be a list, Y can be either a list or an atom.
If Y is a member of X, returns T otherwise returns NIL.
|#

(defun xmember (X Y)
  (cond
    ((NULL X) NIL)
    ((equal (car X) Y) T)
    (t (xmember (cdr X) Y))
  )
)


;QUESTION 2

(defun flatten (X)
  (cond
    ((NULL X) NIL)
    ((atom (car X)) (append (list (car X)) (flatten (cdr X))))
    (t (append (flatten (car X)) (flatten (cdr X))))
  )
)


;QUESTION 3

(defun mix (L2 L1)
  (cond
    ((NULL L1) L2)
    ((NULL L2) L1)
    (t (append (list (car L1) (car L2)) (mix (cdr L2) (cdr L1))))
  )
)

#| another thought

(defun mix1 (L2 L1)
  (if (or (NULL L1) (NULL L2)
    (append L1 L2))
    (append (list(car L1)) (mix (cdr L1) L2))
  )
)

|#

;QUESTION 4

(defun split (L)
  (cond
    ((atom (cdr L)) (list L))
    ((NULL L) (list NIL NIL))
    (t (list (append (list (car L) (car (split (cddr L)))))
       (append (append (list (cadr L)) (cdr (split (cddr L)))))))
  )
)



;QUESTION 5

;QUESTION 6
