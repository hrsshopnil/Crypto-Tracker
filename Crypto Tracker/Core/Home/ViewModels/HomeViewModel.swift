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
    
    var cancellables: Set<AnyCancellable> = []
    private var coinService = CoinDataService()
    
    init() {
        fetchAllCoins()
    }
    
    private func fetchAllCoins() {
        coinService.$allCoins.sink { [weak self] coins in
            self?.allCoins = coins
        }.store(in: &cancellables)
    }
    
}
