//
//  CoinRowView.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 28/11/24.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    let showCenterColumn: Bool
    var body: some View {
        HStack(spacing: 12) {
            leftColumn()
            Spacer()
            if showCenterColumn {
                centerColumn()
            }
            Spacer()
            rightColumn()
        }
        .padding()
        .font(.subheadline)
    }
}

#Preview {
    CoinRowView(coin: .placeHolder, showCenterColumn: true)
}

extension CoinRowView {
    private func leftColumn() -> some View {
        HStack {
            Text("\(coin.rank)")
            Circle()
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
        }
    }
    
    private func centerColumn() -> some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .font(.headline)
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
    }
    
    private func rightColumn() -> some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith2Decimals())
                .font(.headline)
            Text((coin.priceChangePercentage24H ?? 0).asPercentString())
                .foregroundStyle(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ? .green : .red
                )
        }
        
    }
}
