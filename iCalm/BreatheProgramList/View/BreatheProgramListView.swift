//
//  BreatheProgramListView.swift
//  iCalm
//
//  Created by Dmitry Sharygin on 04.02.2023.
//

import SwiftUI

struct BreatheProgramListView: View {
    @ObservedObject var viewModel: BreatheProgramListViewModel
    
    
    var body: some View {
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct BreatheProgramListView_Previews: PreviewProvider {
    static var previews: some View {
//        let firstPrStages = [BreatheStage(type: .breatheIn, interval: 2, source: .mouth),
//                             BreatheStage(type: .breatheOut, interval: 2, source: .mouth)]
//        let firstBreatheModel = BreatheModel(program: .init(title: "Ptogram 2-2",
//                                                            stages:
//                                                                firstPrStages,
//                                                            laps: 8),
//                                             colorStart: .orange,
//                                             colorEnd: .cgCyan)
//        let secondPrStages = [BreatheStage(type: .breatheIn, interval: 3, source: .nose),
//                             BreatheStage(type: .inPause, interval: 1, source: .mouth),
//                              BreatheStage(type: .breatheOut, interval: 6, source: .mouth),
//                              BreatheStage(type: .outPause, interval: 1, source: .mouth)]
//        let secondBreatheModel = BreatheModel(program: .init(title: "Ptogram 3-6",
//                                                             stages: secondPrStages,
//                                                             laps: 4),
//                                              colorStart: .blue, colorEnd: .white)
//        let thirdPrStages = [BreatheStage(type: .breatheIn, interval: 4, source: .nose),
//                             BreatheStage(type: .inPause, interval: 1, source: .mouth),
//                              BreatheStage(type: .breatheOut, interval: 8, source: .mouth),
//                              BreatheStage(type: .outPause, interval: 1, source: .mouth)]
//        let thirdBreatheModel = BreatheModel(program: .init(title: "Ptogram 4-8", stages: thirdPrStages, laps: 8), colorStart: .purple, colorEnd: .pink)
//        let forthPrStages = [BreatheStage(type: .breatheIn, interval: 2, source: .nose),
//                             BreatheStage(type: .inPause, interval: 1, source: .mouth),
//                              BreatheStage(type: .breatheOut, interval: 6, source: .mouth),
//                              BreatheStage(type: .outPause, interval: 1, source: .mouth)]
//        let forthBreatheModel = BreatheModel(program: .init(title: "Ptogram 2-6", stages: forthPrStages, laps: 8), colorStart: .green, colorEnd: .yellow)
//        let testPrograms = [firstBreatheModel,
//                            secondBreatheModel,
//                            thirdBreatheModel,
//                            forthBreatheModel]
//        let viewModel = BreatheProgramListViewModel(programs: testPrograms)
        BreatheProgramListView(viewModel: mockBreatheProgramListViewModel)
    }
}
