//
//  SheetView.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 5/12/24.
//

import SwiftUI

struct SheetView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    SearchBar(text: $vm.searchText)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(vm.allCoins) { coin in
                                CoinLogoView(coin: coin)
                                    .padding(8)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedCoin = coin
                                        }
                                    }
                                    .background {
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(selectedCoin?.id == coin.id ? .green : .clear, lineWidth: 2)
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

