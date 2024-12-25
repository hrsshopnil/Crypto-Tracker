//
//  HomeStatView.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 3/12/24.
//

import SwiftUI
import SwiftData

struct HomeStatView: View {
    
    @EnvironmentObject var vm: HomeViewModel

    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(vm.stats) { stat in
                StatisticsView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortfolio ? .trailing : .leading
        )
    }
}

#Preview {
    HomeStatView(showPortfolio: .constant(true))
        .environmentObject(HomeViewModel())
}
