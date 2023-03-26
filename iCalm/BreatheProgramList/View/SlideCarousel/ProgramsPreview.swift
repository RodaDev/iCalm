//
//  ProgramsPreview.swift
//  Просто Дыши
//
//  Created by Dmitry Sharygin on 27.03.2023.
//

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

