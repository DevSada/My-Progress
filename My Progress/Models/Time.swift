//
//  Time.swift
//  My Progress
//
//  Created by Alexander Petrenko on 28.10.2022.
//

import UIKit

import Foundation

struct Time {
    
    let startDate: String
    let finishDate: String
    
    static func getDateFromString(date: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.date(from: date)!
    }
    
    static func getSecondsTillFinish(progress: Time) -> Int {
        return  Int(getDateFromString(date: progress.finishDate).timeIntervalSinceNow)
    }
    
    static func getSecondsBetweenStartFinish(progress: Time) -> Int {
        return Int(getDateFromString(date: progress.finishDate).timeIntervalSince(getDateFromString(date: progress.startDate)))
    }
    
    static func getDateTillFinish(progress: Time) -> String {
        let seconds = Int(getDateFromString(date: progress.finishDate).timeIntervalSinceNow)
        var dateTillFinish = ""
        if ((seconds % 31536000) / 86400) != 0 { dateTillFinish = "Days: \((seconds % 31536000) / 86400) " }
        if ((seconds % 86400) / 3600) != 0 { dateTillFinish += "Hours: \((seconds % 86400) / 3600) " }
        if ((seconds % 3600) / 60) != 0 {  dateTillFinish += "Minutes: \((seconds % 3600) / 60) " }
        dateTillFinish += "Seconds: \(seconds % 60)"
        
        return dateTillFinish
    }
    
}

extension Time {
    
    static func getProgress() -> [Time] {
        return [
        Time(startDate: "2022/10/28 12:00", finishDate: "2022/10/29 14:00"),
        Time(startDate: "2022/09/28 12:00", finishDate: "2022/11/08 12:00"),
        Time(startDate: "2022/10/27 12:00", finishDate: "2022/10/28 12:00"),
        Time(startDate: "2022/08/28 12:00", finishDate: "2022/10/30 12:00"),
        Time(startDate: "2022/09/28 12:00", finishDate: "2022/11/28 12:00"),
        Time(startDate: "2022/10/28 12:00", finishDate: "2022/10/28 12:00"),
        Time(startDate: "2022/02/28 12:00", finishDate: "2022/12/28 12:00")
        ]
    }
    
}
