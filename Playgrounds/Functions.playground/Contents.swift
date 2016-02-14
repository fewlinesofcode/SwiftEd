/*
Let's talk a bit about functions in Swift.

> The function is a self-containing block of code for performing the specific task. The function is a thing, that we use every day. It's like a building block for our code.
	
	The general form of the Swift function is:
*/
/*
func <#funcName#>(<#paramName#>: <#ParamType#>, ...) -> <#resultType#> {
	// Function body goes here...
}
*/
/*
Let's see it closer using sample:
*/
/*
func doSomethingCool(foo: FooType, withBar bar: BarType, andBuz buz: BuzType) -> ResultType {
	// Function body goes here...
}
*/
/*
The `func` keyword, denotes that this is a function<br>
`doSomethingCool` is the name of the function<br>
`(foo: FooType, withBar bar: BarType, andBuz buz: BuzType)` - the parameters of the function.<br>
`foo`, `bar`, `baz` - parameters variable names.<br>
`withBar`, `andBuz` - parameters names.<br>
`FooType`, `BarType`, `BazType` - parameters types<br>
`ResultType` - the type of the returned result. Can be empty (`void`)<br>
`{}` - contains the function body.<br>
*/
/*
##Simplest function
The function can be simple. Let's check the simplest one.
It starts with `func` keyword and named `printMessage`, does not have arguments nor return value. It just performs code contained inside curly braces `{...}`
*/
func printMessage() {
	print("Follow the white rabbit!")
}
printMessage()
	// > Follow the white rabbit!
/*
#Parameters syntax
The function can accept parameters. For example, the following function accepts **single** `String` parameter with the name `name`.
The name of the first parameter is usually omitted.
*/
func greet(name: String) {
	print("Hello, " + name)
}
greet("Neo") // First parameter name is omitted
	// > Hello, Neo!
/*
The function can accept **multiple parameters**. The name of the first parameter is usually omitted. All the other parameters names must be noticed.
In the next example parameter `agentName` is omitted in the function call, but `numTimes` parameter is noticed.
*/
func punchAgentInFace(agentName: String, numTimes count: Int) {
	for var i = 0; i < count; i++ {
		print("Hit agent \(agentName)")
	}
}
punchAgentInFace("Smith", numTimes: 4)
	// Prints 4 times
	// > Hit agent Smith
	
/*
If you want to omit further parameters also, just replace them with `_`.
That's how previous function call will look like with second parameter omitted:
*/
func punchAgentInFace(agentName: String, _ count: Int) {
	for var i = 0; i < count; i++ {
		print("Hit agent \(agentName)")
	}
}
punchAgentInFace("Smith", 4)
	// Prints 4 times
	// > Hit agent Smith
	
/*
##Named parameters
If you want to make all parameters named, just type desired parameter name before the variable name. Like in **Objective-C**, remember?
That's how previous function will look like with named first parameter:
*/
func punchAgentInFace(agent agentName: String, numTimes count: Int) {
	for var i = 0; i < count; i++ {
		print("Hit agent \(agentName)")
	}
}
punchAgentInFace(agent: "Smith", numTimes: 4)
	// Prints 4 times
	// > Hit agent Smith
	
/*
##Parameters with default values
The function can have default parameter values. If you skip parameter in a function call, it will take a default value. Otherwise, it will take passed value.
Parameter `name` from the next code sample has default value `"Neo"`.
*/
func sayHello(name: String = "Neo") {
	print("Hello, " + name + "!")
}
sayHello()
// > Hello, Neo!
sayHello("Morpheus")
// > Hello, Morpheus!

/*
##Variadic parameters
Variadic parameters are handy, when paramters count is unknown. Variadic parameter is transformed to `Array` of parameter Type
To mark parameter as variadic use `name: <Type>...` syntax. See the following sample:
*/
func inviteToParty(friends: String..., place: String) -> String {
	var invitation = "Dear friends! Let me invite you to the party! There will be "
	for friend in friends { // `friends` is [String] array
		invitation += "\(friend), "
	}
	return invitation + "and me. Place: \(place)"
}
inviteToParty("Trinity", "Morpheus", place: "Eastern part of Zion")
	// > "Dear friends! Let me invite you to the party! There will be Trinity, Morpheus, and me. Place: Eastern part of Zion"
	
