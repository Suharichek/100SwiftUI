import UIKit
import Foundation
import SwiftUI

// Checkpoint 1
let tempC: Double = 12
var tempF = tempC * 9 / 5 + 32

print("TempC = \(tempC)°C, TempF = \(tempF)°F")

// Checkpoint 2
let array = ["Blue", "Green", "Red", "Yellow", "Red", "Green"]
let colors = Set(array)

print("Array is consist of \(array.count) colors and have \(colors.count) of them without doublicates.")

// Checkpoint 3
for i in 1...100 {
    if i.isMultiple(of: 3) && i.isMultiple(of: 5) {
        print("FizzBuzz")
    } else if i.isMultiple(of: 3) {
        print("Fizz")
    } else if i.isMultiple(of: 5) {
        print("Buzz")
    }
    else {
        print("\(i)")
    }
}

// Checkpoint 4
enum NumberError: Error {
    case noNumber
}

func checkSqrt(number: Int) throws -> Int {
    for i in 1...10000 {
        if i * i == number {
           return i
        }
        else if number > 10000 || number < 1 {
            throw NumberError.noNumber
        }
    }
    return number
}
do {
    let result = try checkSqrt(number: 100001)
    print("Sqrt is \(result)")
} catch {
    print("No sqrt")
}

// Checkpoint 5
let luckyNumbers = [1, 4, 6, 63, 28, 99, 123, 5]

luckyNumbers.sorted().filter({!$0.isMultiple(of: 2)}).map{print("\($0) is a lucky number")}

// Checkpoint 6
struct Car {
  let model: String
  let numberOfSeats: Int

  private(set) var currentGear = 0 {
    didSet {
      print("Current gear is: \(currentGear)")
    }
  }

  mutating func gearUp() {
    if (currentGear < 10) {
      currentGear += 1
    }
  }

  mutating func gearDown() {
    if (currentGear > 0) {
      currentGear -= 1
    }
  }
}

var myCar = Car(model: "Tesla", numberOfSeats: 4)

myCar.gearUp()
myCar.gearUp()
myCar.gearDown()

// Checkpoint 7
class Animal {
  let numberOfLegs: Int

  init(legs: Int) {
    numberOfLegs = legs
  }
}

class Dog: Animal {
  func speak() {
    print("Woof! woof!")
  }
}

class Cat: Animal {
  var isTame: Bool

  init(legs: Int, isTame: Bool) {
    self.isTame = isTame
    super.init(legs: legs)
  }

  func speak() {
    print("Meow!")
  }
}

class Corgi: Dog {
  override func speak() {
    print("Woof! woof! I'm a Corgi")
  }
}

class Poodle: Dog {
  override func speak() {
    print("Woof! woof! I'm a Poodle")
  }
}

class Persian: Cat {
  override func speak() {
    print("Meow! I'm a Persian")
  }
}

class Lion: Cat {
  override func speak() {
    print("Rraawwrr!!")
  }
}

let myCorgi = Corgi(legs: 4)
myCorgi.speak()

let myPoodle = Poodle(legs: 4)
myPoodle.speak()

let myPersian = Persian(legs: 4, isTame: true)
myPersian.speak()

let myLion = Lion(legs: 4, isTame: false)
myLion.speak()

// Checkpoint 8
protocol Building {
  var numberOfRooms: Int { get }
  var price: Int { get }
  var salesperson: String { get }

  func summary()
}

struct House: Building {
  var numberOfRooms: Int
  var price: Int
  var salesperson: String
}

struct Office: Building {
  var numberOfRooms: Int
  var price: Int
  var salesperson: String
}

let myHouse = House(numberOfRooms: 4, price: 50_000, salesperson: "Nicky")
myHouse.summary()

let myOffice = Office(numberOfRooms: 40, price: 500_000, salesperson: "Ethan")
myOffice.summary()

extension Building {
    func summary() {
      print("This is a $\(price) office building which has \(numberOfRooms) rooms sold by \(salesperson)")
    }
}

// Checkpoint 9
func getRandomNumber(from numbers: [Int]?) -> Int {
  return numbers?.randomElement() ?? Int.random(in: 1...100)
}
print(getRandomNumber(from: [1,2,3]))
print(getRandomNumber(from: nil))
