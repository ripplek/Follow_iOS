//
//  CalculatorModel.swift
//  Follow
//
//  Created by 张坤 on 2020/8/26.
//  Copyright © 2020 张坤. All rights reserved.
//

import SwiftUI
import Combine

class CalculatorModel: ObservableObject {
    @Published var history: [CalculatorButtonItem] = []
    @Published var brain: CalculatorBrain = .left("0")
    
    var temporaryKept: [CalculatorButtonItem] = []
    
    func apply(_ item: CalculatorButtonItem) {
        brain = brain.apply(item: item)
        history.append(item)
        
        temporaryKept.removeAll()
        slidingIndex = Float(totalCount)
    }
    
    var historyDetail: String {
        history.map { $0.description }.joined()
    }

    func keepHistory(upTo index: Int) {
        precondition(index <= totalCount, "Out of index.")

        let total = history + temporaryKept

        history = Array(total[..<index])
        temporaryKept = Array(total[index...])

        brain = history.reduce(CalculatorBrain.left("0")) {
            result, item in
            result.apply(item: item)
        }
    }

    var totalCount: Int {
        history.count + temporaryKept.count
    }

    var slidingIndex: Float = 0 {
        didSet {
            keepHistory(upTo: Int(slidingIndex))
        }
    }
}
