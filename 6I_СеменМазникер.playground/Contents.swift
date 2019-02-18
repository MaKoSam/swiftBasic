//
//  main.swift
//  Lesson Six Home Work
//
//  Created by Sam Mazniker on 2/17/19.
//  Copyright © 2019 Sam Mazniker. All rights reserved.
//

import Foundation
import UIKit

protocol Living {
    var sex : Character { get set }
    var weight : Int { get set }
}

extension Human : CustomStringConvertible {
    var description: String {
        return "Имя - \(self.name)\nПол - \(self.sex)\nРост - \(self.hight)\nВес - \(self.weight)\n"
    }
}

class Human : Living {
    var name : String
    var sex : Character
    var hight : Int
    var weight : Int
    
    init(_ name : String, _ sex : Character, _ hight : Int, _ weight : Int){
        self.name = name
        self.sex = sex
        self.hight = hight
        self.weight = weight
    }
}

let female : (Human) -> Bool = { (pearson : Human) -> Bool in //Замыкания
    return pearson.sex == "f"
}

let male : (Human) -> Bool = { (pearson : Human) -> Bool in //Замыкания
    return pearson.sex == "m"
}

struct Queue<T : Living> { //Очередь
    private var array : [T] = []
    
    mutating func pushBack (_ element : T){
        array.append(element)
    }
    
    mutating func popFirst () -> T? {
        return array.remove(at: 0)
    }
    
    func size() -> Int {
        return array.count
    }
    
    subscript(elements : Int ...) -> Int? {
        var total : Int = 0
        for index in elements {
            if index > self.size() - 1 {
                print("Fatal error. Index out of range.")
                return nil
            }
            total += self.array[index].weight
        }
        return total
    }
    
    subscript(predicate: (T) -> Bool, elements : Int ...) -> Int? {
        var total : Int = 0
        for index in elements where predicate(array[index]){
            if index > self.size() - 1 {
                print("Fatal error. Index out of range.")
                return nil
            }
            total += self.array[index].weight
        }
        return total
    }
    
    func filter (predicate: (T) -> Bool) -> Queue<T> {
        var tmpArray = Queue<T>()
        for elements in array {
            if predicate(elements) {
                tmpArray.pushBack(elements)
            }
        }
        return tmpArray
    }
    
    func printInfo() {
        for elements in array {
            print(elements)
        }
    }
}


let Alex = Human("Alex", "m", 154, 50)
let Bob = Human("Bob", "m", 215, 114)
let Ginger = Human("Gignger", "f", 178, 59)
let Marigold = Human("Marigold", "f", 163, 54)

var a = Queue<Human>()

a.pushBack(Bob)
a.pushBack(Marigold)
a.pushBack(Alex)
a.pushBack(Ginger)

print(a[1, 2]) //subscript: Вывод суммы веса людей в очереди

print(a[male, 1, 2]) //subscript 2: Вывод суммы веса мужчин в очереди
print(a[female, 1, 2]) //subscript 2: Вывод суммы веса женщин в очереди

var maleQueue = a.filter(predicate: male) //Сортировка по полу
var femaleQueue = a.filter(predicate: female)


maleQueue.printInfo() //Вывод очереди из мужчин

femaleQueue.printInfo() //Вывод очереди из женщин









