/*
> Closures are self-contained blocks of functionality that can be passed around and used in your code. Closures in Swift are similar to blocks in C and Objective-C and to lambdas in other programming languages. Swift’s closure expressions have a clean, clear style, with optimizations that encourage brief, clutter-free syntax in common scenarios.

For better understanding, I strongly recommend you to read the [Swift functions cheatsheet]({% post_url 2016-02-12-swift-functions-cheatsheet %}) and it's sources.

# Closure syntax
Since any function is the special case of closure, they are pretty the same. Basic difference is the way of writing and the use purpose. Closures syntax is optimized to be convenient for *inlining*, *passing as parameter* and *using as return type* of other functions.
	
The general form of the Swift closure is:
{ (parameters) -> ReturnType in
	//Closure body goes here...
}
Everything looks familiar, except `in` keyword.<br>
`in` keyword denotes, that parameters and return type section is over, and function body is started.

Let's imagine, that we have a function, that takes two `Int` numbers and the function of type `(Int, Int) -> Int`, which applies operation on these two integers and returns result. We will rewrite this function few times during the article for the sake of undestanding and exploring the benefits of the closures.
*/
func calculate(a: Int, _ b: Int, _ operation: (Int, Int) -> Int) -> Int {
	return operation(a, b)
}

func plus(a: Int, _ b: Int) -> Int {
	return a + b
}

func multiply(a: Int, _ b: Int) -> Int {
	return a * b
}

print(calculate(3, 7, plus))
// > 10
print(calculate(3, 7, multiply))
	// > 35

/*
## Inlining

Lets delete the `plus(_: _:)` and the `multiply(_: _;)` functions. We will pass the function directly to the `calculate(_: _: _:)` as a parameter. We are using the canonical general form closure syntax.
*/
print(calculate(3, 7, {(a: Int, b: Int) -> Int in
	return a + b
}))
// > 10
print(calculate(3, 7, {(a: Int, b: Int) -> Int in
	return a * b
}))
	// > 21
/*
## Inferring type from context
As you know, swift has such a cool feature as [Type Inference](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID322). The `calculate(_: _: _:)` expects, that `operation` parameter will have `(Int, Int) -> Int` type. Though, we can omit type declarations. Magic!
*/
print(calculate(3, 7, {(a, b) in
return a * b
}))
// > 21

/*
We can also delete the braces and the `return` statement.
*/
print(calculate(3, 7, {a, b in a * b}))
// > 21

/*
## Shorthand arguments
Despite the fact, that function call seems pretty even now, we can make it more compact and sofisticated using the shorthand argument syntax.
*/
print(calculate(3, 7, {$0 * $1}))
// > 21
/*
## Trailing closures
If closure is the last argument in the function call, we can use the trailing closure syntax. Closure argument just goes out of braces. This way is handy when there are multiple lines between `{}`
*/
print(calculate(3, 7){$0 * $1})
// > 21

/*
## Capturing values

> A closure can capture constants and variables from the surrounding context in which it is defined. The closure can then refer to and modify the values of those constants and variables from within its body, even if the original scope that defined the constants and variables no longer exists. (Excerpt from [Apple official documentations](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html)

For me it's not so transparent, so let's try to clarify. The simplest form of a closure, that can capture value is a nested function. Let's take a closer look at the Apple's sample from official documentation. `makeIncrementer(_:)` has return type `() -> Int`, therefore it returns **function**. The returned function takes `runningTotal` value, which is in the `makeIncrementer(_:)` scope, and adds `amount` to it. The reference to the value of `runningTotal` is captured from the functions context. 

Each the function is called, it will increment captured value. I strongly recommend to check official documentation to explore all other aspects of capturing.
*/

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
	var runningTotal = 0
	func incrementer() -> Int {
		runningTotal += amount
		return runningTotal
	}
	return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)

incrementByTen()
// > 10
incrementByTen()
// > 20
incrementByTen()
// > 30

/*
## Nonescaping Closures
> A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns. When you declare a function that takes a closure as one of its parameters, you can write `@noescape` before the parameter name to indicate that the closure is not allowed to escape. Marking a closure with `@noescape` lets the compiler make more aggressive optimizations because it knows more information about the closure’s lifespan.

The benefit of using `@noescape` is that you can call `self` implicitly within closure without a worrying about memory.

*/
func someFunctionWithNoescapeClosure(@noescape closure: () -> Void) {
	closure()
}

/*
## Autoclosures
If you pass expression as an argument of a function, it will be automatically wrapped by `autoclosure`. You often call functions, that takes autoclosures, but it's not common to implement that kind of functions. An autoclosure lets you to delay evaluation of the code inside, until you call the closure.

*/

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// > 5

let customerProvider = { customersInLine.removeAtIndex(0) }
print(customersInLine.count)
// > 5

print("Now serving \(customerProvider())!")
// prints "Now serving Chris!"
print(customersInLine.count)
// > 4

/*
You get the same behavior of delayed evaluation when you pass a closure as an argument to a function.
*/

// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
func serveCustomer(customerProvider: () -> String) {
	print("Now serving \(customerProvider())!")
}
serveCustomer( { customersInLine.removeAtIndex(0) } )
// > Now serving Alex!

/*
Rewriting the `serveCustomer(_:)` function by marking it's parameter with `@autoclosure` attribute makes us able to call the function as if it took a string argument instead of a closure.
*/

// customersInLine is ["Ewa", "Barry", "Daniella"]
func serveCustomer(@autoclosure customerProvider: () -> String) {
	print("Now serving \(customerProvider())!")
}
serveCustomer(customersInLine.removeAtIndex(0))
// > Now serving Ewa!

/*
The `@autoclosure` attribute implies the `@noescape` attribute, which is described above in **Nonescaping Closures**. If you want an autoclosure that is allowed to escape, use the @autoclosure(escaping) form of the attribute.

## Conclusions
Closures are not something just-invented. You can see, that they are the same as blocks. But syntax imrovements and Swift language features like type inferrence, takes closures to the new level of convenience. Closure syntax allows us to write short, sofisticated code and use some of Functional Programming benefits.

Also, unproper use of a closures can make your code terrible and unreadable. So think about it as about sharp knife in your hand. It can do good job, but can easuily cut off your finger in case of not safe usage.

#### Downloads
[Playground with samples](http://limlab.io/files/playgrounds/closures_playground.zip)<br>

#### Sources
[• WWDC session video](https://developer.apple.com/videos/play/wwdc2014-403/)<br>
[• Swift Book (Swift 2.1 edition)](https://itunes.apple.com/us/book/swift-programming-language/id881256329?mt=11)<br>
[• Official Swift documentation](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html)<br>
*/
