# Module either

## Copyright© 2015 by Steven Dobay

## A direction-based data-structure
type
 Either*[A, B] = object of RootObj
  case isLeft* : bool
  of true : left*  : A
  of false: right* : B

## returns true if it contains a right-value
proc isRight*[A, B](either: Either[A, B]): bool = not either.isLeft  

## creates a new Either with left-value
proc left*[A, B](a: A): auto = Either[A, B](isLeft : true, left : a)

## creates a new Either with right-value
proc right*[A, B](b: B): auto = Either[A, B](isLeft : false, right : b)

## creates a new either with swapped-values
proc swap*[A, B](either: Either[A, B]): auto = 
 if either.isLeft: result = right[B, A](either.left)
 else: result = left[B, A](either.right)

## maps the the left-value of an Either
proc mapLeft*[A, B, C](either: Either[A, B], fn: proc (a: A): C): auto = 
 if either.isLeft: result = left[C, B](fn either.left)
 else: result = right[C, A](either.right)

## maps the right-value of an Either
proc mapRight*[A, B, C](either: Either[A, B], fn: proc (a: B): C): auto = 
 if either.isRight: result = right[A, C](fn either.right)
 else: result = left[A, C](either.left)

## folds the value of an Either by two functions depending on path
proc fold*[A, B, C](either: Either[A, B], fn1: proc (a: A): C, fn2: proc (b: B): C): auto =
 if either.isLeft: result = fn1 either.left
 else: result = fn2 either.right