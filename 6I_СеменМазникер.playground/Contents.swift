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
    var weight : Int { get set }
}

class Human : Living {
    var name : String
    var hight : Int
    var weight : Int
    
    init(_ name : String, _ hight : Int, _ weight : Int){
        self.name = name
        self.hight = hight
        self.weight = weight
    }
    
}

struct Queue<T : Living> {
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
    
}


let Alex = Human("Alex", 154, 50)
let Bob = Human("Bob", 215, 114)
let Ginger = Human("Gignger", 178, 59)
let Marigold = Human("Marigold", 163, 54)

var a = Queue<Human>()

a.pushBack(Bob)
a.pushBack(Marigold)
a.pushBack(Alex)
a.pushBack(Ginger)

print(a[1, 2]) //subscript: Вывод суммы веса людей в очереди






