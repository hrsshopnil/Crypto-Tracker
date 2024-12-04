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
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    homeHeader()
                        .padding(.horizontal)
                        .padding(.bottom)
                    HomeStatView(showPortfolio: $showPortfolio)
                    SearchBar(text: $vm.searchText)
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
                .sheet(isPresented: $showSheet) {
                    SheetView()
                        .environmentObject(vm)
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
    
    private func homeHeader() -> some View {
        HStack {
            CircleButton(name: showPortfolio ? "plus" : "info")
                .animation(.none)
                .background (
                    CircleButtonAnimation(animate: $showPortfolio)
                )
                .onTapGesture {
                    if showPortfolio {
                        showSheet.toggle()
                    }
                }
            Spacer()
            
            Text(showPortfolio ? "Portfolio" : "Live Price")
                .font(.title3)
                .bold()
                .animation(.none)
            
            Spacer()
            
            CircleButton(name: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
            
        }

    }
}