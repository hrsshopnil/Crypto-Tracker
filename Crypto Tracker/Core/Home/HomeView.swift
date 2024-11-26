//
//  HomeView.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 25/11/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        CircleButton(name: "info")
                        Spacer()
                        
                        Text("Live Price")
                            .font(.title3)
                            .bold()
                        
                        Spacer()
                        
                        CircleButton(name: "chevron.left")
                        
                    }
                    .padding(.horizontal, 18)
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
