;#1: Group Members - Matthew Newhouse,

;#2: Recaman's Sequence

;#3: Give The Nth Element Of A List

;#4

;#5: Two lists and returns whether or not the first list is shorter than the second
;(define (shorter lis1 lis2) cond)

;#6 Return The Length Of A List
(define l (list 1 2 3 4))

(define (len lis)

     (cond ((null? lis)0)
	(else(+ 1 (len (cdr lis))))))
(len l)




