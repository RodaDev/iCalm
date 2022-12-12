//
//  BreatheViewModel.swift
//  iCalm
//
//  Created by Rodevelop on 04.12.2022.
//

import Combine
import SwiftUI

class BreatheViewModel: BreatheViewModelProtocol, ObservableObject {
    
    let program: BreatheProgram
    @ObservedObject private var currentStage: BreatheStage
    
    init(program: BreatheProgram) {
        self.program = program
        self.currentStage = program.stages.first!
    }
    
    func start() {
        
    }
    
    func getCurrentBreatheStage() -> AnyPublisher<BreatheStage, Never> {
        Just(BreatheStage(type: .breatheIn, interval: 0))
            .eraseToAnyPublisher()
    }
    
    func changeBreathStage() {
        
    }
}
