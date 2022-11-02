//
//  UsersProgress.swift
//  My Progress
//
//  Created by Alexander Petrenko on 31.10.2022.
//

import Foundation

// MARK: - UsersProgress
struct UsersProgress: Codable {
    let users: [User]
}

// MARK: - User
struct User: Codable {
    let userID: String
    let progressDates: [ProgressDate]

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case progressDates
    }
}

// MARK: - ProgressDate
struct ProgressDate: Codable {
    let startDate, finishDate: String
}

struct test: Codable {
    
}
