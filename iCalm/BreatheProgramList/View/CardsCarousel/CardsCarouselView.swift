//
//  CardsCarouselView.swift
//  iCalm
//
//  Created by Dmitry Sharygin on 19.02.2023.
//

import SwiftUI
struct CardsCarouselView: View {
    @ObservedObject var viewModel: BreatheProgramListViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 12) {
                    ForEach(viewModel.models, id: \.id) { model in
                        GeometryReader { proxy in
                            NavigationLink {
                                BreatheView<BreatheViewModel>(viewModel: BreatheViewModel(breatheModel: BreatheModel(program: model.program, colorStart: model.colorStart, colorEnd: model.colorEnd)))
                            } label: {
                                let scale = getScale(proxy: proxy)
                                let gradient = LinearGradient(colors: [model.colorStart, model.colorEnd], startPoint: .bottom, endPoint: .top)
                                CardView(title: model.program.title,
                                         image: model.program.image,
                                         gradient: gradient)
                                .shadow(4, offset: CGPoint(2, 2))
                                .scaleEffect(.init(width: scale, height: scale))
                                .animation(.easeOut(duration: 1))
                            }
                        }
                        .frame(225, 400)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 32)
                    }
                }
                .padding()
            }
            .background(Image("abstract")
                        .blur(radius: 10))
        }
    }
    
    private func getScale(proxy: GeometryProxy) -> CGFloat {
        let midPoint: CGFloat = 125
        
        let viewFrame = proxy.frame(in: CoordinateSpace.global)
        
        var scale: CGFloat = 1.0
        let deltaXAnimationThreshold: CGFloat = 125
        
        let diffFromCenter = abs(midPoint - viewFrame.origin.x - deltaXAnimationThreshold / 8)
        print(diffFromCenter)
        if diffFromCenter < deltaXAnimationThreshold {
            scale = 1 + (deltaXAnimationThreshold - diffFromCenter) / 500
        }
        
        return scale
    }
}

struct CardsCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CardsCarouselView(viewModel: mockBreatheProgramListViewModel)
    }
}
