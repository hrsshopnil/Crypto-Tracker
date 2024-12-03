//
//  HomeViewModle.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 29/11/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = [.placeHolder]
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var stats = [StatisticsModel(title: "Market Cap", value: "34Tr", percentageChange: 34.5),
                            StatisticsModel(title: "24h Volume", value: "62Bn"),
                            StatisticsModel(title: "BTC Dominance", value: "12Tr"),
                            StatisticsModel(title: "Portfolio Value", value: "34Tr", percentageChange: -14.5)]
    
    var cancellables: Set<AnyCancellable> = []
    private var coinService = CoinDataService()
    
    init() {
        fetchAllCoins()
    }
    
    private func fetchAllCoins() {
        $searchText
            .combineLatest(coinService.$allCoins)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] coins in
                self?.allCoins = coins
            }.store(in: &cancellables)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else { return coins }
        
        let lowerCasedText = text.lowercased()
        
        return coins.filter { coin -> Bool in
            return coin.name.lowercased().contains(lowerCasedText) || coin.symbol.lowercased().contains(lowerCasedText) || coin.id.lowercased().contains(lowerCasedText)
        }
    }
}
