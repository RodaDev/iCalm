//
//  CardView.swift
//  iCalm
//
//  Created by Dmitry Sharygin on 19.02.2023.
//

import SwiftUI

struct CardView: View {
    var title: String
    var image: String
    var gradient: LinearGradient
    
    var body: some View {
        GeometryReader{ proxy in
            ZStack {
                BackgroundImage(imageName: image, gradient: gradient)
                    .cornerRadius(16)
                Text(title)
                    .font(Font(.init(.label, size: 32)))
                    .align(.leading)
                    .foregroundColor(.white)
                    .width(proxy.width * 0.75)
                    .position(x: proxy.width / 2,
                              y: proxy.height / 1.2)
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "Тестовая программа дыхания", image: "forest", gradient: LinearGradient.init(colors: [.cgCyan, .blue], startPoint: .top, endPoint: .bottom))
    }
}
