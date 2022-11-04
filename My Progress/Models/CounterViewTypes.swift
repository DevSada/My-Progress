//
//  CounterTypes.swift
//  My Progress
//
//  Created by Alexander Petrenko on 31.10.2022.
//

import UIKit

enum CounterViewTypes {
    case add
    case edit
    case show
    case cell
}

enum CountdownTimeStacks {
    case start
    case end
}

let circleColor = UIColor.systemPink.cgColor //CGColor(red: 231, green: 87, blue: 67, alpha: 1)
let bgItemColor = UIColor(red: 239, green: 239, blue: 239, alpha: 1)
let accentColor = UIColor(cgColor: CGColor(red: 79, green: 8, blue: 35, alpha: 1))

let standartFont = UIFont.init(name: AppFontName.regular, size: 15)
let labelFont = UIFont.init(name: AppFontName.bold, size: 18)


let labelAttributes = [
    NSAttributedString.Key.font : UIFont.init(name: AppFontName.bold, size: 18),
    NSAttributedString.Key.foregroundColor : UIColor.green
]

let timeLabelAttributes = [
    NSAttributedString.Key.font : UIFont.init(name: AppFontName.bold, size: 15),
    NSAttributedString.Key.foregroundColor : UIColor.lightGray
    ]

let headerAttributes = [
    NSAttributedString.Key.font : UIFont.init(name: AppFontName.bold, size: 24),
    NSAttributedString.Key.foregroundColor : UIColor.gray
]

let sublineAttributes = [
    NSAttributedString.Key.font : UIFont.init(name: AppFontName.bold, size: 13),
    NSAttributedString.Key.foregroundColor : UIColor.green
]


struct AppFontName {
    static let regular = "CourierNewPSMT"
    static let bold = "CourierNewPS-BoldMT"
    static let italic = "CourierNewPS-ItalicMT"
}
