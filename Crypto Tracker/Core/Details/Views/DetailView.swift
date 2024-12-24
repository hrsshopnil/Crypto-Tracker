//
//  DetailView.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 23/12/24.
//

import SwiftUI

struct LoadingView: View {
    @Binding var coin: CoinModel?
    var body: some View {
        ZStack {
            if let coin {
                DetailView(coin: coin)
            }
        }
    }
}
struct DetailView: View {
    var coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        print("initialized")
    }
    var body: some View {
        Text(coin.name)
    }
}

#Preview {
    DetailView(coin: .placeHolder)
}
