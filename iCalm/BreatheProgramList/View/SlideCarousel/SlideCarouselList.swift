//
//  SlideCarouselList.swift
//  Просто Дыши
//
//  Created by Dmitry Sharygin on 27.03.2023.
//

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

