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
    
}

extension Time {
    
    static func getProgress() -> [Time] {
        return [
        Time(startDate: "2022/10/28 12:00", finishDate: "2022/10/29 14:00"),
        Time(startDate: "2022/09/28 12:00", finishDate: "2022/11/08 12:00"),
        Time(startDate: "2022/10/27 12:00", finishDate: "2022/10/28 12:00"),
        Time(startDate: "2022/08/28 12:00", finishDate: "2022/10/30 12:00"),
        Time(startDate: "2022/09/28 12:00", finishDate: "2022/11/28 12:00"),
        Time(startDate: "2022/10/28 12:00", finishDate: "2022/10/28 12:03"), // check minutes less 4!
        Time(startDate: "2022/02/28 12:00", finishDate: "2022/12/28 12:01")
        ]
    }
    
    
    
    
}
