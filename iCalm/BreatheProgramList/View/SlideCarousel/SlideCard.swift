//
//  SlideCard.swift
//  Просто Дыши
//
//  Created by Dmitry Sharygin on 27.03.2023.
//

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
                        BreatheView<BreatheViewModel>(viewModel: BreatheViewModel(breatheModel: BreatheModel(program: program, colorStart: .blue, colorEnd: .purple), analyticsManager: FirebaseAnalyticsManager.shared)) // TODO:  перенести analyticsManager
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
