//
//  BreatheViewModelProtocol.swift
//  iCalm
//
//  Created by Rodevelop on 04.12.2022.
//

import Combine
import SwiftUI

protocol BreatheViewModelProtocol: ObservableObject {
    func clickButton()
    func currentBreatheStage() -> BreatheStage
    func stop()
    var currentProgramCount: Int { get }
    var currentProgramType: String { get }
    var buttonTitle: String { get }
    var gradient: LinearGradient { get }
    var counterText: String { get }
    var statusText: String { get }
    var backgroundImageName: String { get }
    var currentProgress: Float { get }
}
