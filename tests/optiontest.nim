# Module optiontest

# Copyright© 2015 Steven Dobay

import unittest, macros, option, curry

proc gtThanZero(x: int): bool = x > 0
proc madd(x, y: int): auto = x + y

let none = Option[int](isDefined: false)

suite "Option's suite:" :

 setup :
  echo "Starting test"

 teardown :
  echo "Test ended" 

 test "some 1 satisfies (proc (x: int) = x > 0)" :
  check some(1).isSatisfy(gtThanZero)

 test "none not satisfies (proc (x: int) = x > 0)" :
  check (not none.isSatisfy(gtThanZero))

 test "some 0 not satisfies (proc (x: int) = x > 0)" :
  check(not some(0).isSatisfy(gtThanZero))

 test "some 1 folded by proc + 2 must be 3" :
  check some(1).fold(2, proc (a, b: int): int = a + b) == 3

 test "none folded by proc + 2 must be 2" :
  check none.fold(2, proc (a, b: int): int = a + b) == 2

 test "some 2 map proc * 2 must be some 4" :
  check some(2).map(proc (x: int): int = x * 2).value == 4

 test "none map proc * 2 must be none" :  
  check (not none.map(proc (x: int): int = x * 2).isDefined)

 test "some 1 filtered by proc (x: int) = x > 0) gives some 1" :
  check some(1).filter(gtThanZero).value == 1

 test "some 0 filtered by proc (x: int) = x > 0) gives none" :
  check(not none.filter(gtThanZero).isDefined)

 test "some 2 flatmapped with proc some(x * 2) must be some(4)"  :
  check some(2).flatMap(proc (x: int): auto = some(x * 2)).value == 4

 test "none flatmapped with proc some(x * 2) must be none"  :
  check(not none.flatMap(proc (x: int): auto = some(x * 2)).isDefined)

 test "some 1 applicated by the curried madd and some 2 must be some 3" :
  check some(1).map(¬ madd).app(some 2).value == 3

 test "none applicated by the curried madd and some 2 must be none" :
  let opt = Option[int](isDefined: false).map(¬ madd).app(some 2)
  check opt.isDefined == false