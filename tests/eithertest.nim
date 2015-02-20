# Module eithertest

## Copyright© 2015 by Steven Dobay

import unittest, macros
import "../nymph/either"

proc mul2(x: int): int = x * 2
proc madd(a, b: int): int = a + b

suite "Either's tests":
 setup :
  echo "Tests started!"

 teardown :
  echo "Tests executed!" 

 test "using mapLeft _ * 2 on left[int, int](10) must be left[int, int](10)" :
  check left[int, int](10).mapLeft(mul2).left == 20

 test "using mapLeft _ * 2 on right[int, int](10) must be right[int, int](10)" :
  check right[int, int](10).mapLeft(mul2).right == 10

 test "using mapRight _ * 2 on right[int, int](10) must be right[int, int](20)" :
  check right[int, int](10).mapRight(mul2).right == 20 

 test "using mapRight _ * 2 on left[int, int](10) must be left[int, int](10)" :
  check left[int, int](10).mapRight(mul2).left == 10

 test "applying left[int, int](10).fold(mul2, mul2)" :
  check left[int, int](10).fold(mul2, mul2) == 20

 test "left[int, int](10).swap must be right[int, int](10)" :
  check left[int, int](10).swap.right == 10
