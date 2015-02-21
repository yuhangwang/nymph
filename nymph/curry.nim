# Module curry

# Copyright© 2015 by Steven Dobay

# curries a function with two parameters
proc `¬`*[A, B, C](fn: proc (a: A, b: B): C): (proc (a: A): proc (b: B): C) = 
 proc f1(a: A): auto = 
  proc f2(b: B): C = fn(a, b)
  f2
 f1

# curries a function with three parameters
proc `¬`*[A, B, C, D](fn: proc (a0: A, b0: B, c0: C): D): auto = 
 proc f1(a: A): proc (bb: B): proc (cc: C): D = 
  proc f2(b: B): proc (ccc: C): D = 
   proc f3(c: C): D = fn(a, b, c)
   f3
 f1