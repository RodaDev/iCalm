//
//  BreatheViewModel.swift
//  iCalm
//
//  Created by Rodevelop on 04.12.2022.
//

import Combine
import PureSwiftUI
import SwiftUI

class BreatheViewModel: BreatheViewModelProtocol, ObservableObject {
    
    private let generator = UISelectionFeedbackGenerator()
    
    var counterText: String {
        get {
            switch currentStage.type {
            case .outPause, .inPause, .breatheIn, .breatheOut:
                if currentProgramCount < 10 {
                    return String("00:0\(currentProgramCount)")
                } else {
                    return String("00:\(currentProgramCount)")
                }
            case .stop, .wait:
                return "00:00"
            }
        }
    }
    
    var statusText: String {
        get {
            switch currentStage.type {
            case .outPause, .inPause:
                return String(localized: "HoldBreathe.key")
            case .breatheIn:
                return String(localized: "Inhale.key")
            case .breatheOut:
                return String(localized: "Exhale.key")
            case .stop, .wait:
                return ""
            }
        }
    }
    var gradient: LinearGradient {
        get {
            return LinearGradient([breatheModel.colorStart.opacity(0.5), breatheModel.colorEnd.opacity(0.5)], to: .top)
        }
        
    }
    private let breatheModel: BreatheModel
        
    @Published var buttonTitle: String = "Start"
    @Published private var currentStage: BreatheStage
    @Published var currentProgramCount: Int = 0
    @Published var currentProgramType: String = ""
    @Published var backgroundImageName: String
    @Published var currentProgress: Float = 0
    
    private var currentIndex = 0
    private var cancellable = Set<AnyCancellable>()
    private var counter = 0
    private let analyticsManager: AnalyticsManager
    lazy private var timerPublisher: Timer.TimerPublisher = getTimerPublisher()
    lazy private var timeStamps = getTimeStamps()
    lazy private var length = getFullLength()
    
    init(breatheModel: BreatheModel, analyticsManager: AnalyticsManager) {
        self.breatheModel = breatheModel
        self.currentStage = BreatheStage(type: .stop, interval: 0)
        self.backgroundImageName = breatheModel.program.image
        self.analyticsManager = analyticsManager
    }
    
    func clickButton() {
        switch currentStage.type {
        case .breatheOut, .breatheIn, .inPause, .outPause, .wait:
            stop()
        case .stop:
            start()
        }
    }
    
    func logOpened() {
        analyticsManager.trackEvent(Event(name: "breathe_screen_opened",
                                          properties: ["program_name": breatheModel.program.title]))
    }
    
    private func start() {
        var counter = 0
        currentIndex = 0
        currentProgress = 0
        currentStage = BreatheStage(type: .wait, interval: 1)
        analyticsManager.trackEvent(Event(name: "start_button_clicked",
                                          properties: ["program_name": breatheModel.program.title]))
        guard let firstStage = breatheModel.program.stages.first else {
            return
        }
        generator.selectionChanged()
        timerPublisher
            .autoconnect()
            .map({ date -> Void in
                counter += 1
            })
            .sink(receiveValue: { val in
                let stages = self.breatheModel.program.stages
                self.currentProgress = Float(counter - 1) / self.length
                if stages.count == self.currentIndex {
                    self.stop()
                    return
                }
                self.currentStage = firstStage
                let timeStamp = self.timeStamps[self.currentIndex]
                let currentProgram = stages[self.currentIndex]
                self.currentProgramCount = timeStamp - counter + 1
                if self.currentProgramCount == currentProgram.interval && self.currentIndex > 0 {
                    self.generator.selectionChanged()
                }
                self.currentProgramType = currentProgram.type.rawValue
                self.currentStage = currentProgram
                if counter == timeStamp {
                    self.currentIndex += 1
                }
            })
            
            .store(in: &cancellable)
    }
    
    func stop() {
        generator.selectionChanged()
        buttonTitle = "Start"
        currentProgramType = ""
        currentProgramCount = 0
        let logEvent = Event(name: "stop_button_clicked",
                             properties: ["program_name": breatheModel.program.title,
                                          "current_progress": currentProgress])
        analyticsManager.trackEvent(logEvent)
        cancellable.forEach {
            $0.cancel()
        }
        self.currentStage = BreatheStage(type: .stop, interval: 0)
    }
    
    private func getTimerPublisher() -> Timer.TimerPublisher {
        return Timer.publish(every: 1.0, on: .main, in: .common)
    }
    
    private func getTimeStamps() -> [Int] {
        var result = [Int]()
        
        let intervals = breatheModel.program.stages.map { $0.interval }
        intervals.forEach {
            let val = (result.last ?? 0) + $0
            result.append(val)
        }
        return result
    }
    
    private func getFullLength() -> Float {
        let intervals = breatheModel.program.stages.map { $0.interval }
        return Float(intervals.reduce(0, +))
    }
    
    func currentBreatheStage() -> BreatheStage {
        return currentStage
    }
}
