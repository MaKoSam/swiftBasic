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
    
    case putInTrailer //Дополнение для Грузовика: Погрузка в прицеп
    case putOutTrailer //Дополнение для Грузовика: Выгрузка из прицепа
}

class Vehicle {
    
    var brand : String //Марка авто
    var color : String //Цвет
    var date : Int //Год производства
    var capacity : Int //Объем багажника
    var usedCapacity : Int //Объем заполненного груза в багажнике
    
    var engineState : CarEngine { //Состояние двигателя с уведомлением при изменении
        willSet {
            if newValue != engineState {
                if newValue == .on {
                    print("Двигатель \(brand) запускается.")
                    if self.lightState == .off {
                        self.changeLightState(to: .normal) //При включении двигателя включается ближний свет фар
                    }
                } else {
                    print("Двигатель \(brand) выключен.")
                    self.changeLightState(to: .off) //При выключении двигателя гаснут фары
                    self.changeWindowsState(to: .close) //При выключении двигателя закрываются окна
                }
            }
        }
    }
    
    var lightState : CarLight { //Состояние света фар с уведомлением при изменении
        willSet {
            if newValue != self.lightState {
                switch newValue {
                case .normal:
                    print("Включен ближний свет фар \(brand).")
                case .distance:
                    print("Включен дальний свет фар \(brand).")
                case .full:
                    print("Включен противотуманный свет фар \(brand).")
                case.off:
                    print("Фары \(brand) выключены.")
                }
            }
        }
    }
    
