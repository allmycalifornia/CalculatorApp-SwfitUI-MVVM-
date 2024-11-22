//
//  ViewModel.swift
//  Calculator
//
//  Created by Борис Кравченко on 22.11.2024.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var value: String = "0"
    @Published var number: Double = 0.0
    @Published var currentOperation: Operation = .none
    
    // MARK: Property
    let buttonsArray: [[Buttons]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    // MARK: tap buttons methods
    func didTap(item: Buttons) {
        switch item {
        case .plus:
            currentOperation = .addition
            number = Double(value) ?? 0
            value = "0"
        case .minus:
            currentOperation = .substract
            number = Double(value) ?? 0
            value = "0"
        case .multiply:
            currentOperation = .muliply
            number = Double(value) ?? 0
            value = "0"
        case .divide:
            currentOperation = .divide
            number = Double(value) ?? 0
            value = "0"
        case .equal:
            if let currentValue = Double(value) {
                value = formatResult(performOperation(currentValue))
            }
        case .decimal:
            if !value.contains(".") {
                value += "."
            }
        case .negative:
            if let currentValue = Double(value) {
                value = formatResult(-currentValue)
            }
        case .percent:
            if let currentValue = Double(value) {
                value = formatResult(currentValue / 100)
            }
        case .clear:
            value = "0"
        default:
            if value == "0" {
                value = item.rawValue
            } else {
                value += item.rawValue
            }
        }
    }
    
    // MARK: helping calculating methods
    func performOperation(_ currentValue: Double) -> Double {
        switch currentOperation {
        case .addition:
            return number + currentValue
        case .substract:
            return number - currentValue
        case .muliply:
            return number * currentValue
        case .divide:
            return number / currentValue
        default:
            return currentValue
        }
    }
    
    // MARK: remove last zero method
    func formatResult(_ result: Double) -> String {
        return String(format: "%g", result)
    }
    
    // MARK: size of buttons methods
    func buttonWidth(item: Buttons) -> CGFloat {
        let spacing: CGFloat = 12
        let totalSpacing: CGFloat = 5 * spacing
        let zeroTotalSpacing: CGFloat = 4 * spacing
        let totalColumns: CGFloat = 4
        let screenWidth = UIScreen.main.bounds.width
        
        if item == .zero {
            return (screenWidth - zeroTotalSpacing) / totalColumns * 2
        }
        
        return (screenWidth - totalSpacing) / totalColumns
    }
    
    func buttonHeight() -> CGFloat {
        let spacing: CGFloat = 12
        let totalSpacing: CGFloat = 5 * spacing
        let totalColumns: CGFloat = 4
        let screenWidth = UIScreen.main.bounds.width
        
        return (screenWidth - totalSpacing) / totalColumns
    }
}
