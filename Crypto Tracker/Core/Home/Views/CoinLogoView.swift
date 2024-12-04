//
//  CoinLogoView.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 5/12/24.
//

import SwiftUI

struct CoinLogoView: View {
    let coin: CoinModel
    var body: some View {
        VStack {
            IconView(url: coin.image)
                .frame(width: 60, height: 60)
            Text(coin.symbol.uppercased())
                .font(.title3)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(2)
        }
    }
}

#Preview {
    CoinLogoView(coin: .placeHolder)
}
