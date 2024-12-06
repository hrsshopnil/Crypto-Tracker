//
//  SheetView.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 5/12/24.
//

import SwiftUI

struct SheetView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State var selectedCoin: CoinModel?
    @Environment(\.dismiss) private var dismiss
    @State private var amount = ""
    @State private var showCheckmark = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    SearchBar(text: $vm.searchText)
                    coinsList()
                    
                    if let coin = selectedCoin {
                        portfolioInputSection(coin: coin)
                            .animation(.none)
                    }
                }
                .navigationTitle("Edit Profile")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        CircleButton(name: "xmark", width: 30, height: 30, font: .caption)
                            .onTapGesture {
                                dismiss()
                            }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        trailingNavButton()
                    }
                }
            }
        }
    }
    
    
}

#Preview {
    SheetView(selectedCoin: .placeHolder)
        .environmentObject(HomeViewModel())
}

// MARK: Views
extension SheetView {
    private func coinsList() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
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
                .padding(.leading, 16)
                .padding(.vertical, 6)
            }
        }
    }
    
    private func portfolioInputSection(coin: CoinModel) -> some View {
        VStack {
            HStack {
                Text("Current price of \(coin.symbol.uppercased()):")
                Spacer()
                Text("\(coin.currentPrice.asCurrencyWith2Decimals())")
            }
            Divider()
            HStack {
                Text("Amount Holding:")
                TextField("Ex: 4.3", text: $amount)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
        HStack {
            Text("Current Value:")
            Spacer()
            Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .font(.headline)
        .padding()
    }
    
    private func trailingNavButton() -> some View {
        HStack {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1 : 0)
            
            Button {
                saveButtonPressed()
            } label: {
                Text("Save")
                    .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(amount) ? 1 : 0)
            }
        }
        .font(.headline)
    }
    
}


// MARK: Functions
extension SheetView {
    private func getCurrentValue() -> Double {
        let amounts = Double(amount)
        guard let coinPrice = selectedCoin?.currentPrice,
              let amounts else { return 0 }
        return amounts * coinPrice
    }
    
    private func saveButtonPressed() {
        guard let coin = selectedCoin else { return }
        
        //Save Coin to Portfolio
        
        //Show Checkmark
        withAnimation {
            showCheckmark = true
            removeSelectedCoin()
        }
        //Hide Keyboard
        UIApplication.shared.endEditing()
        
        //Hide Checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
}
