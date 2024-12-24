//
//  HomeView.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 25/11/24.
//

import SwiftUI
import SwiftData
import Combine

struct HomeView: View {
    
    @StateObject private var vm = HomeViewModel()
    @State private var showPortfolio = false
    @State private var showSheet = false
    @State private var selectedCoin: CoinModel?
    @State private var showDetailView = false
    @Environment(\.modelContext) var context
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    homeHeader()
                        .padding(.horizontal)
                        .padding(.bottom)
                    HomeStatView(vm: vm, showPortfolio: $showPortfolio)
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
                    SheetView(vm: vm)
                        .environmentObject(vm)
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                vm.context = context
                vm.fetchMyCoins()
            }
            
            .navigationDestination(isPresented: $showDetailView) {
                LoadingView(coin: $selectedCoin)
            }
        }
    }
}


// MARK: Views
extension HomeView {
    private func allCoinsList() -> some View {
        List {
            ForEach(vm.allCoins) { coin in
                    CoinRowView(coin: coin, showCenterColumn: false, image: coin.image)
                    .onTapGesture {
                        segue(coin: coin)
                    }
                }
            }
        .listStyle(.plain)
    }
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showDetailView.toggle()
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
            HStack {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity(vm.sortOptions == .ranked || vm.sortOptions == .reverseRanked ? 1 : 0)
                    .rotationEffect(Angle(degrees: vm.sortOptions == .ranked ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOptions = vm.sortOptions == .ranked ? .reverseRanked : .ranked
                }
            }
            Spacer()
            if showPortfolio {
                HStack {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity(vm.sortOptions == .holdings || vm.sortOptions == .reverseHoldings ? 1 : 0)
                        .rotationEffect(Angle(degrees: vm.sortOptions == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOptions = vm.sortOptions == .holdings ? .reverseHoldings : .holdings
                    }
                }
            }
            Spacer()
            HStack {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity(vm.sortOptions == .price || vm.sortOptions == .reversePrice ? 1 : 0)
                    .rotationEffect(Angle(degrees: vm.sortOptions == .price ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOptions = vm.sortOptions == .price ? .reversePrice : .price
                }
            }
            
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            //.rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
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
