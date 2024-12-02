//
//  HomeView.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 25/11/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    HomeHeaderView(showPortfolio: $showPortfolio)
                        .padding(.horizontal)
                        .padding(.bottom)
                    columnTitles()
                        .padding(.horizontal, 21)
                    if !showPortfolio {
                        allCoinsList()
                            .transition(.move(edge: .leading))
                    } else {
                        portfolioCoinsList()
                            .transition(.move(edge: .trailing))
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}

extension HomeView {
    private func allCoinsList() -> some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showCenterColumn: false, image: coin.image)
                
            }
        }
        .listStyle(.plain)
    }
    
    private func portfolioCoinsList() -> some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showCenterColumn: true, image: coin.image)
                
            }
        }
        .listStyle(.plain)
    }
    
    private func columnTitles() -> some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
                
                    .padding(.trailing, 6)
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            
        }
        .font(.caption)
        .foregroundStyle(.secondary)
    }
}
