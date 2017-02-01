;Name: Jinzhu Li
;Student ID: 1461496
;Course: CMPUT 325 B1
;Assignment 1

#| QUESTION 1

The function xmember takes two elements X and Y. X must be a list, Y can be either a list with exactly one atom or an atom.
If Y is a member of X, returns T otherwise returns NIL. If X is an empty list, ie '(), no matter what Y is, the result is always NIL.
Then, if X is not an empty list, we keep comparing Y with each element of X recursively until we find the same element with Y in X.
If we scan the entire list of X and cannot find such element, we will return NIL.

Test cases:
(xmember '(1) 1) -> T
(xmember '((1) 2 3) '(1)) -> T
(xmember '(2 3) NIL) -> NIL

|#

(defun xmember (X Y)
  (cond
    ((NULL X) NIL)
    ((equal (car X) Y) T)
    (t (xmember (cdr X) Y))
  )
)


#| QUESTION 2

The function flatten takes one argument X which is a list may contain some other lists nested in deeper.
Flatten will remove all the brackets '()' inside X and keep all the original atoms in the same order.
From the beginning of X, we check each element, if it is an atom, we keep it. If not, we first flatten it
and then put it back to the position where it is.

Test cases:
(flatten '(((((a)))))) -> (a)
(flatten '((1 2) 3)) -> (1 2 3)
(flatten '(a)) -> (a)

|#

(defun flatten (X)
  (cond
    ((NULL X) NIL)
    ((atom (car X)) (append (list (car X)) (flatten (cdr X))))
    (t (append (flatten (car X)) (flatten (cdr X))))
  )
)


#| QUESTION 3

The function mix takes in two argument L2 and L1. Then the function will mix L1, L2 into one single list
by choosing one element from L1 and one from L2 alternatively. If L1 and L2 are of different lengths,
say n and m respectively, with n > m, then the last n-m elements in L1 will be append to the end of the
final result list. Similarly for the case m > n. Each time, we take the first element from L1 and L2, put
them together into a result list and recursively do the same thing on the rest of L1 and L2 and then append to
the result list.

Test cases:
(mix '(1 2) '(3 4)) -> (3 1 4 2)
(mix NIL '(1 2 3)) -> (1 2 3)
(mix '(a) '(b c)) -> (b a c)

|#

(defun mix (L2 L1)
  (cond
    ((NULL L1) L2)
    ((NULL L2) L1)
    (t (append (list (car L1) (car L2)) (mix (cdr L2) (cdr L1))))
  )
)

#| another thought for Question 3

(defun mix1 (L2 L1)
  (if (or (NULL L1) (NULL L2)
    (append L1 L2))
    (append (list(car L1)) (mix (cdr L1) L2))
  )
)

|#

#| QUESTION 4

The split function takes into a list argument L and then splits the elements in L into two sublist L1 and L2
alternatively, ie put the 1st in L into L1, 2nd into L2, 3rd into L1 and so on. So we take the first element out
from L and put it into a list L1, and then take the second element out and put it into another list L2 and
then append this two list. We keep doing this by adding element into L1 and then L2 alternatively.

Test cases:
(split '(1 2 3)) -> ((1 3) (2))
(split '(a b c d)) -> ((a c) (b d))
(split '()) -> (NIL NIL)

|#

(defun split (L)
  (cond
    ((NULL L) '(NIL NIL))	
    ((NULL (cdr L)) (list L NIL))
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

Ans: The answer is yes. Because according to the split function defined above,
(cadr (split L)) will return a subset of L say L2 which contains the even number(ie the 2nd, 4th, 6th and so on) of elements in L in order.
And (car (split L)) will return a subset of L say L1 which contains the odd number(ie the 1st, 3rd, 5th and so on) of elements in L in order.
Then, when we mix these two list L1 and L2, we pick element from L1 and L2 alternatively according to the
mix function defined above. Therefore, we will get a final list in the right order just the same as
original L.

|#


#| QUESTION 6

The function subsetsum takes into two arguments S and L. S is a positive interger and L is a list containing
several positive integers. The function will return a subset of L whose elements have a sum of S. There are
maybe a lot of these kind of subset but subsetsum will just return one that satisfy. Each element in L will be
exactly used only once. The strategy is, starting from the beginning of the list L, if the first atom is
greater than S, it cannot contained in the result subset and we will check the rest. Then, we will fix one atom
and try to find the subset with sum (S-atom) recursively. If we cannot find such subset, then we will choose
the start from the next atom again, trying to find the subset with sum S from this atom. If finally, till the
last atom in the list we still cannot find a list, we will return NIL indicating there is not subset satisfy
the requirement.

Test case:
(subsetsum 1 '(1)) -> (1)
(subsetsum 1 '(2 1 3)) -> (1)
(subsetsum 4 '(2 3 2)) -> (2 2)
(subsetsum 5 '(1 2)) -> NIL

|#

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
