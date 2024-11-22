//
//  MainView.swift
//  Calculator
//
//  Created by Борис Кравченко on 22.11.2024.
//

import SwiftUI

struct MainView: View {
    
    // MARK: Property
    let buttonsArray: [[Buttons]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack{
            // MARK: Background
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 12){
                
                // MARK: Display
                Spacer()
                HStack {
                    Spacer()
                    Text("0")
                        .foregroundStyle(.white)
                        .font(.system(size: 90, weight: .light))
                        .padding(.horizontal, 28)
                }
                
                // MARK: Buttons
                ForEach(buttonsArray, id: \.self) { row in
                    HStack(spacing: 12){
                        ForEach(row, id: \.self) { item in
                            Button {
                                //action
                            } label: {
                                Text(item.rawValue)
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight())
                                    .foregroundStyle(item.buttonFontColor)
                                    .background(item.buttonColor)
                                    .font(.system(size: 35))
                                    .cornerRadius(40)
                            }
                        }
                    }
                }
            }
            .padding(.bottom)
        }
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

#Preview {
    MainView()
}
