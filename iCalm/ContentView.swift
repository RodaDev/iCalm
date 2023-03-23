//
//  ContentView.swift
//  iCalm
//
//  Created by Rodevelop on 28.09.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        SlideCarouselList(viewModel: mockBreatheProgramListViewModel, currentIndex: 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
