//
//  CoinDataService.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 1/12/24.
//

import Foundation

class CoinDataService: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    var manager = NetworkManager()
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        
        manager.fetchData(from: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h", decodingTo: [CoinModel].self) {[weak self] result in
            do {
                self?.allCoins = try result.get()
            } catch {
                print(error)
            }
        }
    }
}
