//
//  BreatheViewModelProtocol.swift
//  iCalm
//
//  Created by Rodevelop on 04.12.2022.
//

import Combine

protocol BreatheViewModelProtocol: ObservableObject {
    func start()
    func getCurrentBreatheStage() -> AnyPublisher<BreatheStage, Never>
    func changeBreathStage()
}
