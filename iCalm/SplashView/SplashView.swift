//
//  SplashView.swift
//  Просто Дыши
//
//  Created by Dmitry Sharygin on 03.04.2023.
//

import SwiftUI

struct SplashView<Content: View>: View {
    
    @State private var isVisible: Bool = false
    @State private var mainIsVisible = false
    
    var mainView: Content
    var body: some View {
        ZStack {
            mainView
                .opacity(mainIsVisible ? 1 : 0)
            Image("MainIconSmall")
                .resizable()
                .frame(128, 128)
                .scaleEffect(isVisible ? 0.9 : 1.0)
                .opacity(mainIsVisible ? 0 : 1)
            VStack {
                Spacer()
                if isVisible && !mainIsVisible {
                    Spacer()
                    Text("Просто\n дыши").foregroundColor(.gray)
                        .font(.system(size: 28,
                                      weight: .regular,
                                      design: .serif))
                        .padding()
                        .transition(.opacity)
                    Spacer()
                    Text("От Евгении Шарыгиной")
                        .foregroundColor(.gray)
                        .font(.system(size: 20,
                                      weight: .light,
                                      design: .serif))
                        .padding()
                        .transition(.move(edge: .bottom))
                }
            }
        }
        .onAppear {
            let animation = Animation.easeOut(duration: 0.5)
            withAnimation(animation) {
                isVisible = true
            }
            let mainAnimation = Animation.easeIn(duration: 0.2).delay(1.5)
            withAnimation(mainAnimation){
                mainIsVisible = true
                //isVisible = false
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(mainView: SlideCarouselList(viewModel: mockBreatheProgramListViewModel, currentIndex: 0))
    }
}