/*
##Constant and variable parameters.
By default, all parameters are constants. But, in some cases, it's convenient to change the parameter value. To make parameter variable, add `var` keyword before parameter name.
Notice, that parameter value, in this case, will be changed only inside function scope.
*/
func thereIs(var item: String) {
	if item == "spoon" {
		item = "There is no \(item)!"
	} else {
		item = "There is \(item)"
	}
	print(item)
}
thereIs("a red pill")
// > There is a red pill
thereIs("spoon")
// > There is no spoon!


/*
##In-out parameters
As mentioned above, variable parameters can only be changed by the function itself. If you need the function to change some parameters from outside the function scope, you should use `inout` keyword. Keep in mind that `inout` parameters cannot have default values.
*/
func swapAgents(inout agentA: String, inout agentB: String) {
	let temporaryA = agentA
	agentA = agentB
	agentB = temporaryA
}

var smith = "Smith"
var johnson = "Johnson"
swapAgents(&smith, agentB: &johnson)
print("Sminth is now \(smith), Johnson is now \(johnson)")
// > Sminth is now Johnson, Johnson is now Smith


/*
##Generic parameters
We can rewrite `swapAgents(_:_:)` function in a more general way. Using the following notation we tell that function accepts two parameters of any type, but the type of the parameter `a` is always the same as the parameter `b` type
*/
func swap1<T>(inout a: T, inout _ b: T) {
	let temporaryA = a
	a = b
	b = temporaryA
}

var agentSmith = "Smith"
var agentJohnson = "Johnson"
swap1(&agentSmith, &agentJohnson)
print("Sminth is now \(smith), Johnson is now \(johnson)")
// > Sminth is now Johnson, Johnson is now Smith

var a = 1
var b = 2
swap1(&a, &b)
print("a is now \(a), b is now \(b)")
// > a is now 2, b is now 1

/*
#Return values syntax
Functions can return values. It is not required (all the functions above did not return any values). Basically, functions are small programs, which can return results of their work.
As you can see, `isThereASpoon(_:)` function returns the single value of `Bool` type. In Swift, return value type is separated from function name with `->` symbol.
*/
func isThereASpoon(whoAsks: String) -> Bool {
	return whoAsks != "Neo"
}
print(isThereASpoon("Neo"))
// > false
print(isThereASpoon("Trinity"))
// > true


/*
##Multiple return values
Sometimes we need to receive multiple return values from a function. It is possible. Swift allows us to deal with it in an elegant way. The following code sample shows how to use and access multiple return values:
*/
func distributeToShips(crew: [String]) -> (nebuchadnezzar: [String], osiris: [String]) {
	var nebuchadnezzarCrew = [String]()
	var osirisCrew = [String]()
	for var i = 0; i < crew.count; i++ {
		if i % 2 == 0 {
			nebuchadnezzarCrew.append(crew[i])
		} else {
			osirisCrew.append(crew[i])
		}
	}
	return (nebuchadnezzarCrew, osirisCrew)
}

let crew = distributeToShips(["Neo", "Morpheus", "Trinity", "Seraph", "Cipher", "Dozer", "Tank"])
print("Nebuchandezzar crew: \(crew.nebuchadnezzar); Osiris crew: \(crew.osiris)")
	// > "Nebuchandezzar crew: ["Neo", "Trinity", "Cipher", "Tank"]; Osiris crew: ["Morpheus", "Seraph", "Dozer"]"
	
/*
##Optional tuple
If there is probability, that returning tuple will have no value, we should use an Optional tuple. The function above, rewritten with optional tuple, will look like this:
*/

func distributeToShipsOptional(crew: [String] = []) -> (nebuchadnezzar: [String], osiris: [String])? {
	if crew.count > 0 {
		var nebuchadnezzarCrew = [String]()
		var osirisCrew = [String]()
		for var i = 0; i < crew.count; i++ {
			if i % 2 == 0 {
				nebuchadnezzarCrew.append(crew[i])
			} else {
				osirisCrew.append(crew[i])
			}
		}
		return (nebuchadnezzarCrew, osirisCrew)
	}
	return nil
}

