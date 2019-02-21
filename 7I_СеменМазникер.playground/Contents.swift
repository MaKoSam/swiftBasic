//
//  main.swift
//  Lesson Seven Home Work
//
//  Created by Sam Mazniker on 2/21/19.
//  Copyright © 2019 Sam Mazniker. All rights reserved.
//

import Foundation
import UIKit

enum StudentError : Error {
    case reachedMaxAvailableClasses //Студент не может брать еще курсы
    case notEnoughMoney (needMore : Int) //У студента не хватает денег на новый курс
}

enum UniversityError : Error {
    case noSuchStudent //В базе института нет такого студента
    case reachedMaxAvailableStudents //Институт не может больше принимать новых студентов
}

class Student : CustomStringConvertible {
    var age : Int //Возраст
    var timeTable : Int //Кол-во посещаемых уроков
    var money : Int //Деньги студента на обучение
    var description: String {
        return "Возраст - \(age)\nКол-во курсов - \(timeTable)\nОстаток денег - \(money)р."
    }
    
    init (_ age : Int, _ classes : Int, _ money : Int){
        self.age = age
        self.timeTable = classes
        self.money = money
    }
}

class University {
    var maxClasses = 5 //Максимум курсов на студента
    var maxStudents = 4 //Максимум студентов на институт
    private var dataBase = [
        "Andrew" : Student(19, 0, 0),
        "Mary" : Student(22, 4, 1000),
        "Viktor" : Student(54, 3, 200),
        "Vasily" : Student(20, 3, 100)
    ]
    
    func addStudent(name: String, _ student: Student) throws { //Зачисление студента
        guard dataBase.count < maxStudents else {
            throw UniversityError.reachedMaxAvailableStudents
        }
        
        guard student.timeTable < maxClasses else {
            throw StudentError.reachedMaxAvailableClasses
        }
        
        dataBase.updateValue(student, forKey: name) //Добавляем студента
    }
    
    func getInfo(name: String) throws -> Student{ //Получение информации о студенте
        guard let student = dataBase[name] else {
            throw UniversityError.noSuchStudent
        }
        return student
    }
    
    func addClass(forStudent name: String, class price: Int) throws { //Добавление нового курса для студента
        guard let student = dataBase[name] else {
            throw UniversityError.noSuchStudent
        }
        
        guard student.timeTable < maxClasses else {
            throw StudentError.reachedMaxAvailableClasses
        }
        
        guard student.money >= price else {
            throw StudentError.notEnoughMoney(needMore: price - student.money)
        }
        
        student.timeTable += 1
        student.money -= price
    }
}

var GeekBrains = University()

do {
    try GeekBrains.addStudent(name: "Vanya", Student(19, 3, 10))
} catch UniversityError.reachedMaxAvailableStudents {
    print("Университет GeekBrains переполнен и не может принимать новых студентов.")
} catch StudentError.reachedMaxAvailableClasses {
    print("Cтудент выбрал слишком много курсов; Максимум курсов = \(GeekBrains.maxClasses)")
}

do {
    try print("Mary:", GeekBrains.getInfo(name: "Mary"))
} catch UniversityError.noSuchStudent {
    print("В университете нет такого студента.")
}

do{
    try GeekBrains.addClass(forStudent: "Mary", class: 1500)
} catch UniversityError.noSuchStudent {
    print("В университете нет такого студента.")
} catch StudentError.reachedMaxAvailableClasses {
    print("Cтудент выбрал слишком много курсов; Максимум курсов = \(GeekBrains.maxClasses)")
} catch StudentError.notEnoughMoney(let needed) {
    print("Недостаточно средств для оплаты курса. Нужно еще \(needed)р.")
}
