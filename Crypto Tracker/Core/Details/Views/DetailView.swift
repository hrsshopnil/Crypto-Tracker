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
    let coin: CoinModel
    @StateObject private var vm: CoinDetailViewModel
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let spacing: CGFloat = 30
    
    init(coin: CoinModel) {
        self.coin = coin
        _vm = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 28) {
                LineGraphView(coin: coin)
                    .frame(height: 150)
                
                // Overview Section
                SectionView(title: "Overview", content: {
                    overviewGrid()
                })
                
                // Additional Details Section
                SectionView(title: "Additional Details", content: {
                    additionalGrid()
                })
            }
            .padding()
        }
        .navigationTitle(coin.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Text(coin.symbol.uppercased())
                        .font(.caption)
                        .foregroundStyle(.gray)
                    IconView(url: coin.image)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(coin: .placeHolder)
    }
}

private extension DetailView {
    
    // Reusable Section View for Title and Content
    struct SectionView<Content: View>: View {
        let title: String
        let content: () -> Content
        
        var body: some View {
            VStack(spacing: 12) {
                Text(title)
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
                
                content() // Dynamic content passed from parent
            }
        }
    }
    
    private func overviewGrid() -> some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            content: {
                ForEach(vm.overviewStatistics) { stat in
                    StatisticsView(stat: stat)
                }
            }
        )
    }
    
    private func additionalGrid() -> some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            content: {
                ForEach(vm.additionalStatistics) { stat in
                    StatisticsView(stat: stat)
                }
            }
        )
    }
}
