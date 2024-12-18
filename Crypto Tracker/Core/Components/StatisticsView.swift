//
//  StatisticsView.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 3/12/24.
//

import SwiftUI

struct StatisticsView: View {
    @ObservedObject var vm: HomeViewModel
    let stat: StatisticsModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(stat.value)
                .font(.headline)
                
            HStack(spacing: 3) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentageChange) ?? 0 >= 0 ? 0 : 180))
                    .opacity(stat.percentageChange == nil ? 0 : 1)
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle(((stat.percentageChange) ?? 0 >= 0) ? .green : .red)
        }
    }
}

#Preview {
    StatisticsView(vm: HomeViewModel(), stat: .placeHolder2)
}
