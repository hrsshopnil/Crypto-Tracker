//
//  CoinDetailViewModel.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 24/12/24.
//

import Foundation
import Combine

class CoinDetailViewModel: ObservableObject {
    
    @Published var overviewStatistics: [StatisticsModel] = []
    @Published var additionalStatistics: [StatisticsModel] = []
    
    @Published var coin: CoinModel
    private let detailService: CoinDetailDataService
    private var cancellables: Set<AnyCancellable> = []
    
    
    
    init(coin: CoinModel) {
        self.coin = coin
        detailService = CoinDetailDataService(coin: coin)
        addSubscriber()
    }
    
    ///Subsricibing to the Coin Detail
    private func addSubscriber() {
        detailService.$coinDetail
            .combineLatest($coin)
            .map { [weak self] coinDetailModel, coinModel in
                let overview = self?.createOverviewStatistics(from: coinModel)
                let additional = self?.createAdditionalStatistics(from: coinModel, detail: coinDetailModel)
                return (overview: overview ?? [], additional: additional ?? [])
            }
            .sink { [weak self] coinDetail in
                self?.overviewStatistics = coinDetail.overview
                self?.additionalStatistics = coinDetail.additional
            }
            .store(in: &cancellables)
    }

    ///Overview Statistics
    private func createOverviewStatistics(from coinModel: CoinModel) -> [StatisticsModel] {
        return [
            createStatistic(title: "Current Price", value: coinModel.currentPrice.asCurrencyWith2Decimals(), percentageChange: coinModel.priceChangePercentage24H),
            createStatistic(title: "Market Capitalization", value: "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? ""), percentageChange: coinModel.marketCapChangePercentage24H),
            createStatistic(title: "Rank", value: "\(coinModel.rank)"),
            createStatistic(title: "Volume", value: "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? ""))
        ]
    }

    ///Additional Statistics
    private func createAdditionalStatistics(from coinModel: CoinModel, detail: CoinDetailModel?) -> [StatisticsModel] {
        return [
            createStatistic(title: "24h High", value: coinModel.high24H?.asCurrencyWith2Decimals() ?? "n/a"),
            createStatistic(title: "24h Low", value: coinModel.low24H?.asCurrencyWith2Decimals() ?? "n/a"),
            createStatistic(title: "24h Price Change", value: coinModel.priceChange24H?.asCurrencyWith2Decimals() ?? "n/a", percentageChange: coinModel.priceChangePercentage24H),
            createStatistic(title: "24h Market Cap Change", value: "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? ""), percentageChange: coinModel.marketCapChangePercentage24H),
            createStatistic(title: "Block Time", value: detail?.blockTimeInMinutes.map { "\($0)" } ?? "n/a"),
            createStatistic(title: "Hashing Algorithm", value: detail?.hashingAlgorithm ?? "n/a")
        ]
    }

    ///Statistics Array
    private func createStatistic(title: String, value: String, percentageChange: Double? = nil) -> StatisticsModel {
        return StatisticsModel(title: title, value: value, percentageChange: percentageChange)
    }

}
