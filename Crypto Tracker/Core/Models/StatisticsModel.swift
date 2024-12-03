//
//  StatisticsModel.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 3/12/24.
//

import Foundation

struct StatisticsModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
    
    static let placeHolder1 = StatisticsModel(title: "Market Cap", value: "$23B")
    static let placeHolder2 = StatisticsModel(title: "Market Cap", value: "$45Tr", percentageChange: -34.5)
}
