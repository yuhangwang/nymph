# Module option

# Copyright© 2015 by Steven Dobay

# A datatype for using optional values
type
 Option*[T] = object of RootObj
   case isDefined* : bool
   of true : value* : T
   of false : nil

# returns with a new Option containing val
proc some*[T](val : T) : Option[T] = 
 Option[T](isDefined : true, value : val)

# returns with an empty Option with type T
proc none[T]() : Option[T] = Option[T](isDefined : false)

# returns true if option is defined
proc `?`*[T](option: Option[T]): bool = option.isDefined

# returns with a string containing "some " and value or "none"
proc `$`*[T](option: Option[T]): string = 
 if ?option : result = "some " & $option.value
 else : result = "none"

 # returns true if the value satisfies the predicate
proc isSatisfy*[A](option: Option[A], pred: proc (a: A): bool): bool =
 if ?option : result = pred option.value
 else : result = false

# returns with the option if it satisfies the predicate
proc filter*[A](option: Option[A], pred: proc (a: A): bool): Option[A] =
 if ?option and pred(option.value) : result = option
 else : result = none[A]()

# returns with the folded value from op and option.value
proc fold*[A, B](option: Option[A], init: B, op: proc (a: A, b: B): B): B =
 if ?option : result = op(option.value, init)
 else : result = init

# returns with a new Option mapped by fn
proc map*[A, B](option: Option[A], fn: proc (a: A): B) : Option[B] = 
 if ?option : result = some fn(option.value)
 else : result = none[B]()

# returns with a new Option mapped by fn
proc `|>`*[A, B](option: Option[A], fn: proc (a: A): B): auto {.discardable.} = 
 map(option, fn)

# returns with a new Option created from fn and option 
proc flatMap*[A, B](option: Option[A], fn: proc (a: A): Option[B]): Option[B] =
 if ?option : result = fn option.value
 else : result = none[B]()

# returns with a new Option created from fn and option
proc `->`*[A, B](option: Option[A], fn: proc (a: A) : Option[B]): Option[B] =
 flatMap(option, fn)

# maps the function inside fns over the option's value
proc app*[A, B](fns: Option[proc (a: A): B], option: Option[A]): Option[B] =
 fns.flatMap(proc (fn: proc (a: A): B): Option[B] = option.map(fn))

# maps the function inside fns over the option's value
proc `*>`*[A, B](fns: Option[proc (a: A) : B], option : Option[A]): Option[B] =
 app(fns, option)