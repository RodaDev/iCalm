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
    var items: [ProgramItem]
    var laps: Int
}

struct ProgramItem {
    var type: BreatheType
    var interval: Double
}

enum BreatheType: String {
    case breatheIn
    case breatheOut
}

