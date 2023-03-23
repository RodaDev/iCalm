//
//  BreatheProgramListViewModel.swift
//  iCalm
//
//  Created by Dmitry Sharygin on 12.02.2023.
//

import Combine

class BreatheProgramListViewModel: BreatheProgramListViewModelProtocol {
    @Published var models: [BreatheModel]
    
    init(models: [BreatheModel]) {
        self.models = models
    }
}
