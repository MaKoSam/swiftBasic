//
//  main.swift
//  Lesson Three Home Work
//
//  Created by Sam Mazniker on 2/5/19.
//  Copyright © 2019 Sam Mazniker. All rights reserved.
//

import Foundation
import UIKit

struct vehicle  {
    var brand : String
    var produceDate : Int
    var trunkCapacity : Int //объем багажника
    var trunkCapacityFilled : Int
    var isEngineOn : Bool
    var isLightOn : Bool
    
    init(brand : String, date : Int, trunk : Int){
        self .brand = brand
        produceDate = date
        trunkCapacity = trunk
        trunkCapacityFilled = 0
        isEngineOn = false
        isLightOn = false
    }
    
    
}


var car : vehicle
//car = (brand : "audi", date : 2014, trunk : 80)
//todo: check for initializing of structure
//todo: check for the enum (in working with the struct)




