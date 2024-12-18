//
//  HomeViewModle.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 29/11/24.
//

import Foundation
import Combine
import SwiftData
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = [.placeHolder]
    @Published var portfolioCoins: [CoinModel] = []
    @Published var myCoins: [PortfolioItem] = []
    @Published var searchText: String = ""
    @Published var stats: [StatisticsModel] = []
    
    
    var cancellables: Set<AnyCancellable> = []
    private var coinService = CoinDataService()
    private var marketService = MarketDataService()
    var context: ModelContext? = nil
    //@Published var myCoins: [PortfolioItem] = [PortfolioItem(coinId: "ethereum", currentHoldings: 2),
    //                                           PortfolioItem(coinId: "ripple", currentHoldings: 3)]
    
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
        
        $allCoins
            .combineLatest($myCoins)
            .map(getHoldings)
            .sink { [weak self] recievedCoins in
                self?.portfolioCoins = recievedCoins
            }
            .store(in: &cancellables)
        
        marketService.$marketData
            .combineLatest($portfolioCoins)
            .map(getMarketData)
            .sink {[weak self] stats in
                self?.stats = stats
            }.store(in: &cancellables)
    }
    
    ///Filtering Coins as per Search Text
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else { return coins }
        
        let lowerCasedText = text.lowercased()
        
        return coins.filter { coin -> Bool in
            return coin.name.lowercased().contains(lowerCasedText) || coin.symbol.lowercased().contains(lowerCasedText) || coin.id.lowercased().contains(lowerCasedText)
        }
    }
    
    ///Filtering Coins for user Portfolio
    private func getHoldings(allCoins: [CoinModel], portfolioItem: [PortfolioItem]) -> [CoinModel] {
        allCoins
            .compactMap { coin -> CoinModel? in
                guard let entity = portfolioItem.first(where: { $0.coinId == coin.id }) else { return nil }
                return coin.updateHoldings(amount: entity.currentHoldings)
            }
        
    }
    
    ///Mapping Market Data
    private func getMarketData(data: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticsModel] {
        guard let data else { return [] }
        
        let portfolioValue = portfolioCoins
            .map { $0.currentHoldingsValue }
            .reduce(0, +)
        
        let previousValue = portfolioCoins
            .map { coin -> Double in
                let currentValue = coin.currentHoldingsValue
                let pricehange = coin.priceChangePercentage24H ?? 0
                let percentChange = pricehange / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        
        let change = ((portfolioValue - previousValue) / previousValue) * 100
        
        return [
            StatisticsModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd),
            StatisticsModel(title: "24h Volume", value: data.volume),
            StatisticsModel(title: "BTC Dominance", value: data.btcDominance),
            StatisticsModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: change)
        ]
    }
    
    ///Fetching the Coins
    func fetchMyCoins() {
        let fetchDescriptor = FetchDescriptor<PortfolioItem>(
            sortBy: [SortDescriptor(\.currentHoldings, order: .forward)]
        )
        
        do {
            if let safeContext = context {
                myCoins = try safeContext.fetch(fetchDescriptor)
            }
        } catch {
            print("Error fetching tasks: \(error.localizedDescription)")
        }
    }
}
