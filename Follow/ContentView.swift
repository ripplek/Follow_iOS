//
//  ContentView.swift
//  Follow
//
//  Created by 张坤 on 2020/8/4.
//  Copyright © 2020 张坤. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // MARK: Constants
    
    let row: [CalculatorButtonItem] = [.digit(1), .digit(2), .digit(3), .op(.plus)]
    
    var body: some View {
        
        HStack {
            CalculatorButtonRow(row: [.digit(0), .dot, .op(.equal)])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CalculatorButton: View {
    let fontSize: CGFloat = 38
    let title: String
    let size: CGSize
    let backgroundColorName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: fontSize))
                .foregroundColor(.white)
                .frame(width: size.width, height: size.height)
                .background(Color(backgroundColorName))
                .cornerRadius(size.width / 2)
        }
    }
}

struct CalculatorButtonRow: View {
    let row: [CalculatorButtonItem]
    
    var body: some View {
        ForEach(row, id: \.self) { item in
            CalculatorButton(
                title: item.title,
                size: item.size,
                backgroundColorName: item.backgroundColorName) {
                    print(item.title)
            }
        }
    }
}
