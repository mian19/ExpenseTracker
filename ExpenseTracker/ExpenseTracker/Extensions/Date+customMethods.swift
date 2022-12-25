//
//  Date+customMethods.swift
//  BirthdayReminder
//
//  Created by Kyzu on 18.12.22.
//

import Foundation

extension Date {
    
    static func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}
        return localDate
    }
    
    static func differenceInDays(from: Date, to: Date) -> Int {
        var currentDate: Calendar = Calendar.current
        currentDate.timeZone = TimeZone(secondsFromGMT: 0)!
        return currentDate.dateComponents([.hour], from: from, to: to).hour ?? 100
    }
    
    func localTimezone() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: self) else {return Date()}
        return localDate
    }
    

    func dateForBTC() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yy HH:mm"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    let stringDate = (formatter.string(from: self))
    return stringDate
    }
   
    
    static func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return (formatter.string(from: date))
    }
}
