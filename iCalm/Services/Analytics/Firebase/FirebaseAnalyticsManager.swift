//
//  FirebaseAnalyticsManager.swift
//  Просто Дыши
//
//  Created by Dmitry Sharygin on 02.01.2025.
//

import Foundation
import FirebaseAnalytics
import FirebaseAnalyticsSwift

final class FirebaseAnalyticsManager: AnalyticsManager {
    static let shared = FirebaseAnalyticsManager()
    private init() {}
    func trackEvent(_ event: Event) {
        Analytics.logEvent(event.name, parameters: event.properties)
    }
}
