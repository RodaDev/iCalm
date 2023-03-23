//
//  BackgroundImage.swift
//  iCalm
//
//  Created by Dmitry Sharygin on 28.02.2023.
//

import SwiftUI

struct BackgroundImage: View {
    var imageName: String
    var gradient: LinearGradient
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            if #available(iOS 15.0, *) {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(y: -50)
                    .frame(width: size.width, height: size.height, alignment: .center)
                    .clipped()
                    .blur(radius: 1.2)
                    .overlay {
                        ZStack {
                            Rectangle()
                                .fill(gradient)
                                .opacity(0.3)
                                .frame(height: size.height / 1.5, alignment: .top)
                                .frame(maxHeight: .infinity, alignment: .top)

                            Rectangle()
                                .fill(.linearGradient(colors: [.clear,
                                                               .clear,
                                                               .black.opacity(0.9),
                                                               .black,
                                                               .black], startPoint: .top, endPoint: .bottom))
                                .frame(height: size.height / 1.25, alignment: .top)
                                .frame(maxHeight: .infinity, alignment: .bottom)
                        }
                    }
            } else {}
        }
    }
}

struct BackgroundImage_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImage(imageName: "forest",
                        gradient: LinearGradient(colors: [.orange, .yellow], startPoint: .bottom, endPoint: .top))
    }
}
