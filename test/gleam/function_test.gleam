import gleam/function
import gleam/int
import gleam/pair
import gleam/should
import gleam/string

pub fn curry2_test() {
  let fun = fn(a, b) { a + b }
  let curried = function.curry2(fun)

  curried(1)(2)
  |> should.equal(3)
}

pub fn curry3_test() {
  let fun = fn(a, b, c) { a + b + c }
  let curried = function.curry3(fun)

  curried(1)(2)(4)
  |> should.equal(7)
}

pub fn curry4_test() {
  let fun = fn(a, b, c, d) { a + b + c + d }
  let curried = function.curry4(fun)

  curried(1)(2)(4)(8)
  |> should.equal(15)
}

pub fn curry5_test() {
  let fun = fn(a, b, c, d, e) { a + b + c + d + e }
  let curried = function.curry5(fun)

  curried(1)(2)(4)(8)(16)
  |> should.equal(31)
}

pub fn curry6_test() {
  let fun = fn(a, b, c, d, e, f) { a + b + c + d + e + f }
  let curried = function.curry6(fun)

  curried(1)(2)(4)(8)(16)(32)
  |> should.equal(63)
}

pub fn flip_test() {
  let fun = fn(s: String, i: Int) {
    s
    |> string.append("String: '", _)
    |> string.append("', Int: '")
    |> string.append(int.to_string(i))
    |> string.append("'")
  }

  let flipped_fun = function.flip(fun)

  fun("Bob", 1)
  |> should.equal("String: 'Bob', Int: '1'")

  flipped_fun(2, "Alice")
  |> should.equal("String: 'Alice', Int: '2'")
}

pub fn identity_test() {
  1
  |> function.identity
  |> should.equal(1)

  ""
  |> function.identity
  |> should.equal("")

  []
  |> function.identity
  |> should.equal([])

  #(1, 2.0)
  |> function.identity
  |> should.equal(#(1, 2.0))
}

pub fn tap_test() {
  "Thanks Joe & Louis"
  |> function.tap(fn(s: String) {
    string.append(s, "... and Jose!")
    Nil
  })
  |> should.equal("Thanks Joe & Louis")
}

pub fn apply1_test() {
  let fun = fn(x1) { x1 }

  fun
  |> function.apply1(1)
  |> should.equal(1)
}

pub fn apply2_test() {
  let fun = fn(x1, x2) { x1 + x2 }

  fun
  |> function.apply2(1, 2)
  |> should.equal(3)
}

pub fn apply3_test() {
  let fun = fn(x1, x2, x3) { x1 + x2 + x3 }

  fun
  |> function.apply3(1, 2, 3)
  |> should.equal(6)
}

pub fn apply3_maintains_arguments_orders_test() {
  let first = "first"
  let second = "second"
  let third = "third"
  let fun = fn(x1, x2, x3) {
    should.equal(x1, first)
    should.equal(x2, second)
    should.equal(x3, third)
  }

  function.apply3(fun, first, second, third)
}

pub fn apply3_supports_arguments_of_different_types() {
  let fun = fn(x1, _x2, _x3) { x1 }

  fun
  |> function.apply3(1, 0.5, "3")
  |> should.equal(1)
}
