//
//  HomeView.swift
//  iCalm
//
//  Created by Rodevelop on 01.10.2022.
//

import SwiftUI
import PureSwiftUI

struct BreatheView<ViewModelProtocol>: View where ViewModelProtocol: BreatheViewModelProtocol {
    
    @ObservedObject var viewModel: BreatheViewModel
    private let minSize: CGFloat = 120
    private let maxSize: CGFloat = 140
    private let circlesCount: Int = 9
    
    init(viewModel: BreatheViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            getBackground()
                ZStack {
                    getGhostView()
                        .animation(.easeOut(duration: Double(viewModel.currentBreatheStage().interval)).delay(0.4))
                    getBreatheCirclesView()
                        .padding()
                        .animation(.easeInOut(duration: Double(viewModel.currentBreatheStage().interval)))
                        .frameIf(viewModel.currentBreatheStage().type == .breatheIn, getSize() * 2)
                        .frameIf(viewModel.currentBreatheStage().type == .breatheOut, getSize())
                    getInsideCirclesTextView()
                    VStack {
                        Spacer(minLength: 250)
                        getCountIndicator()
                        Spacer(minLength: 600)
                    }
                    VStack {
                        Spacer()
                        Text(viewModel.statusText.uppercased())
                            .font(.system(size: 24, weight: .regular))
                            .foregroundColor(.cgLightGray)
                            .offset(0, -270)
                            .animation(.easeIn)
                    }
                }
                .onTapGesture {
                    viewModel.clickButton()
                }
            }
        .onDisappear() {
            viewModel.stop()
        }
    }
    
    private func getBreatheCirclesView() -> some View {
        ZStack {
            ForEach(0..<circlesCount) {
                Circle()
                    .fill(viewModel.gradient)
                    .frame(getSize())
                    .offset(x: CGFloat(getXOffset()))
                    .rotationEffect(.degrees(Double(Int(360.0) / circlesCount * $0)))
                    .blur(3)
                    .blendMode(.screen)
            }
            Circle()
                .fill(viewModel.gradient)
                .frame(minSize * 0.6)
                .opacity(0.8)
                .blur(1)
        }
    }
    
    private func getCountIndicator() -> some View {
        ZStack {
            Text(viewModel.counterText.uppercased())
                .font(.system(size: 48, weight: .regular))
                .foregroundColor(.white)
                .padding()
        }
    }
    
    private func getGhostView() -> some View {
        Circle()
            .fill(viewModel.gradient)
            .frame(getGhostSize())
            .blur(getGhostBlur())
            .opacity(getGhostOpacity())
    }
    
    private func getSize() -> CGFloat {
        switch viewModel.currentBreatheStage().type {
        case .breatheIn, .inPause:
            return maxSize
        case.breatheOut, .outPause, .stop:
            return minSize
        }
    }
    
    private func getBreatheSourceView() -> some View {
        ZStack{
            Circle()
                .fill(Color.clear)
                .frame(minSize)
            viewModel.currentBreatheStage().getImage()
        }
    }
    
    private func getInsideCirclesTextView() -> some View {
        VStack {
            switch viewModel.currentBreatheStage().type {
            case .stop:
                getStartText()
            default:
                getBreatheSourceView()
            }
        }
    }
    
    private func getStartText() -> some View {
        Text("Старт".uppercased())
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.white)
    }
    
    private func getXOffset() -> CGFloat {
        switch viewModel.currentBreatheStage().type {
        case .breatheIn, .inPause:
            return getSize() / 2
        case.breatheOut, .stop , .outPause:
            return 0
        }
    }
    
    private func getGhostSize() -> CGFloat {
        switch viewModel.currentBreatheStage().type {
        case .breatheIn, .inPause:
            return maxSize * 2.03
        case.breatheOut, .outPause, .stop:
            return minSize * 1.15
        }
    }
    
    private func getGhostBlur() -> CGFloat {
        switch viewModel.currentBreatheStage().type {
        case .breatheIn, .inPause:
            return 2
        case.breatheOut, .stop , .outPause:
            return 5
        }
    }
    
    private func getGhostOpacity() -> CGFloat {
        
        switch viewModel.currentBreatheStage().type {
        case .breatheIn, .inPause:
            return 0.6
        case.breatheOut, .stop , .outPause:
            return 0.3
        }
    }
    
    @ViewBuilder
        func getBackground() -> some View {
            GeometryReader { proxy in
                let size = proxy.size
                if #available(iOS 15.0, *) {
                    Image(viewModel.backgroundImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .offset(y: -50)
                        .frame(width: size.width, height: size.height, alignment: .center)
                        .clipped()
                        .blur(radius: 1.2)
                        .overlay {
                            ZStack {
                                Rectangle()
                                    .fill(viewModel.gradient)
                                    .frame(height: size.height / 1.5, alignment: .top)
                                    .frame(maxHeight: .infinity, alignment: .top)
    
                                Rectangle()
                                    .fill(.linearGradient(colors: [.clear,
                                                                   .clear,
                                                                   .black.opacity(0.8),
                                                                   .black,
                                                                   .black], startPoint: .top, endPoint: .bottom))
                                    .frame(height: size.height / 1.25, alignment: .top)
                                    .frame(maxHeight: .infinity, alignment: .bottom)
                            }
                        }
                } else {}
            }
            .ignoresSafeArea()
        }
}
