//
//  calendarTransletsEnums.swift
//  ToDoList
//
//  Created by Артур Миннушин on 06.09.2024.
//

import Foundation

enum DayOfWeek: String {
    case sunday = "Sunday"
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
}

enum MounthOfYear: String {
    case january = "January"
    case february = "February"
    case march = "March"
    case april = "April"
    case may = "May"
    case june = "June"
    case july = "July"
    case august = "August"
    case september = "September"
    case october = "October"
    case november = "November"
    case december = "December"
}

class DateManager {
    static let shared = DateManager()
    
    func translateWeakDayName(weakDay: String) -> String {
        var dayName: String?
        if let dayOfWeek = DayOfWeek(rawValue: weakDay) {
            switch dayOfWeek {
            case .sunday:
                dayName = "Воскресенье"
            case .monday:
                dayName = "Понедельник"
            case .tuesday:
                dayName = "Вторник"
            case .wednesday:
                dayName = "Среда"
            case .thursday:
                dayName = "Четверг"
            case .friday:
                dayName = "Пятница"
            case .saturday:
                dayName = "Суббота"
            }
        }
        return dayName ?? ""
    }
    
    func translateMounthYearName(yearMounth: String) -> String {
        var mounthName: String?
        if let mounthOfYear = MounthOfYear(rawValue: yearMounth) {
            switch mounthOfYear {
            case.january:
                mounthName = "Января"
            case.february:
                mounthName = "Февраля"
            case.march:
                mounthName = "Марта"
            case.april:
                mounthName = "Апреля"
            case.may:
                mounthName = "Мая"
            case.june:
                mounthName = "Июня"
            case.july:
                mounthName = "Июля"
            case.august:
                mounthName = "Августа"
            case.september:
                mounthName = "Сентября"
            case.october:
                mounthName = "Октября"
            case.november:
                mounthName = "Ноября"
            case.december:
                mounthName = "Декабря"
            }
        }
        return mounthName ?? ""
    }
    
    func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        let numberOfDay = Calendar.current.dateComponents([.weekday], from: Date()).weekday
        var dayName: String?
        var mounthName: String?
        
        dateFormatter.dateFormat = "EEEE"
        dayName = translateWeakDayName(weakDay: dateFormatter.string(from: Date()).capitalized)
        
        dateFormatter.dateFormat = "MMMM"
        mounthName = translateMounthYearName(yearMounth: dateFormatter.string(from: Date()).capitalized)
        
        return "\(dayName!), \(numberOfDay!) \(mounthName!)"
    }
}

