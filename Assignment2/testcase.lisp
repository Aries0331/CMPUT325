;Primitives (P) = 5 points total

;Basic = 2.5 total

;P1: 
(fl-interp '(+ 10 5) nil) ; > '15
;P2: 
(fl-interp '(- 12 8) nil) ; > '4
;P3: 
(fl-interp '(* 5 9) nil) ; > '45
;P4: 
(fl-interp '(> 2 3) nil) ; > 'nil
;P5: 
(fl-interp '(< 1 131) nil) ; > 't
;P6: 
(fl-interp '(= 88 88) nil) ; > 't
;P7: 
(fl-interp '(and nil t) nil) ; > 'nil
;P8: 
(fl-interp '(or t nil) nil) ; > 't
;P9: 
(fl-interp '(not t) nil) ; > 'nil
;P10: 
(fl-interp '(isnumber 354) nil) ; > 't
;P11: 
(fl-interp '(equal (3 4 1) (3 4 1)) nil) ; > 't
;P12: 
(fl-interp '(if nil 2 3) nil) ; > '3
;P13: 
(fl-interp '(null ()) nil) ; > 't
;P14: 
(fl-interp '(atom (3)) nil) ; > 'nil
;P15: 
(fl-interp '(eq x x) nil) ; > 't
;P16: 
(fl-interp '(first (8 5 16)) nil) ; > '8
;P17: 
(fl-interp '(rest (8 5 16)) nil) ; > '(5 16)
;P18: 
(fl-interp '(cons 6 3) nil) ; > '(6 . 3)

;More complex = 2.5 total

;P19: 
(fl-interp '(+ (* 2 2) (* 2 (- (+ 2 (+ 1 (- 7 4))) 2))) nil) ; > '12
;P20: 
(fl-interp '(and (> (+ 3 2) (- 4 2)) (or (< 3 (* 2 2))) (not (= 3 2))) nil) ; > 't
;P21: 
(fl-interp '(or (= 5 (- 4 2)) (and (not (> 2 2)) (< 3 2))) nil) ; > 'nil
;P22: 
(fl-interp '(if (not (null (first (a c e)))) (if (isnumber (first (a c e))) (first (a c e)) (cons (a c e) d)) (rest (a c e))) nil) ; > '((a c e) . d)

;User-defined (U) = 10 points total

;Basic = 4 total

;U1: 
(fl-interp '(greater 3 5) '((greater x y = (if (> x y) x (if (< x y) y nil))))) ; > '5
;U2: 
(fl-interp '(square 4) '((square x = (* x x)))) ; > '16
;U3: 
(fl-interp '(simpleinterest 4 2 5) '((simpleinterest x y z = (* x (* y z))))) ; > '40
;U4: 
(fl-interp '(xor t nil) '((xor x y = (if (equal x y) nil t)))) ; > 't

;More complex = 6 total

;U6: 
(fl-interp '(last (s u p)) '((last x = (if (null (rest x)) (first x) (last (rest x)))))) ; > 'p
;U7: 
(fl-interp '(push (1 2 3) 4) '((push x y = (if (null x) (cons y nil) (cons (first x) (push (rest x) y)))))) ; > '(1 2 3 4)
;U8: 
(fl-interp '(pop (1 2 3)) '((pop x = (if (atom (rest (rest x))) (cons (first x) nil) (cons (first x)(pop (rest x))))))) ; > '(1 2)
;U9: 
(fl-interp '(power 4 2) '((power x y = (if (= y 1) x (power (* x x) (- y 1)))))) ; > '16
;U10: 
(fl-interp '(factorial 4) '((factorial x = (if (= x 1) 1 (* x (factorial (- x 1))))))) ; > '24
;U11: 
(fl-interp '(divide 24 4) '((divide x y = (div x y 0)) (div x y z = (if (> (* y z) x) (- z 1) (div x y (+ z 1)))))) ; > '6



