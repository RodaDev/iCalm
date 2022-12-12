//
//  ContentView.swift
//  iCalm
//
//  Created by Rodevelop on 28.09.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("bubu")
        let stages = [BreatheStage(type: .breatheIn, interval: 4),
                     BreatheStage(type: .breatheOut, interval: 8)]
        let testProgram = BreatheProgram(title: "Тестовая программа",
                                         color: .purple, stages: stages, laps: 2)
        let testViewModel = BreatheViewModel(program: testProgram)
        
//        HomeView(program: testProgram)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
