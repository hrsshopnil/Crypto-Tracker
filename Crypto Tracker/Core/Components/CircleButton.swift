//
//  CircleButton.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 25/11/24.
//

import SwiftUI

struct CircleButton: View {
    let name: String
    var body: some View {
        Image(systemName: name)
            .font(.title3)
            .frame(width: 40, height: 40)
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
    CircleButton(name: "heart.fill")
}