    var windowsState : CarWindows { //Состояние окон с уведомлением при изменении
        willSet {
            if newValue != windowsState {
                if newValue == .open {
                    print("Окна \(brand) открываются.")
                } else {
                    print("Окна \(brand) закрываются.")
                }
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
    func changeEngineState(to newState: CarEngine){
        if self.engineState == newState {
            if newState == .on {
                print("Двигатель \(brand) уже запущен.")
            } else {
                print("Двигатель \(brand) уже выключен.")
            }
        } else {
            self.engineState = newState
        }
    }
    
    //Метод: открытие и закрытие окон
    func changeWindowsState(to newState: CarWindows){
        self.windowsState = newState
    }
    
    //Метод: изменение состояния света фар
    func changeLightState(to newState: CarLight){
        self.lightState = newState
    }
    
    //Метод: погрузка и выгрузка груза определенного объема
    func cargoTransportation(need action: InOutCargo, space: Int) -> String{
        
        switch action { //Определение действия: Выгрузка / Погрузка
        case .putIn: //Погрузка
            if(space + usedCapacity) > capacity {
                return "Недостаточно свободного места в багажнике \(brand)."
            } else {
                usedCapacity += space
                return "Груз, объемом \(space)л. погружен в \(brand); Объем свободного места - \(capacity - usedCapacity)л."
            }
        case .putOut: //Выгрузка
            if space > usedCapacity {
                return "В багажнике \(brand) только \(usedCapacity)л. груза"
            } else {
                usedCapacity -= space
                return "Груз, объемом \(space)л. выгружен из \(brand); Объем свободного места - \(capacity - usedCapacity)л."
            }
        default:
            return "Действия с прицепом возможны только для Грузовиков."
        }
    }
    
    func printInfo (){
        print("Наименование - ", self.brand)
        print("Цвет - ", self.color)
        print("Год выпуска - ", self.date)
        print("Багажник, обьемом \(capacity)л., заполнен на \(usedCapacity)л.")
        print("Двигатель - ", self.engineState)
        print("Фары - ", self.lightState)
        print("Окна - ", self.windowsState)
    }
    
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

class SportCar : Vehicle {
    
    var spoiler : SportSpoiler { //Спойлер
        willSet {
            if newValue != self.spoiler {
                switch newValue {
                case .down:
                    print("Спойлер \(brand) опущен. Сцепление ухудшено.")
                case .up:
                    print("Спойлер \(brand) поднят. Сцепление улучшено.")
                }
            }
        }
    }
    
    var roof : SportRoof { //Крыша
        willSet {
            if newValue != roof {
                switch newValue {
                case .open:
                    print("Крыша \(brand) полностью опущена.")
                case .halfOpen:
                    print("Крыша \(brand) опущена на половину.")
                case .close:
                    print("Крыша \(brand) поднята")
                }
            }
        }
    }
    
    init(_ brand: String, _ color: String, _ date: Int) {
        self.spoiler = .down
        self.roof = .close
        super.init(brand, color, date, trunk: 0) //У спортивной машины нет багажника
    }
    
    func changeSpoilerState(to newState: SportSpoiler) {
        self.spoiler = newState
    }
    
    func changeRoofState(to newState: SportRoof) {
        self.roof = newState
    }
    
    override func changeEngineState(to newState: CarEngine) {
        //Перегрузка родительской функции
        switch newState {
        case .on: //Быстрый запуск спорт-машины
            super.changeEngineState(to: .on)
            super.changeWindowsState(to: .open)
            self.changeSpoilerState(to: .up)
            self.changeRoofState(to: .open)
        case .off: //Быстрое выключение спорт-машины
            super.changeEngineState(to: .off)
            self.changeSpoilerState(to: .down)
            self.changeRoofState(to: .close)
        }
    }
    
    override func printInfo() {
        print("Информация для Спорт-Кара \(brand)");
        super.printInfo()
        print("Спойлер - ", self.spoiler)
        print("Крыша - ", self.roof)
    }
    
}

class TrunkCar : Vehicle {
    var cargoTrailer : Bool //Есть-ли дополнительный грузовой прицеп
    
    var trailerCapacity : Int //Объем грузового прицепа
    var usedTrailerCapacity : Int //Использованный грузовой объем прицепа
    
    init(_ brand: String, _ color: String, _ date: Int, trunk: Int, trailer: Int) {
        
        usedTrailerCapacity = 0
        if trailer > 0 {
            cargoTrailer = true
            trailerCapacity = trailer;
        } else {
            cargoTrailer = false
            trailerCapacity = 0
        }
        
        super.init(brand, color, date, trunk: trunk)
    }
    
    override func cargoTransportation(need action: InOutCargo, space: Int) -> String {
        //Перегрузка родительской функции
        switch action {
        case .putIn: // -> to super.cargoTrz
            return super.cargoTransportation(need: action, space: space)
        case .putOut: // -> to super.cargoTrz
            return super.cargoTransportation(need: action, space: space)
        case .putInTrailer: // Погрузка груза в карго-прицеп
            if self.cargoTrailer {
                if (space + usedTrailerCapacity) < trailerCapacity {
                    usedTrailerCapacity += space
                    return "Груз, объемом \(space)л. погружен в карго-прицеп \(brand); Объем свободного места в прицепе - \(trailerCapacity - usedTrailerCapacity)л."
                } else {
                    return "Недостаточно места в карго-прицепе \(brand)."
                }
            } else {
                return "Карго-прицеп \(brand) не прикреплен."
            }
        case .putOutTrailer: //Выгрузка груза из карго-прицепа
            if self.cargoTrailer {
                if space > usedTrailerCapacity {
                    return "В карго-прицепе \(brand) недостаточно груза"
                } else {
                    usedTrailerCapacity -= space
                    return "Груз, объемом \(space)л. выгружен из карго-прицепа \(brand); Объем свободного места в прицепе- \(trailerCapacity - usedTrailerCapacity)л."
                }
            } else {
                return "Карго-прицеп \(brand) не прикреплен."
            }
        }
    }
    
    override func printInfo() {
        print("Информация для Грузовика \(brand)")
        super.printInfo()
        
        if cargoTrailer {
            print("Карго-прицеп, обьемом \(trailerCapacity)л., заполнен на \(usedTrailerCapacity)л.")
        } else {
            print("Карго-прицеп не прикреплен.")
        }
    }
}

var AudiTT = SportCar("Audi TT", "White", 2017)

AudiTT.changeEngineState(to: .on)

AudiTT.changeLightState(to: .full)
AudiTT.changeRoofState(to: .close)
AudiTT.changeWindowsState(to: .close)

AudiTT.changeEngineState(to: .off)


var VolvoTrunk = TrunkCar("Volvo", "Black", 2010, trunk: 10, trailer: 70000)

VolvoTrunk.changeEngineState(to: .on)
VolvoTrunk.changeLightState(to: .distance)

print(VolvoTrunk.cargoTransportation(need: .putIn, space: 7))
print(VolvoTrunk.cargoTransportation(need: .putIn, space: 10))
print(VolvoTrunk.cargoTransportation(need: .putOut, space: 9))
print(VolvoTrunk.cargoTransportation(need: .putOut, space: 2))

print(VolvoTrunk.cargoTransportation(need: .putInTrailer, space: 48500))
print(VolvoTrunk.cargoTransportation(need: .putInTrailer, space: 30000))
print(VolvoTrunk.cargoTransportation(need: .putOutTrailer, space: 54000))
print(VolvoTrunk.cargoTransportation(need: .putOutTrailer, space: 15500))

AudiTT.printInfo()
VolvoTrunk.printInfo()
