//: Playground - noun: a place where people can play

import UIKit

/*:
## `NSDate` wrapping and convenience methods
*/
let calendar = NSCalendar.currentCalendar()

extension Int {
	public var days: NSDateComponents {
		return self.calendarUnit(.Day)
	}
	
	private func calendarUnit(unit: NSCalendarUnit) -> NSDateComponents {
		let dateComponents = NSDateComponents()
		dateComponents.setValue(self, forComponent: unit)
		return dateComponents
	}
}

extension NSDate {
	private func valueForUnit(unit: NSCalendarUnit) -> Int {
		return calendar.component(unit, fromDate: self)
	}
	
	var weekday: Int {
		return valueForUnit(.Weekday)
	}
}

func + (date: NSDate, component: NSDateComponents) -> NSDate {
	return calendar.dateByAddingComponents(component, toDate: date, options: NSCalendarOptions(rawValue: 0))!
}

let date = NSDate()
let nextDay = date + 3.days

/*:
## Generators and sequences section
*/

class DateGenerator: GeneratorType {
	// We are using very naive approach here
	// Do not use it on real projects =)
	var dayOffWeekday: Int = 1 // Sunday
	var N: Int = 3
	
	var lessonsCount: Int
	var startDate: NSDate
	
	private var numIterations = 0
	
	init(_ start: NSDate, _ numLessons: Int) {
		lessonsCount = numLessons
		startDate = start
	}
	
	func next() -> NSDate? {
		guard numIterations < lessonsCount else {
			return nil
		}
		numIterations += 1
		
		var next = startDate + N.days
		if next.weekday == dayOffWeekday {
			next = next + 1.days
		}
		startDate = next
		return next
	}
}

let dg = DateGenerator(NSDate(), 10)
dg.N = 1
dg.dayOffWeekday = 1
while let date = dg.next() {
	print(date)
}

while let date = dg.next() { // Exhausted
	print(date)
}

class DateSequece: SequenceType {
	var lessonsCount: Int
	var startDate: NSDate
	
	init(_ start: NSDate, _ numLessons: Int){
		lessonsCount = numLessons
		startDate = start
	}
	
	func generate() -> DateGenerator {
		return DateGenerator(startDate, lessonsCount)
	}
}

let sequence = Array(DateSequece(NSDate(), 10))

/*:
## `SequenceType` section
*/

class SimpleDateSequece: SequenceType {
	var lessonsCount: Int
	var startDate: NSDate
	var daysStep: Int = 1
	private var numIterations = 0
	
	init(_ start: NSDate, _ numLessons: Int, step: Int){
		lessonsCount = numLessons
		startDate = start
		daysStep = step
	}
	
	func generate() -> AnyGenerator<NSDate> {
		return AnyGenerator(body: {
			guard self.numIterations < self.lessonsCount else {
				return nil
			}
			self.numIterations += 1
			
			let next = self.startDate + self.daysStep.days
			self.startDate = next
			return next
		})
	}
}

let simpleSequence = Array(SimpleDateSequece(NSDate(), 5, step: 4))
/*:
## Infinite sequences section
*/

class InfiniteDateGenerator: GeneratorType {
	var startDate: NSDate
	
	private var numIterations = 0
	
	init(_ start: NSDate) {
		startDate = start
	}
	
	func next() -> NSDate? {
		let next = startDate + 1.days
		startDate = next
		return next
	}
}

class InfiniteDateSequece: SequenceType {
	var startDate: NSDate
	
	init(_ start: NSDate){
		startDate = start
	}
	
	func generate() -> InfiniteDateGenerator {
		return InfiniteDateGenerator(startDate)
	}
}

//let infiniteSequence = Array(InfiniteDateSequece(NSDate()))
let tenFirsElements = Array(InfiniteDateSequece(NSDate()).prefix(10))

let mondayIndex = 2
//let noMondaysSequence = Array( InfiniteDateSequece(NSDate()).filter({$0.weekday != mondayIndex}).prefix(10) ) // Infinite
let lazyNoMondaysSequence = Array( InfiniteDateSequece(NSDate()).lazy.filter({$0.weekday != mondayIndex}).prefix(10) ) // Finite


