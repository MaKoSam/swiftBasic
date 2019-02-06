//
//  main.swift
//  HW 3 (enum + struct)
//
//  Created by Sam Mazniker on 2/5/19.
//  Copyright © 2019 Sam Mazniker. All rights reserved.
//

import Foundation
import UIKit

enum carEngine { //Состояние двигателя
    case on
    case off
}

enum carLight { //Состояние фар
    case normal //Свет включен
    case distance //Дальний свет включен
    case off //Свет выключен
}

enum carWindows { //Состояние окон
    case open
    case close
}

enum inOutTrunk { //Для метода погрузки/выгрузки груза из багажника
    case putIn //Загрузка
    case putOut //Выгрузка
}

struct vehicle {
    var brand : String //Марка авто
    var color : String //Цвет
    var produceDate : Int //Год производства
    var trunkCapacity : Int //Объем багажника
    var trunkCapacityFilled : Int //Объем заполненного груза в багажнике
    
    //Состояние двигателя с уведомлением при изменении
    var engineState : carEngine {
        willSet {
            if newValue == .on {
                print("Двигатель запускается.")
            } else {
                print("Двигатель выключен.")
            }
        }
    }
    
    //Состояние света фар с уведомлением при изменении
    var lightState : carLight {
        willSet {
            if newValue == .normal {
                print("Включен обычный свет фар.")
            } else if newValue == .distance {
                print("Включен дальний свет фар.")
            } else {
                print("Фары выключены.")
            }
        }
    }
    
    //Состояние окон с уведомлением при изменении
    var windowsState : carWindows {
        willSet {
            if newValue == .open {
                print("Окна открываются.")
            } else {
                print("Окна закрываются.")
            }
        }
    }
    
    //Упрощенная инициализация машины
    init(_ brand : String, _ carColor: String, _ date : Int, trunk : Int){
        self.brand = brand
        self.color = carColor
        self.produceDate = date
        self.trunkCapacity = trunk
        self.trunkCapacityFilled = 0
        self.engineState = .off
        self.lightState = .off
        self.windowsState = .close
    }
    
    //Метод: запуск и остановка двигателя
    mutating func changeEngineState(){
        self.engineState = self.engineState == .on ? .off : .on
    }
    
    //Метод: открытие и закрытие окон
    mutating func changeWindowsState(){
        self.windowsState = self.windowsState == .open ? .close : .open
    }
    
    //Метод: изменение состояния света фар
    mutating func changeLightState(changeTo action : carLight){
        self.lightState = action
    }
    
    //Метод: погрузка и выгрузка груза определенного объема
    mutating func trunkInOut(need mass: inOutTrunk, space: Int) -> String{
        switch mass { //Определение действия: Выгрузка / Погрузка
            
        case .putIn: //Погрузка
            if(space + trunkCapacityFilled) > trunkCapacity {
                return "Недостаточно свободного места в багажнике"
            } else {
                trunkCapacityFilled += space
                return "Груз, объемом \(space)л. погружен; Объем свободного места - \(trunkCapacity - trunkCapacityFilled)л."
            }
            
        case .putOut: //Выгрузка
            if space > trunkCapacityFilled {
                return "В багажнике только \(trunkCapacityFilled)л. груза"
            } else {
                trunkCapacityFilled -= space
                return "Груз, объемом \(space)л. выгружен; Объем свободного места - \(trunkCapacity - trunkCapacityFilled)л."
            }
        }
    }
    
    
}



var car = vehicle("audi", "white", 2014, trunk: 100)

car.changeEngineState()
car.changeEngineState()

car.changeWindowsState()

car.changeLightState(changeTo: .normal)
car.changeLightState(changeTo: .distance)

print(car.trunkInOut(need: .putIn, space: 50))
print(car.trunkInOut(need: .putOut, space: 30))

print(car)










