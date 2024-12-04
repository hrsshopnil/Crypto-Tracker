//
//  SheetView.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 5/12/24.
//

import SwiftUI

struct SheetView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: [CoinModel] = []
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    SearchBar(text: $vm.searchText)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 8) {
                            ForEach(vm.allCoins) { coin in
                                CoinLogoView(coin: coin)
                                    .padding(8)
                                    .onTapGesture {
                                        withAnimation {
                                            withAnimation {
                                                if !selectedCoin.contains(where: { $0.id == coin.id }) {
                                                    selectedCoin.append(coin)
                                                } else {
                                                    if let index = selectedCoin.firstIndex(where: { $0.id == coin.id }) {
                                                        selectedCoin.remove(at: index)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .background {
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(
                                                selectedCoin.contains(where: { $0.id == coin.id }) ? Color.green : Color.clear,
                                                lineWidth: 2
                                            )
                                        
                                    }
                            }
                        }
                        .padding(.leading, 16)
                        .padding(.vertical, 6)
                        //.background(.red)
                    }
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    CircleButton(name: "xmark", width: 30, height: 30, font: .caption)
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
        }
    }
}

#Preview {
    SheetView()
        .environmentObject(HomeViewModel())
}

