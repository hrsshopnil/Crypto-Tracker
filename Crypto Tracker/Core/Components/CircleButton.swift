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
            .bold()
            .padding(14)
            .background {
                Circle()
                    .stroke(.white, lineWidth: 1.4)
            }
    }
}

#Preview {
    CircleButton(name: "heart.fill")
}
