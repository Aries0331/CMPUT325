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
    ((NULL (cdr L)) (list L))
    ((NULL L) (list L L))
    (t (list (cons (car L) (cadr (split (cdr L))))
             (car (split (cdr L)))))
  )
)


;QUESTION 5

#|
5.1
Let L1 and L2 be lists. Is it always true that (split (mix L2 L1)) returns the list (L1 L2)?
If yes, give a proof. If no, describe exactly for which pairs of lists L1, L2 the result is different from (L1 L2).

Ans: The answer is no. If one of the L1, L2 is NIL, the result of mix(L2 L1) will be the not NIL one.
Then, if we do split on that list, the result will not just return that list.

For example, L1 = (), L2 = (1 2 3). mix(L2 L1) = (1 2 3), split(mix(L2 L1)) = ((1 3) (2))
However, list(L1 L2) = (NIL (1 2 3))


5.2
Let L be a list. Is it always true that (mix (cadr (split L)) (car (split L))) returns L?
If yes, give a proof. If no, describe exactly for which lists L the result is different from L.

Ans: The answer is yes.

|#


;QUESTION 6

(defun subsetsum (S L)
  (cond
    ((or (NULL L) (< S 1)) NIL)
    ((equal S (car L)) (list(car L)))
    ((< S (car L)) (subsetsum S (cdr L)))
    (t (if (NULL (subsetsum (- S (car L)) (cdr L)))
           (subsetsum S (cdr L))
           (cons (car L) (subsetsum (- S (car L)) (cdr L)))
        )
    )
  )
)
