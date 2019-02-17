//
//  main.swift
//  Lesson Six Home Work
//
//  Created by Sam Mazniker on 2/17/19.
//  Copyright © 2019 Sam Mazniker. All rights reserved.
//

import Foundation
import UIKit

struct queue<T> { //Очередь
    private var array : [T] = []
    
    mutating func pushBack (_ element : T){
        array.append(element)
    }
    
    mutating func popFirst () -> T? {
        return array.remove(at: 0)
    }
    
    func size() -> Int? {
        return array.count
    }
}


var a = queue<Int>() // queue a


