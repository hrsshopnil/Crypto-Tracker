//
//  CoinDetailViewModel.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 24/12/24.
//

import Foundation

class CoinDetailViewModel: ObservableObject {
    @Published var detail: CoinDetailModel? = nil
    
    let detailService = CoinDetailDataService(coin: <#CoinModel#>)
    
    init() {
        detail = detailService.coinDetail
    }
}
