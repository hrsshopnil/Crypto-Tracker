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
            .frame(width: 50, height: 50)
            .bold()
            .background {
                Circle()
                    .foregroundStyle(.black)
                Circle()
                    .stroke(.white, lineWidth: 1.4)
            }
            .padding()
    }
}

#Preview {
    CircleButton(name: "heart.fill")
}
