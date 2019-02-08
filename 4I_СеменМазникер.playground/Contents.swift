//
//  main.swift
//  Lesson Four Home Work
//
//  Created by Sam Mazniker on 2/8/19.
//  Copyright © 2019 Sam Mazniker. All rights reserved.
//

import Foundation
import UIKit

enum CarEngine { //Состояние двигателя
    case on
    case off
}

enum CarLight { //Состояние фар
    case normal //Ближний свет включен
    case distance //Дальний свет включен
    case full //Противотуманный свет включен
    case off //Свет выключен
}

enum CarWindows { //Состояние окон
    case open
    case close
}

enum InOutCargo { //Для метода погрузки/выгрузки груза из багажника
    case putIn //Загрузка
    case putOut //Выгрузка
}

class Vehicle {
    var brand : String //Марка авто
    var color : String //Цвет
    var date : Int //Год производства
    var capacity : Int //Объем багажника
    var usedCapacity : Int //Объем заполненного груза в багажнике
    
    var engineState : CarEngine { //Состояние двигателя с уведомлением при изменении
        willSet {
            if newValue == .on {
                print("Двигатель запускается.")
                self.changeLightState(to: .normal) //При включении двигателя включается ближний свет фар
            } else {
                print("Двигатель выключен.")
                self.changeLightState(to: .off) //При выключении двигателя гаснут фары
                self.changeWindowsState(to: .close) //При выключении двигателя закрываются окна
            }
        }
    }
    
    var lightState : CarLight { //Состояние света фар с уведомлением при изменении
        willSet {
            if newValue == .normal {
                print("Включен ближний свет фар.")
            } else if newValue == .distance {
                print("Включен дальний свет фар.")
            } else if newValue == .full {
                print("Включен противотуманный свет фар.")
            } else {
                print("Фары выключены.")
            }
        }
    }
    
    var windowsState : CarWindows { //Состояние окон с уведомлением при изменении
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
        self.date = date
        self.capacity = trunk
        self.usedCapacity = 0
        self.engineState = .off
        self.lightState = .off
        self.windowsState = .close
    }
    
    //Метод: запуск и остановка двигателя
    func changeEngineState(to state: CarEngine){
        if self.engineState == state {
            if state == .on {
                print("Двигатель уже запущен.")
            } else {
                print("Двигатель уже выключен.")
            }
        } else {
            self.engineState = state
        }
    }
    
    //Метод: открытие и закрытие окон
    func changeWindowsState(to state: CarWindows){
        self.windowsState = state
    }
    
    //Метод: изменение состояния света фар
    func changeLightState(to state: CarLight){
        self.lightState = state
    }
    
    
    
    
    //Метод: погрузка и выгрузка груза определенного объема
    func cargoTransportation(need mass: InOutCargo, space: Int) -> String{
        switch mass { //Определение действия: Выгрузка / Погрузка
            
        case .putIn: //Погрузка
            if(space + usedCapacity) > capacity {
                return "Недостаточно свободного места в багажнике"
            } else {
                usedCapacity += space
                return "Груз, объемом \(space)л. погружен; Объем свободного места - \(capacity - usedCapacity)л."
            }
            
        case .putOut: //Выгрузка
            if space > usedCapacity {
                return "В багажнике только \(usedCapacity)л. груза"
            } else {
                usedCapacity -= space
                return "Груз, объемом \(space)л. выгружен; Объем свободного места - \(capacity - usedCapacity)л."
            }
        }
    }
    
}






