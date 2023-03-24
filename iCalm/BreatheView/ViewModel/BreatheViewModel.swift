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
            case .stop:
                return "00:00"
            }
        }
    }
    
    var statusText: String {
        get {
            switch currentStage.type {
            case .outPause, .inPause:
                return "Задержите дыхание"
            case .breatheIn:
                return "Вдыхайте"
            case .breatheOut:
                return "Выдыхайте"
            case .stop:
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
    
    private var currentIndex = 0
    private var cancellable = Set<AnyCancellable>()
    private var counter = 0
    lazy private var timerPublisher: Timer.TimerPublisher = getTimerPublisher()
    lazy private var timeStamps = getTimeStamps()
    
    init(breatheModel: BreatheModel) {
        self.breatheModel = breatheModel
        self.currentStage = BreatheStage(type: .stop, interval: 0)
        self.backgroundImageName = breatheModel.program.image
    }
    
    func clickButton() {
        switch currentStage.type {
        case .breatheOut, .breatheIn, .inPause, .outPause:
            stop()
        case .stop:
            start()
        }
    }
    
    private func start() {
        var counter = 0
        currentIndex = 0
        buttonTitle = "Stop"
        guard let firstStage = breatheModel.program.stages.first else {
            return
        }
        generator.selectionChanged()
        self.currentStage = firstStage
        timerPublisher
            .autoconnect()
            .map({ date -> Void in
                counter += 1
            })
            .sink(receiveValue: { val in
                let stages = self.breatheModel.program.stages
                if stages.count == self.currentIndex {
                    self.stop()
                    return
                }
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
                
                print("counter = \(counter) currentProgramCount = \(self.currentProgramCount) program = \(self.currentProgramType)")
            })
            
            .store(in: &cancellable)
    }
    
    func stop() {
        generator.selectionChanged()
        buttonTitle = "Start"
        currentProgramType = ""
        currentProgramCount = 0
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
    
    func currentBreatheStage() -> BreatheStage {
        return currentStage
    }
}
