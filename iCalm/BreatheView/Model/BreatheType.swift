//
//  BreatheType.swift
//  iCalm
//
//  Created by Rodevelop on 01.10.2022.
//

import Foundation
import SwiftUI

struct BreatheProgram: Identifiable {
    var id = UUID().uuidString
    var title: String
    var stages: [BreatheStage]
    var laps: Int
    var image: String
    
    init(title: String, stages: [BreatheStage], laps: Int, image: String) {
        self.title = title
        self.laps = laps
        self.image = image
        var allStages = [BreatheStage]()
        for _ in 0 ..< laps {
            allStages.append(contentsOf: stages)
        }
        self.stages = allStages
    }
}

class BreatheStage: ObservableObject {
    var type: BreatheType
    var interval: Int
    var source: BreatheSource?
    
    init(type: BreatheType, interval: Int, source: BreatheSource? = nil) {
        self.interval = interval
        self.type = type
        self.source = source
    }
    
    func getTitle() -> String {
        switch type {
        case.wait :
            return String(localized: "GetReady.key")
        case .outPause, .inPause:
            return String(localized: "Pause.key")
        case .breatheIn:
            return String(localized: "Inhale.key")
        case .breatheOut:
            return String(localized: "Exhale.key")
        case .stop:
            return ""
        }
    }
    
    func getImage() -> Image? {
        if type == .inPause || type == .outPause {
            return Image(sfSymbol: "pause")
        }
        switch source {
        case .mouth:
            return Image(sfSymbol: "mouth")
        case .nose:
            return Image(sfSymbol: "nose")
        default:
            return nil
        }
    }
}

enum BreatheType: String {
    case wait
    case stop
    case breatheIn
    case breatheOut
    case inPause
    case outPause
}

enum BreatheSource {
    case mouth
    case nose
}

struct BreatheModel: Identifiable {
    var id = UUID().uuidString
    var program: BreatheProgram
    let colorStart: Color
    let colorEnd: Color
}
