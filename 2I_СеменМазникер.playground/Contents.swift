//
//  main.swift
//  Lesson Two Home Work
//
//  Created by Sam Mazniker on 2/1/19.
//  Copyright © 2019 Sam Mazniker. All rights reserved.
//

import Foundation
import UIKit

//Проверка на четность
func isEven (num : Int) -> Bool {
    if num % 2 == 0 {
        return true
    }
    return false;
}

//Проверка на деление 3 без остатка
func devByThree(num : Int) -> Bool {
    if num % 3 == 0 {
        return true
    }
    return false
}

//Выведение результатов 1-2 вопроса
print(isEven(num: 10))
print(devByThree(num: 10))


//Создание массива а и заполнение его
var a = [Int]()
for index in 0...99 {
    a.append(index)
}

//Выведение результата 3 вопроса
print(a)


//Обратная функция, созданная для фильтрации массива
func reversedIsEven(num : Int) -> Bool {
    return !(isEven(num: num))
}

//Фильтрация массива а на четные числа и числа, кратные 3м
a = a.filter(reversedIsEven)
a = a.filter(devByThree)

//Выведение результата 4 вопроса
print(a)


//Дополнительное задания 5

let module = 1e16

//Объявление массива b для чисел Фибоначчи и объявление первых двух эл-тов
var b = [Int64]()
b.append(1)
b.append(1)

//Функция, определяющая след. число Фибоначчи
func fib (firstNum : Int64, secondNum : Int64) -> Int64 {
    //Числа берутся по модулю 1e16, чтобы избежать переполнения Int64
    return (firstNum + secondNum) % Int64(module)
}

//Цикл на заполнение 100 элементов массива
for index in 2...99 {
    b.append(fib(firstNum: b[index - 1], secondNum: b[index - 2]))
}

//Вывод результата
print(b)


//Дополнительное задание 6

//Создание массива простых чисел
var c = [Int]()

var index = 1

//Функция, определяющая простое число или нет
func isPrime(num : Int) -> Bool {
    for i in 2...num{
        //Перебор всех чисел, больших, чем корень - нецелесообразен
        if i > Int(sqrt(Double(num))){
            break
        }
        if num % i == 0{
            return false
        }
    }
    return true
}

//Поиск простых чисел, пока размер массива не станет равным 100
while c.count < 100 {
    index += 1
    if(isPrime(num: index)){
        c.append(index)
    }
}

//Вывод результата
print(c)
