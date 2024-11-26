//
//  HomeHeaderView.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 27/11/24.
//

import SwiftUI

struct HomeHeaderView: View {
    @Binding var showPortfolio: Bool
    var body: some View {
        HStack {
            CircleButton(name: showPortfolio ? "plus" : "info")
                .animation(.none)
                .background (
                    CircleButtonAnimation(animate: $showPortfolio)
                )
            Spacer()
            
            Text(showPortfolio ? "Portfolio" : "Live Price")
                .font(.title3)
                .bold()
                .animation(.none)
            
            Spacer()
            
            CircleButton(name: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
            
        }
    }
}

#Preview {
    HomeHeaderView(showPortfolio: .constant(false))
}
