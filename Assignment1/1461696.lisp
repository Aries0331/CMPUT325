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
    ((null Y) NIL)
    ((equal (car X) Y) T)
    (t (xmember (cdr X) Y))
  )
)



;QUESTION 2

;QUESTION 3

;QUESTION 4

;QUESTION 5

;QUESTION 6
