//
//  Model.swift
//  Calculator
//
//  Created by Борис Кравченко on 22.11.2024.
//

import Foundation
import SwiftUI

enum Buttons: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case plus = "+"
    case minus = "-"
    case multiply = "*"
    case divide = "/"
    case equal = "="
    case decimal = "."
    case negative = "+/-"
    case percent = "%"
    case clear = "AC"
    
    var buttonColor: Color {
        switch self {
        case .clear, .negative, .percent:
            return Color.grayColor
        case .divide, .multiply, .minus, .plus, .equal:
            return Color.orangeColor
        default:
            return Color.darkGrayColor
        }
    }
    
    var buttonFontColor: Color {
        switch self {
        case .clear, .negative, .percent:
            return Color.black
        default:
            return Color.white
        }
    }
}

enum Operation {
    case addition, substract, muliply, divide, none
}
