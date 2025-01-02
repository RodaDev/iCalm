//
//  BreatheProgramListViewModel.swift
//  iCalm
//
//  Created by Dmitry Sharygin on 12.02.2023.
//

import Combine

class BreatheProgramListViewModel: BreatheProgramListViewModelProtocol {
    @Published var models: [BreatheModel]
    private let analyticsManager: AnalyticsManager
    
    init(models: [BreatheModel], analyticsManager: AnalyticsManager) {
        self.models = models
        self.analyticsManager = analyticsManager
    }
    
    func logShownModel(_ model: BreatheModel) {
        analyticsManager.trackEvent(Event(name: "shown_breathe_program",
                                          properties: ["program_name": model.program.title]))
    }
}
