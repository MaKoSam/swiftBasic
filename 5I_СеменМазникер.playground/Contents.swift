//
//  main.swift
//  Lesson Five Home Work
//
//  Created by Sam Mazniker on 2/12/19.
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

enum cargoAction { //Для метода погрузки/выгрузки груза
    case putIn //Загрузка
    case putOut //Выгрузка
}

enum SportSpoiler { //Спортивная машина может поднимать/опускать спойлер
    case up;
    case down;
}

enum SportRoof { //Спортивная машина может поднимать/опускать крышу
    case open;
    case halfOpen;
    case close;
}

protocol Car { //Протокол для Машин
    func changeEngineState(to newState : CarEngine)
    func changeWindowsState(to newState : CarWindows)
    func changeLightState(to newState : CarLight)
    
}

class SportCar{
    var name : String
    var color : String
    
    var engineState : CarEngine
    var windowsState : CarWindows
    var lightState : CarLight
    
    var spoilerState : SportSpoiler
    var roofState : SportRoof
    
    func changeSpoilerState(to newState: SportSpoiler) {
        if self.spoilerState != newState {
            self.spoilerState = newState
            switch newState {
            case .down:
                print("Спойлер \(name) опущен.")
            case .up:
                print("Спойлер \(name) поднят.")
            }
        }
    }
    
    func changeRoofState(to newState: SportRoof) {
        if self.roofState != newState {
            self.roofState = newState
            switch newState {
            case .open:
                print("Крыша \(name) полностью опущена.")
            case .halfOpen:
                print("Крыша \(name) опущена на половину.")
            case .close:
                print("Крыша \(name) поднята")
            }
        }
    }
    
    init(_ brand: String, _ color: String) {
        self.name = brand
        self.color = color
        
        self.engineState = .off
        self.windowsState = .close
        self.lightState = .off
        
        self.spoilerState = .down
        self.roofState = .close
    }
    
}

extension SportCar : CustomStringConvertible { //Для вывода состояния автомобиля
    var description : String {
        return "Наименование - \(self.name)\nЦвет - \(self.color)\nДвигатель - \(self.engineState)\nФары - \(self.lightState)\nОкна - \(self.windowsState)\nКрыша - \(self.roofState)\nСпойлер - \(self.spoilerState)";
    }
}

extension SportCar : Car { //Расширение класса SportCar с подключением протокола Car
    func changeEngineState(to newState : CarEngine){
        if self.engineState != newState {
            engineState = newState
            switch newState {
            case .on:
                print("Двигатель \(name) включен.")
                changeLightState(to: .normal)
            case .off:
                print("Двигатель \(name) выключен.")
                changeLightState(to: .off)
                changeWindowsState(to: .close)
            }
        }
    }
    
    func changeWindowsState(to newState: CarWindows) {
        if self.windowsState != newState {
            windowsState = newState
            switch newState {
            case .open:
                print("Окна \(name) открываются.")
            case .close:
                print("Окна \(name) закрываются.")
            }
        }
    }
    
    func changeLightState(to newState: CarLight) {
        if self.lightState != newState {
            lightState = newState
            switch newState {
            case .normal:
                print("Включен ближний свет фар \(name).")
            case .distance:
                print("Включен дальний свет фар \(name).")
            case .full:
                print("Включен противотуманный свет фар \(name).")
            case.off:
                print("Фары \(name) выключены.")
            }
        }
    }
    
}

var audiTT : SportCar = SportCar("AudiTT", "White")


audiTT.changeEngineState(to: .on)
audiTT.changeLightState(to: .distance)
audiTT.changeSpoilerState(to: .up)
audiTT.changeEngineState(to: .off)


print(audiTT.description)


class TrunkCar {
    var name : String
    var color : String
    
    var engineState : CarEngine
    var windowsState : CarWindows
    var lightState : CarLight
    
    var capacity : Int
    var usedCapacity : Int
    
    init(_ brand: String, _ color: String, capacity : Int) {
        self.name = brand
        self.color = color
        
        self.engineState = .off
        self.windowsState = .close
        self.lightState = .off
        
        self.capacity = capacity
        self.usedCapacity = 0
    }
    
    func cargoTranzit(need action: cargoAction, space: Int) -> String{
        switch action {
        case .putIn: //Погрузка топлива
            if(space + usedCapacity) > capacity {
                return "Недостаточно свободного пространства в цистерне \(name)."
            } else {
                usedCapacity += space
                return "Топливо, объемом \(space)л. погружено в цистерну \(name); Объем свободного пространства - \(capacity - usedCapacity)л."
            }
        case .putOut: //Выгрузка топлива
            if space > usedCapacity {
                return "В цистерне \(name) только \(usedCapacity)л. топлива"
            } else {
                usedCapacity -= space
                return "Топливо, объемом \(space)л. выгружено из цистерны \(name); Объем свободного пространства - \(capacity - usedCapacity)л."
            }
        }
    }
}

extension TrunkCar : CustomStringConvertible { //Для вывода состояния грузовика
    var description : String {
        return "Наименование - \(self.name)\nЦвет - \(self.color)\nДвигатель - \(self.engineState)\nФары - \(self.lightState)\nОкна - \(self.windowsState)\nЦистерна заполнена на - \(self.usedCapacity)л.\nОбщий объем цистерны - \(self.capacity)л.";
    }
}

extension TrunkCar : Car { //Расширение класса TrunkCar с подключением протокола Car
    func changeEngineState(to newState : CarEngine){
        if self.engineState != newState {
            engineState = newState
            switch newState {
            case .on:
                print("Двигатель \(name) включен.")
                changeLightState(to: .normal)
            case .off:
                print("Двигатель \(name) выключен.")
                changeLightState(to: .off)
                changeWindowsState(to: .close)
            }
        }
    }
    
    func changeWindowsState(to newState: CarWindows) {
        if self.windowsState != newState {
            windowsState = newState
            switch newState {
            case .open:
                print("Окна \(name) открываются.")
            case .close:
                print("Окна \(name) закрываются.")
            }
        }
    }
    
    func changeLightState(to newState: CarLight) {
        if self.lightState != newState {
            lightState = newState
            switch newState {
            case .normal:
                print("Включен ближний свет фар \(name).")
            case .distance:
                print("Включен дальний свет фар \(name).")
            case .full:
                print("Включен противотуманный свет фар \(name).")
            case.off:
                print("Фары \(name) выключены.")
            }
        }
    }
    
}

var VolvoTrunk : TrunkCar = TrunkCar("Volvo FF", "Blue", capacity: 10000)

VolvoTrunk.changeEngineState(to: .on)
VolvoTrunk.changeLightState(to: .full)
VolvoTrunk.changeEngineState(to: .off)

print(VolvoTrunk.cargoTranzit(need: .putIn, space: 10000))
print(VolvoTrunk.cargoTranzit(need: .putOut, space: 5000))

print(VolvoTrunk.description)


