//
//  PortfolioItem.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 7/12/24.
//

import Foundation
import SwiftData

@Model
class PortfolioItem {
    var coinId: String
    var currentHoldings: Double
    
    init(coinId: String, currentHoldings: Double) {
        self.coinId = coinId
        self.currentHoldings = currentHoldings
    }
}
