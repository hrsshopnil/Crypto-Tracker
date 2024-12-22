//
//  SheetView.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 5/12/24.
//

import SwiftUI
import SwiftData

struct SheetView: View {
    
    @ObservedObject var vm: HomeViewModel
    @State var selectedCoin: CoinModel?
    @Environment(\.dismiss) private var dismiss
    @State private var amount = ""
    @State private var showCheckmark = false
    @Environment(\.modelContext) private var context

    
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



// MARK: Views
extension SheetView {
    private func coinsList() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
                if vm.searchText.isEmpty {
                    ForEach(vm.portfolioCoins) { coin in
                        CoinLogoView(coin: coin)
                            .padding(8)
                            .onTapGesture {
                                withAnimation {
                                    updateSelectedCoin(coin: coin)
                                }
                            }
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(selectedCoin?.id == coin.id ? .green : .clear, lineWidth: 2)
                            }
                    }
                    .padding(.leading, 16)
                    .padding(.vertical, 6)
                } else {
                    ForEach(vm.allCoins) { coin in
                        CoinLogoView(coin: coin)
                            .padding(8)
                            .onTapGesture {
                                withAnimation {
                                    updateSelectedCoin(coin: coin)
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

#Preview {
    SheetView(vm: HomeViewModel())
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
        guard let amount = Double(amount) else { return }
        let coinToSave = PortfolioItem(coinId: coin.id, currentHoldings: amount)
        
        //Save Coin to Portfolio
        
        let fetchDescriptor = FetchDescriptor<PortfolioItem>()
        
        do {
            let item = try context.fetch(fetchDescriptor)
            if let itemToUpdate = item.first(where: { $0.coinId == coin.id }) {
                if amount <= 0 {
                    context.delete(itemToUpdate)
                    try context.save()
                } else {
                    itemToUpdate.currentHoldings = amount
                    try context.save()
                }
            } else {
                context.insert(coinToSave)
            }
        } catch {
            print("Error Deleting Item")
        }
        
        vm.fetchMyCoins()
        
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
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }),
           let quantity = portfolioCoin.currentHoldings {
            amount = "\(quantity)"
        } else {
            amount = ""
        }
    }
}
