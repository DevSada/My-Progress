//
//  Time.swift
//  My Progress
//
//  Created by Alexander Petrenko on 28.10.2022.
//

import UIKit

import Foundation

struct Time {
    
    let progressID: Int
    let userID: Int
    let startDate: String
    let finishDate: String
    let goal: String
    let subGoal: String
    
}

extension Time {
    
    static func getProgress() -> [Time] {
        return [
            Time(progressID: 1, userID: 1, startDate: "2022/10/28 12:00", finishDate: "2022/10/29 14:00", goal: "My First Goal", subGoal: "This goal need me for my inspiration"),
            Time(progressID: 2, userID: 1, startDate: "2022/09/28 12:00", finishDate: "2022/11/08 12:00", goal: "My First Goal", subGoal: "This goal need me for my inspiration"),
            Time(progressID: 3, userID: 1, startDate: "2022/10/27 12:00", finishDate: "2022/10/28 12:00", goal: "My First Goal", subGoal: "This goal need me for my inspiration"),
            Time(progressID: 4, userID: 1, startDate: "2022/08/28 12:00", finishDate: "2022/10/30 12:00", goal: "My First Goal", subGoal: "This goal need me for my inspiration"),
            Time(progressID: 5, userID: 1, startDate: "2022/09/28 12:00", finishDate: "2022/11/28 12:00", goal: "My First Goal", subGoal: "This goal need me for my inspiration"),
            Time(progressID: 6, userID: 1, startDate: "2022/10/28 12:00", finishDate: "2022/10/28 12:03", goal: "My First Goal", subGoal: "This goal need me for my inspiration"), // check minutes less 4!
            Time(progressID: 7, userID: 1, startDate: "2022/02/28 12:00", finishDate: "2022/12/28 12:01", goal: "My First Goal", subGoal: "This goal need me for my inspiration")
        ]
    }
    
    
    
    
}
