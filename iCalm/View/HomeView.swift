//
//  HomeView.swift
//  iCalm
//
//  Created by Rodevelop on 01.10.2022.
//

import UIKit
import SwiftUI

struct HomeView: View {
    
    var program: BreatheProgram
    
    // MARK: - Animation properties
    @State var showBreatheView: Bool = false
    @State var startAnimation: Bool = false
    @State var timerCount: CGFloat = 0
    @State var breatheState = "ВЫДОХ"
    @State var count: Int = 0
    @State var lapsCount = 0
    
    var body: some View {
        ZStack {
            getBackground()
            getMainContent()
            Text(breatheState)
                .font(.largeTitle)
                .foregroundColor(.white)
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 50)
                .opacity(showBreatheView ? 1 : 0)
                .animation(.easeInOut(duration: 1), value: breatheState)
                .animation(.easeInOut(duration: 1), value: showBreatheView)
        }
        .onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) { _ in
            if showBreatheView {
                if timerCount > 3.2 {
                    timerCount = 0
                    lapsCount += 1
                    if program.laps <= lapsCount / 2 {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            startAnimation = false
                            showBreatheView = false
                        }
                        return
                    }
                    breatheState = breatheState == "ВДОХ" ? "ВЫДОХ" : "ВДОХ"
                    withAnimation(.easeInOut(duration: 3).delay((0.1))) {
                        startAnimation.toggle()
                    }
                } else {
                    timerCount += 0.01
                }
                count = 3 - Int(timerCount)
            } else {
                timerCount = 0
            }
        }
    }
    
    @ViewBuilder
    func getMainContent() -> some View {
        VStack {
            HStack {
                
                Button {
                } label: {
                    if #available(iOS 15.0, *) {
                        Image(systemName: "suit.heart")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 42, height: 42)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.ultraThinMaterial)
                            }
                    }
                }
            }
            .padding()
            .opacity(showBreatheView ? 0 : 1)
            GeometryReader { proxy in
                
                let size = proxy.size
                
                VStack {
                    getBreatheView(size: size)
//                    Text("Breathe to reduce")
//                        .font(.title3)
//                        .foregroundColor(.white)
//
                    Button {
                        startBreathe()
                    } label: {
                        if #available(iOS 15.0, *) {
                            Text(showBreatheView ? "Закончить" : "Начать")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .padding(.vertical, 16)
                                .frame( maxWidth: .infinity)
                                .textCase(.uppercase)
                                .background {
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .fill(.linearGradient(colors: [program.color, program.color.opacity(0.5)], startPoint: .top, endPoint: .bottom))
                                }
                        }
                    }
                    .padding()
                }
                .frame(width: size.width, height: size.height, alignment: .bottom)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    @ViewBuilder
    func getBackground() -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            if #available(iOS 15.0, *) {
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(y: -50)
                    .frame(width: size.width, height: size.height, alignment: .center)
                    .clipped()
                    .blur(radius: 1.2)
                    .overlay {
                        ZStack {
                            Rectangle()
                                .fill(.linearGradient(colors: [program.color.opacity(0.7),
                                                                .clear], startPoint: .top, endPoint: .bottom))
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
    
    @ViewBuilder
    func getBreatheView(size: CGSize, numberOfCircles: Int = 10) -> some View {
        if #available(iOS 15.0, *) {
            ZStack {
                ForEach(1...numberOfCircles, id: \.self) { index in
                    Circle()
                        .fill(program.color.opacity(0.5))
                        .frame(width: 120, height: 120)
                        .offset(x: startAnimation ? 0 : 60)
                        .rotationEffect(.init(degrees: Double(index) * 360 / Double(numberOfCircles)))
                }
            }
            .scaleEffect(startAnimation ? 0.8 : 1)
            .overlay(content: {
                Text("\(count == 0 ? 3 : count)")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.white)
                    .animation(.easeInOut, value: count)
                    .opacity(showBreatheView ? 1 : 0)
            })
            .frame(height: (size.width - 40))
        }
    }
    
    private func startBreathe() {
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
            showBreatheView.toggle()
        }
        if showBreatheView {
            withAnimation(.easeInOut(duration: 3).delay(0.01)) {
                startAnimation = true
            }
        } else {
            withAnimation(.easeInOut(duration: 0.5)) {
                startAnimation = false
            }
        }
        
    }
}

struct HomePreview: PreviewProvider {
    static var previews: some View {
        let items = [ProgramItem(type: .breatheIn, interval: 4),
                     ProgramItem(type: .breatheOut, interval: 8)]
        let testProgram = BreatheProgram(title: "Тестовая прогорамма",
                                         color: .purple, items: items, laps: 2)
        
        
        HomeView(program: testProgram)
    }
}

