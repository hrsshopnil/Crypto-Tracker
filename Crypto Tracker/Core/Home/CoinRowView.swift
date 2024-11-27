//
//  CoinRowView.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 28/11/24.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    var body: some View {
        HStack(spacing: 12) {
            Text("\(coin.rank)")
            Circle()
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(coin.currentPrice)")
                    .font(.headline)
                Text("\(coin.priceChangePercentage24H ?? 0)%")
                    .foregroundStyle(
                        (coin.priceChangePercentage24H ?? 0) >= 0 ? .green : .red
                    )
            }
        }
        .padding()
    }
}

#Preview {
    CoinRowView(coin: .placeHolder)
}
