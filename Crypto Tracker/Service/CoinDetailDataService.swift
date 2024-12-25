//
//  CoinDetailDataService.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 24/12/24.
//

import Foundation

class CoinDetailDataService: ObservableObject {
    
    @Published var coinDetail: CoinDetailModel? = nil
    let coin: CoinModel
    
    var manager = NetworkManager()
    
    init(coin: CoinModel) {
        self.coin = coin
        getDetails()
    }
    
    func getDetails() {
        
        manager.fetchData(from: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false", decodingTo: CoinDetailModel.self) {[weak self] result in
            do {
                self?.coinDetail = try result.get()
                print(self?.coinDetail?.name)
            } catch {
                print(error)
            }
        }
    }
}
