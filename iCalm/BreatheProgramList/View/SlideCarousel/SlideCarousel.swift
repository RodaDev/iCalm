//
//  SlideCarousel.swift
//  iCalm
//
//  Created by Dmitry Sharygin on 11.03.2023.
//

import SwiftUI

struct SlideCarouselList: View {
    @ObservedObject var viewModel: BreatheProgramListViewModel
    @State var currentIndex: Int
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack(alignment: .center) {
                    HStack {
                        Text("Breathingtechniques.Title")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .padding(.bottom, 16)
                            .padding(.leading, 16)
                    }
                    .padding(.top, 40)
                    SlideCarousel<SlideCard, BreatheProgram>(content: { program in
                        SlideCard(program: program)
                    }, list: viewModel.models.map {$0.program},
                                                           spacing: 16,
                                                           trailingSpace: 32,
                                                           index: $currentIndex)
                    .frame(proxy.width * 0.94, proxy.height * 0.6)
                    .padding(.top, 16)
                    ProgramsPreview(program: viewModel.models[currentIndex].program)
                        .animation(.easeOut(duration: 0.1) , value: currentIndex)
                        .frame(proxy.width * 0.5, proxy.height * 0.2)
                    HStack(spacing: 10) {
                        ForEach(viewModel.models.indices, id: \.self) { index in
                            Circle()
                                .fill(.black.opacity(currentIndex == index ? 1 : 0.1))
                                .frame(8, 8)
                                .scaleEffect(currentIndex == index ? 1.5 : 1)
                                .animation(.spring(), value: currentIndex == index)
                        }
                    }
                    .padding()
                }
                
                .navigationBarHidden(true)
                .navigationTitle("")
            }
        }
        .accentColor(.white)
        .preferredColorScheme(.light)
    }
}

struct SlideCarousel_Previews: PreviewProvider {
    static var previews: some View {
        SlideCarouselList(viewModel: mockBreatheProgramListViewModel,
                          currentIndex: 0)
    }
}

struct SlideCard: View {
    var program: BreatheProgram
    @State var isActive: Bool = false
    var body: some View {
        GeometryReader { proxy in
            if #available(iOS 15.0, *) {
                ZStack {
                    if #available(iOS 15.0, *) {
                        Image(program.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(proxy.width * 0.9, proxy.height)
                            .overlay(LinearGradient(colors: [.clear, .clear, .black.opacity(0.8)], startPoint: .top, endPoint: .bottom))
                            .cornerRadius(40)
                    } else {
                        Image(program.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(proxy.width, proxy.height)
                            .cornerRadius(40)
                    }
                    VStack {
                        Spacer()
                        Text(program.title)
                            .foregroundColor(.white)
                            .font(.title2)
                            .align(.center)
                            .padding(.bottom, 32)
                            .padding(.leading, 32)
                            .padding(.trailing, 32)
                    }
                }
                .background {
                    NavigationLink("", isActive: $isActive) {
                        BreatheView<BreatheViewModel>(viewModel: BreatheViewModel(breatheModel: BreatheModel(program: program, colorStart: .blue, colorEnd: .purple)))
                    }
                    .navigationTitle("")
                }
                .onTapGesture {
                    isActive = true
                }
                .shadow(color: .gray, radius: 20, x: 12, y: 12)
            } else {}
        }
    }
}

struct ProgramsPreview: View {
    var program: BreatheProgram
    var body: some View {
        HStack(spacing: 2) {
            let stagesCount = program.stages.count / program.laps
            ForEach(0...stagesCount - 1, id: \.self) { index in
                VStack(spacing: 24) {
                    let stage = program.stages[index]
                    Text(stage.getTitle())
                        .align(.center)
                        .foregroundColor(.gray)
                        .frame(80, 32)
                    stage.getImage()
                        .foregroundColor(.gray)
                        .frame(80, 22)
                    Text("Seconds.key \(stage.interval)")
                        .font(.body)
                        .foregroundColor(.gray)
                        .align(.center)
                        .frame(80, 32)
                }
                .frame(maxHeight: .infinity)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(.trailing, 32)
        .padding(.leading, 32)
    }
}

struct SlideCarousel<Content: View, T: Identifiable >: View {
    
    var content: (T) -> Content
    var list: [T]
    
    private var spacing: CGFloat
    private var trailingSpace: CGFloat
    @Binding var index: Int
    
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    init(content: @escaping (T) -> Content,
         list: [T],
         spacing: CGFloat,
         trailingSpace: CGFloat,
         index: Binding<Int>) {
        self._index = index
        self.content = content
        self.list = list
        self.spacing = spacing
        self.trailingSpace = trailingSpace
    }
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.width - trailingSpace
            HStack(spacing: spacing * 2) {
                ForEach(list) { item in
                    content(item)
                        .frame(width - trailingSpace, proxy.height * 0.85)
                }
            }
            .padding(.horizontal, spacing)
            .offset(offset - CGFloat(currentIndex) * width, 0)
            .gesture(DragGesture()
                .updating($offset, body: { value, out, _ in
                    out = value.translation.width
                })
                .onEnded({ value in
                    let offsetX = value.translation.width * 1.75
                    let progress = -offsetX / width
                    let roundedIndex = progress.rounded()
                    currentIndex = max(min(currentIndex + Int(roundedIndex), list.count - 1), 0)
                    currentIndex = index
                })
                .onChanged({ value in
                    let offsetX = value.translation.width * 1.75
                    let progress = -offsetX / width
                    let roundedIndex = progress.rounded()
                    index = max(min(currentIndex + Int(roundedIndex), list.count - 1), 0)
                })
            )
            .animation(.easeInOut, value: offset == 0)
        }
    }
}
