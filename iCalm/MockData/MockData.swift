//
//  MockData.swift
//  iCalm
//
//  Created by Dmitry Sharygin on 23.02.2023.
//

import Foundation

let firstPrStages = [BreatheStage(type: .breatheIn, interval: 4, source: .nose),
                     BreatheStage(type: .inPause, interval: 2, source: .mouth),
                     BreatheStage(type: .breatheOut, interval: 4, source: .mouth),
                     BreatheStage(type: .outPause, interval: 2, source: .mouth)]
let firstBreatheModel = BreatheModel(program: .init(title: "Снятие напряжения",
                                                    stages:firstPrStages,
                                                    laps: 10,
                                                    image: "seaside"),
                                     colorStart: .pink,
                                     colorEnd: .cgCyan)
let secondPrStages = [BreatheStage(type: .breatheIn, interval: 4, source: .nose),
                      BreatheStage(type: .inPause, interval: 2, source: .mouth),
                      BreatheStage(type: .breatheOut, interval: 6, source: .mouth)]
let secondBreatheModel = BreatheModel(program: .init(title: "Облегчение тревоги",
                                                     stages: secondPrStages,
                                                     laps: 10,
                                                    image: "waterfall"),
                                      colorStart: .blue, colorEnd: .white)

let thirdPrStages = [BreatheStage(type: .breatheIn, interval: 4, source: .nose),
                     BreatheStage(type: .inPause, interval: 4, source: .mouth),
                      BreatheStage(type: .breatheOut, interval: 6, source: .mouth),
                      BreatheStage(type: .outPause, interval: 3, source: .mouth)]
let thirdBreatheModel = BreatheModel(program: .init(title: "Антистресс", stages: thirdPrStages, laps: 8,image: "forest"), colorStart: .purple, colorEnd: .pink)

let forthPrStages = [BreatheStage(type: .breatheIn, interval: 7, source: .nose),
                      BreatheStage(type: .breatheOut, interval: 11, source: .nose)]
let forthBreatheModel = BreatheModel(program: .init(title: "Остановка паники", stages: forthPrStages, laps: 8, image: "beach"), colorStart: .green, colorEnd: .cgCyan)

let testModels = [firstBreatheModel, secondBreatheModel, thirdBreatheModel, forthBreatheModel]
let mockBreatheProgramListViewModel = BreatheProgramListViewModel(models: testModels)