if let crew = distributeToShipsOptional(["Neo", "Morpheus", "Trinity", "Seraph", "Cipher", "Dozer", "Tank"]) {
	print("Nebuchandezzar crew: \(crew.nebuchadnezzar); Osiris crew: \(crew.osiris)")
}
// > "Nebuchandezzar crew: ["Neo", "Trinity", "Cipher", "Tank"]; Osiris crew: ["Morpheus", "Seraph", "Dozer"]"

if let crew = distributeToShipsOptional() {
	print("Nebuchandezzar crew: \(crew.nebuchadnezzar); Osiris crew: \(crew.osiris)")
}
// >

/*
#Function type
You can pass any function as an argument or use it as a return value of any other function. In Swift, functions are *first-class* values. Function has a type. Function type general form is `(argument types) -> return type`. In the example below, both functions, `plus(_: _:)` and `multiply(_: _:)` has the same type: `(Int, Int) -> Int`. `calculate(_: _: _:)` function uses proper function depending on the operation passed as argument.
*/
func plus(a: Int, _ b: Int) -> Int {
	return a + b
}

func multiply(a: Int, _ b: Int) -> Int {
	return a * b
}

// Function type is used as parameter type
func calculate(a: Int, b: Int, operation: (Int, Int) -> Int) -> Int {
	return operation(a, b)
}

print(calculate(3, b: 7, operation: plus))
// > 10
print(calculate(3, b: 7, operation: multiply))
	// > 35
	
/*
##Function as return value
Function can also be used as return type of other function. `mathFunction(_:)` returns `(Int, Int) -> Int` function, which is used by `calculate(_: _: _:)` function from the previous example;
*/
enum Operation {
	case Plus
	case Multiply
}

func mathFunction(operation: Operation) -> (Int, Int) -> Int {
	switch operation {
	case .Plus:
		return plus
	case .Multiply:
		return multiply
	}
}

print(calculate(10, b: 3, operation: mathFunction(.Plus)))
// > 13
print(calculate(10, b: 3, operation: mathFunction(.Multiply)))
	// > 30
	
/*
The type of the function can be named using `typealias` keyword. Let's rewrite our math functions using `typealas`.
*/
typealias OperationFunction = (Int, Int) -> Int

func plus1(a: Int, _ b: Int) -> Int {
	return a + b
}

func multiply1(a: Int, _ b: Int) -> Int {
	return a * b
}

// Function type is used as parameter type
func calculate1(a: Int, b: Int, operation: OperationFunction) -> Int {
	return operation(a, b)
}

print(calculate1(3, b: 7, operation: plus))
// > 10
print(calculate1(3, b: 7, operation: multiply))
	// > 35
	
/*
##Nested functions
Nested functions are functions, used inside the other functions.
*/
typealias Printer = () -> String
func whoWillWin(isOptimist: Bool) -> Printer {
	func neo() -> String { return "Neo" }
	func smith() -> String { return "Smith" }
	if isOptimist {
		return neo
	} else {
		return smith
	}
}

let iAmGood = true
print(whoWillWin(iAmGood)()) // Notice `functionName(param)()` syntax. Remember, `whoWillWin(_:)` returns function!
	// > Neo
	
/*
##Conclusion
**Functions in Swift** are powerful and flexible. But remember, with a great power comes a great temptation. A variety of possible forms of recording functions leads to the fact that there are different ways to solve the same problem. **One true way** is not about Swift. If you are playing in your personal playground, it's ok to use any fun code writing approach. But, if you have teammates, then you should be really careful keeping the balance between cool language features and code readability. Good news, we can talk to each other and share the knowledge. Use this ability, and everything will be fine.
####Downloads
[Playground with all the samples used in article](http://limlab.io/files/playgrounds/functions_playground.zip)<br>

####Sources
Please, check these sources for the details:<br>
[• Swift Book (Swift 2.1 edition)](https://itunes.apple.com/us/book/swift-programming-language/id881256329?mt=11)<br>
[• The many face of Swift function by Objc.io](https://www.objc.io/issues/16-swift/swift-functions/)<br>
[• Official Swift documentation](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Functions.html#//apple_ref/doc/uid/TP40014097-CH10-ID158)<br>
*/