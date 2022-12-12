//
//  BreatheType.swift
//  iCalm
//
//  Created by Rodevelop on 01.10.2022.
//

import Foundation
import SwiftUI

struct BreatheProgram: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var color: Color
    var stages: [BreatheStage]
    var laps: Int
}

class BreatheStage: ObservableObject {
    var type: BreatheType
    var interval: Double
    
    init(type: BreatheType, interval: Double) {
        self.interval = interval
        self.type = type
    }
}

enum BreatheType: String {
    case breatheIn
    case breatheOut
    case pause
}

