//
//  DataManager.swift
//  My Progress
//
//  Created by Alexander Petrenko on 31.10.2022.
//

import Foundation

struct DataManager {
    
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
    
    
    func getProgressData(){

        let urlString = "https://github.com/DevSada/My-Progress/blob/main/My%20Progress/Resources/UsersProgress.json"//https://drive.google.com/file/d/1_dKjoaA7BoWnNDXsi0tiCDQBbEfll8pI"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                self.parseJSON(withData: data)
            }
        }
        task.resume()
    }
    
    func updateProgressData(for progressId: Int) {
        
    }
    
    func addNewProgressData() {
        
    }


    func parseJSON(withData data: Data) {
        let decoder = JSONDecoder()
        do {
            let usersProgress = try decoder.decode(UsersProgress.self, from: data)
            print(usersProgress.users[0].progressDates[0])
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
}
