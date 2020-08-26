//
//  ContentView.swift
//  Follow
//
//  Created by 张坤 on 2020/8/4.
//  Copyright © 2020 张坤. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    // MARK: Constants
//    @State private var brain = CalculatorBrain.left("0")
    @EnvironmentObject var model: CalculatorModel
    @State private var editingHistory = false
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 12) {
            Spacer()
            Button("操作历史: \(model.history.count)") {
                self.editingHistory = true
            }
            .sheet(isPresented: $editingHistory, content: { HistoryView(model: self.model) })
            
            Text(model.brain.output)
                .font(.system(size: 76))
                .minimumScaleFactor(0.5)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                .lineLimit(1)
            
            CalculatorButtonPadView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//        Group {
//            ContentView()
//            ContentView()
//                .previewDevice("iPhone SE")
//        }
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
//    @Binding var brain: CalculatorBrain
    @EnvironmentObject var model: CalculatorModel
    let row: [CalculatorButtonItem]
    
    var body: some View {
        HStack {
            ForEach(row, id: \.self) { item in
                CalculatorButton(
                    title: item.title,
                    size: item.size,
                    backgroundColorName: item.backgroundColorName) {
                        self.model.apply(item)
                        print(item.title)
                }
            }
        }
    }
}

struct CalculatorButtonPadView: View {
//    @Binding var brain: CalculatorBrain
//    var model: CalculatorModel
    let pad: [[CalculatorButtonItem]] = [
        [.command(.clear), .command(.flip), .command(.percent), .op(.divide)],
        [.digit(7), .digit(8), .digit(9), .op(.multiply)],
        [.digit(4), .digit(5), .digit(6), .op(.minus)],
        [.digit(1), .digit(2), .digit(3), .op(.plus)],
        [.digit(0), .dot, .op(.equal)],
    ]
    var body: some View {
        VStack(spacing: 8) {
            ForEach(pad, id: \.self) { row in
                CalculatorButtonRow(row: row)
            }
        }
    }
}

struct HistoryView: View {
    @ObservedObject var model: CalculatorModel
    
    var body: some View {
        VStack {
            if model.history.count == 0 {
                Text("没有历史")
            } else {
                HStack {
                    Text("历史").font(.headline)
                    Text(model.historyDetail).lineLimit(1)
                }
                HStack {
                    Text("显示").font(.headline)
                    Text(model.brain.output)
                }
            }
            Slider(value: $model.slidingIndex, in: 0...Float(model.totalCount), step: 1)
        }
    }
}
