//
//  HomeView.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 25/11/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HomeHeaderView(showPortfolio: $showPortfolio)
                    .padding(.horizontal)
                    Spacer(minLength: 0)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    HomeView()
}
