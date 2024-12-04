//
//  CircleButton.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 25/11/24.
//

import SwiftUI

struct CircleButton: View {
    let name: String
    let width: CGFloat?
    let height: CGFloat?
    let font: Font?
    
    init(name: String, width: CGFloat? = 40, height: CGFloat? = 40, font: Font? = .title3) {
        self.name = name
        self.width = width
        self.height = height
        self.font = font
    }
    
    var body: some View {
        Image(systemName: name)
            .font(font)
            .frame(width: width, height: height)
            .bold()
            .background(
                Circle()
                    .foregroundStyle(.buttonBg)
            )
            .padding(2)
            .background {
                Circle()
                    .stroke(lineWidth: 1.4)
            }
            .padding()
    }
}

#Preview {
    CircleButton(name: "heart.fill", width: 50, height: 50)
}
