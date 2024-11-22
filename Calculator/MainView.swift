//
//  MainView.swift
//  Calculator
//
//  Created by Борис Кравченко on 22.11.2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            // MARK: Background
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                // MARK: Display
                Spacer()
                displayView
                
                // MARK: Buttons
                buttonsGrid
            }
            .padding(.bottom)
        }
    }
    
    // Вынесенное отображение строки
    private var displayView: some View {
        HStack {
            Spacer()
            Text(viewModel.value)
                .foregroundStyle(.white)
                .font(.system(size: 90, weight: .light))
                .lineLimit(1)
                .minimumScaleFactor(0.3)
                .padding(.horizontal, 28)
        }
    }
    
    // Вынесенная сетка кнопок
    private var buttonsGrid: some View {
        ForEach(viewModel.buttonsArray, id: \.self) { row in
            HStack(spacing: 12) {
                ForEach(row, id: \.self) { item in
                    buttonView(for: item)
                }
            }
        }
    }
    
    // Вынесенная кнопка
    private func buttonView(for item: Buttons) -> some View {
        Button {
            viewModel.didTap(item: item)
        } label: {
            Text(item.rawValue)
                .frame(
                    width: viewModel.buttonSize(for: item).width,
                    height: viewModel.buttonSize(for: item).height
                )
                .foregroundStyle(item.buttonFontColor)
                .background(item.buttonColor)
                .font(.system(size: 35))
                .cornerRadius(viewModel.buttonSize(for: item).width / 2)
        }
    }
}

// Preview
#Preview {
    MainView()
        .environmentObject(ViewModel())
}
