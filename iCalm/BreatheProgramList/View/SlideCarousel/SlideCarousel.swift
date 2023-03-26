//
//  SlideCarousel.swift
//  iCalm
//
//  Created by Dmitry Sharygin on 11.03.2023.
//

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
