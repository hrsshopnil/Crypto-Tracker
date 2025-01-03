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
    let image: String
    var body: some View {
        HStack(spacing: 12) {
            leftColumn()
            
            
            if showCenterColumn {
                centerColumn()
            }
            Spacer()
            rightColumn()
            
        }
        .font(.subheadline)
        .contentShape(Rectangle())
    }
}

#Preview {
    CoinRowView(coin: .placeHolder, showCenterColumn: true, image: "")
}

extension CoinRowView {
    private func leftColumn() -> some View {
        HStack {
            Text("\(coin.rank)")
            IconView(url: image)
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
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
    
}
