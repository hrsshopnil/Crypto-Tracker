//
//  CircleButtonAnimation.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 26/11/24.
//

import SwiftUI

struct CircleButtonAnimation: View {
    @Binding var animate: Bool
    var body: some View {
        Circle()
            .stroke(lineWidth: 5)
            .scale(animate ? 1 : 0)
            .opacity(animate ? 0 : 1)
            .animation(animate ? Animation.easeOut(duration: 1) : .none)
            //.animation(Animation.easeInOut(duration: 1), value: animate)
        
    }
}

#Preview {
    CircleButtonAnimation(animate: .constant(false))
}
