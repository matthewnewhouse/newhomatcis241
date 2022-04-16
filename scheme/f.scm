;#1: Group Members - Matthew Newhouse,

;#2: Recaman's Sequence

;#3: Give The Nth Element Of A List

(define l1 (list 1 2 3 4))
(define l2 (list 1 2 3))
(define l3 (list 1 2))
(define l4 (list 1))
(define l5 (list))

(define (findN lis n )
  (cond
    ((null? lis) #f)
    (else (findNitem lis n))
    )
)

(define (findNitem lis n)
  (cond
    ((eq? n 0) (car lis))
    (else (findN (cdr lis) (- n 1)))
  )
)

(newline)
(write "Testing 3")
(newline)
(write(findN l1 0))
(write(findN l1 1))
(write(findN l1 2))
(write(findN l5 0))
(newline)

;#4

;#5: Two lists and returns whether or not the first list is shorter than the second

(define (shorter lis1 lis2)
	(< (length lis1) (length lis2))
)

(newline)
(write "Testing 5")
(newline)
(write (shorter l1 l2))
(write (shorter l2 l1))
(write (shorter l5 l1))
(write (shorter l1 l5))
(newline)

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

(newline)
(write "Testing 6")
(newline)
(write(len l1))
(write(len l2))
(write(len l3))
(write(len l4))
(write(len l5))
(newline)
