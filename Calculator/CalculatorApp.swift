//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Борис Кравченко on 22.11.2024.
//

import SwiftUI

@main
struct CalculatorApp: App {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
        }
    }
}
