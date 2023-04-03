//
//  ContentView.swift
//  iCalm
//
//  Created by Rodevelop on 28.09.2022.
//

@_exported import SwiftUI

struct ContentView: View {
    var body: some View {

        SplashView(mainView: SlideCarouselList(viewModel: mockBreatheProgramListViewModel, currentIndex: 0))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
