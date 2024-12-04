//
//  MarketDataService.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 4/12/24.
//

import Foundation

class MarketDataService: ObservableObject {
    
    @Published var marketData: MarketDataModel? = nil
    var manager = NetworkManager()
    
    init() {
        getCoins()
    }
    
    private func getCoins() {
        
        manager.fetchData(from: "https://api.coingecko.com/api/v3/global", decodingTo: GlobalData.self) {[weak self] result in
            do {
                let returned = try result.get()
                self?.marketData = returned.data
            } catch {
                print(error)
            }
        }
    }
}

