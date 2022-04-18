;#1: Group Members - Matthew Newhouse, Liam Mazure

;#2: Skip

;#3: Give The Nth Element Of A List

(define l1 (list 1 2 3 4))
(define l2 (list 1 2 3))
(define l3 (list 1 2))
(define l4 (list 1))
(define l5 (list))

(define (findNitem lis n)
  (cond
    ((null? lis) #f)
    ((eq? n 0) (car lis))
    (else (findNitem (cdr lis) (- n 1)))
  )
)
(display "\nTesting 3\n")
(display (findNitem l1 0))
(display (findNitem l1 1))
(display (findNitem l1 2))
(display (findNitem l5 0))
(display "\n")

;#4: Gives the nth digit of a multi-digit number.

(define (countdigits num)
  	(cond 
	  ((< num 10) 1)
	  (else (+ (countdigits (/ num 10)) 1))
	)
)

(define (digitN num n)
  	(remainder (quotient num (expt 10 (- (countdigits num) n))) 10)
)



(display "\nTesting 4\n")
(display (digitN 123456789 1))
(display (digitN 123456789 2))
(display (digitN 123456789 3))
(display (digitN 123456789 4))
(display (digitN 123456789 5))
(display (digitN 123456789 6))
(display (digitN 123456789 7))
(display (digitN 123456789 8))
(display (digitN 123456789 9))
(display "\n")

;#5: Two lists and returns whether or not the first list is shorter than the second

(define (shorter lis1 lis2)
	(< (length lis1) (length lis2))
)

(display "\nTesting 5\n")
(display (shorter l1 l2))
(display (shorter l2 l1))
(display (shorter l5 l1))
(display (shorter l1 l5))
(display "\n")

;#6 Return The Length Of A List

(define (len lis )	
     (cond 
      ((null? lis) #f)
      (else (findLen lis))
     )
)

(define (findLen lis)
  	(cond 
	((null? lis) 0)
	(else (+ 1 (findLen (cdr lis))))
	)
)

(display "\nTesting 6\n")

(display (len l1))
(display (len l2))
(display (len l3))
(display (len l4))
(display (len l5))
(display "\n")
