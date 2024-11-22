//
//  ViewModel.swift
//  Calculator
//
//  Created by Борис Кравченко on 22.11.2024.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var value: String = "0" // Отображаемая строка
    @Published private var currentOperation: Operation = .none
    private var number: Double = 0.0   // Первое число
    private var isNewCalculation: Bool = true // Флаг для начала нового вычисления

    // MARK: Buttons Layout
    let buttonsArray: [[Buttons]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    // MARK: - User Interaction
    func didTap(item: Buttons) {
        switch item {
        case .plus, .minus, .multiply, .divide:
            handleOperation(item)
        case .equal:
            calculateResult()
        case .decimal:
            addDecimal()
        case .negative:
            toggleSign()
        case .percent:
            applyPercent()
        case .clear:
            resetCalculator()
        default:
            appendNumber(item.rawValue)
        }
    }
    
    // MARK: - Private Methods
    
    /// Обработка математической операции.
    private func handleOperation(_ item: Buttons) {
        if currentOperation == .none {
            number = Double(value) ?? 0 // Сохраняем первое число
        } else {
            // Если операция уже выбрана, сразу производим вычисление
            calculateResult()
        }
        currentOperation = operation(from: item)
        value += " \(item.rawValue) " // Добавляем операцию в строку
        isNewCalculation = false
    }
    
    /// Выполняет вычисление результата.
    private func calculateResult() {
        let components = value.split(separator: " ")
        guard components.count >= 3,
              let firstValue = Double(components[0]),
              let operation = components[1].first,
              let secondValue = Double(components[2]) else { return }
        
        let result: Double
        switch operation {
        case "+":
            result = firstValue + secondValue
        case "-":
            result = firstValue - secondValue
        case "*":
            result = firstValue * secondValue
        case "/":
            result = secondValue == 0 ? Double.nan : firstValue / secondValue
        default:
            return
        }
        
        value = formatResult(result) // Обновляем строку с результатом
        currentOperation = .none
        isNewCalculation = true
    }
    
    /// Добавляет десятичную точку, если она еще не добавлена.
    private func addDecimal() {
        if let lastComponent = value.split(separator: " ").last,
           !lastComponent.contains(".") {
            value += "."
        }
    }
    
    /// Переключает знак последнего числа.
    private func toggleSign() {
        if let lastComponent = value.split(separator: " ").last,
           let currentValue = Double(lastComponent) {
            value = value.replacingOccurrences(of: lastComponent, with: formatResult(-currentValue))
        }
    }
    
    /// Применяет операцию процентов к последнему числу.
    private func applyPercent() {
        if let lastComponent = value.split(separator: " ").last,
           let currentValue = Double(lastComponent) {
            value = value.replacingOccurrences(of: lastComponent, with: formatResult(currentValue / 100))
        }
    }
    
    /// Сбрасывает все значения калькулятора.
    private func resetCalculator() {
        value = "0"
        number = 0.0
        currentOperation = .none
        isNewCalculation = true
    }
    
    /// Добавляет число к текущему значению.
    private func appendNumber(_ number: String) {
        if isNewCalculation {
            value = number
            isNewCalculation = false
        } else if let lastComponent = value.split(separator: " ").last,
                  lastComponent == "0" {
            value = value.dropLast() + number
        } else {
            value += number
        }
    }
    
    // MARK: - Operations Logic
    
    /// Преобразует кнопку в соответствующую операцию.
    private func operation(from item: Buttons) -> Operation {
        switch item {
        case .plus: return .addition
        case .minus: return .substract
        case .multiply: return .muliply
        case .divide: return .divide
        default: return .none
        }
    }
    
    // MARK: - Formatting
    
    /// Форматирует результат, удаляя лишние нули и обрабатывая ошибки.
    private func formatResult(_ result: Double) -> String {
        guard !result.isNaN else { return "Ошибка" }
        return String(format: "%g", result)
    }
    
    // MARK: - Button Sizing
    func buttonSize(for item: Buttons) -> CGSize {
        let spacing: CGFloat = 12
        let totalSpacing: CGFloat = 5 * spacing
        let totalColumns: CGFloat = 4
        let screenWidth = UIScreen.main.bounds.width
        
        let standardWidth = (screenWidth - totalSpacing) / totalColumns
        
        // Для кнопки "0" ширина в два раза больше
        if item == .zero {
            return CGSize(width: standardWidth * 2 + spacing, height: standardWidth)
        }
        
        return CGSize(width: standardWidth, height: standardWidth)
    }
}
