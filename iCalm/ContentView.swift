//
//  ContentView.swift
//  iCalm
//
//  Created by Rodevelop on 28.09.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let items = [ProgramItem(type: .breatheIn, interval: 4),
                     ProgramItem(type: .breatheOut, interval: 8)]
        let testProgram = BreatheProgram(title: "Тестовая прогорамма",
                                         color: .purple, items: items, laps: 2)
        
        HomeView(program: testProgram)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
