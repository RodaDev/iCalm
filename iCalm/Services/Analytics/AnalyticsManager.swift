//
//  AnalyticsManager.swift
//  Просто Дыши
//
//  Created by Dmitry Sharygin on 02.01.2025.
//

import Foundation

protocol AnalyticsManager: AnyObject {
    func trackEvent(_ event: Event)
}

struct Event {
    let name: String
    let properties: [String: Any]?
}
