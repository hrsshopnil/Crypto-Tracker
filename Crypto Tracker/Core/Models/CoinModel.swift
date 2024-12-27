//
//  CoinModel.swift
//  Crypto Tracker
//
//  Created by shopnil hasan on 27/11/24.
//


import Foundation

// CoinGecko API info
/*
 URL: https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 
 */

import Foundation

struct CoinModel: Identifiable, Codable, Hashable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H: Double?
    let priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    func updateHoldings(amount: Double) -> CoinModel {
        return CoinModel(
            id: id,
            symbol: symbol,
            name: name,
            image: image,
            currentPrice: currentPrice,
            marketCap: marketCap,
            marketCapRank: marketCapRank,
            fullyDilutedValuation: fullyDilutedValuation,
            totalVolume: totalVolume,
            high24H: high24H,
            low24H: low24H,
            priceChange24H: priceChange24H,
            priceChangePercentage24H: priceChangePercentage24H,
            marketCapChange24H: marketCapChange24H,
            marketCapChangePercentage24H: marketCapChangePercentage24H,
            circulatingSupply: circulatingSupply,
            totalSupply: totalSupply,
            maxSupply: maxSupply,
            ath: ath,
            athChangePercentage: athChangePercentage,
            athDate: athDate,
            atl: atl,
            atlChangePercentage: atlChangePercentage,
            atlDate: atlDate,
            lastUpdated: lastUpdated,
            sparklineIn7D: sparklineIn7D,
            priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency,
            currentHoldings: amount)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id) // Use unique properties
    }
    
    static func == (lhs: CoinModel, rhs: CoinModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
    
    static let placeHolder = CoinModel(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
        currentPrice: 61408,
        marketCap: 1141731099010,
        marketCapRank: 1,
        fullyDilutedValuation: 1285385611303,
        totalVolume: 67190952980,
        high24H: 61712,
        low24H: 56220,
        priceChange24H: 3952.64,
        priceChangePercentage24H: 6.87944,
        marketCapChange24H: 72110681879,
        marketCapChangePercentage24H: 6.74171,
        circulatingSupply: 18653043,
        totalSupply: 21000000,
        maxSupply: 21000000,
        ath: 61712,
        athChangePercentage: -0.97589,
        athDate: "2021-03-13T20:49:26.606Z",
        atl: 67.81,
        atlChangePercentage: 90020.24075,
        atlDate: "2013-07-06T00:00:00.000Z",
        lastUpdated: "2021-03-13T23:18:10.268Z",
        sparklineIn7D: SparklineIn7D(price: [
            100000.20797331037,
            98759.73785158253,
            97157.32411807193,
            96448.90175250097,
            97634.61744421945,
            98136.51932716771,
            97851.35377075805,
            97198.79685094622,
            96029.7899967946,
            97516.2050419872,
            97026.85826080089,
            96660.24567334302,
            97418.38122056802,
            97712.83000438925,
            95276.01330725009,
            94655.00770823027,
            94192.50465512306,
            92805.75666996102,
            93865.8516499566,
            95496.08297611057,
            95642.32275982088,
            96855.10107857324,
            96645.71101759745,
            97234.75395055958,
            97267.9383846706,
            97048.57278195025,
            96362.60195226806,
            96608.99778118312,
            97430.35276861327,
            97691.43431692653,
            97507.84162044193,
            97367.89389041727,
            97359.76640529782,
            97412.50918770437,
            97516.5221543344,
            98661.272804548,
            98675.03031457054,
            99063.71975920832,
            98615.89731302514,
            98538.76505417588,
            98108.60460263013,
            98037.11544014173,
            97377.54934648574,
            97358.57999864942,
            97128.48100400306,
            97470.60341011999,
            97288.66036256633,
            97603.55920607864,
            97286.59877093455,
            97092.14286004793,
            97411.02826020514,
            96941.26398149885,
            97048.2053474754,
            97244.35762866863,
            97172.66559153362,
            97005.50743627905,
            96623.52100166595,
            96902.3772340153,
            96081.76035559733,
            96291.03007140265,
            96686.00231297479,
            96153.042882627,
            96555.51567404097,
            96892.21545826268,
            96915.85584401232,
            97139.27539827072,
            96945.12552232458,
            96938.42533847172,
            95460.69620479741,
            95209.89915446886,
            95668.34560923881,
            95544.50786640248,
            95891.77545961997,
            94642.4145986112,
            95496.25262170903,
            95033.93282605492,
            95454.72024777101,
            95110.22476004054,
            94249.37064248421,
            94348.83245934983,
            94632.91589043716,
            95932.78229351218,
            95739.5252308345,
            95496.09313363495,
            94776.84487073896,
            95329.18906870497,
            96017.0900413,
            95928.06581553773,
            96386.0794422067,
            95817.04472720862,
            96198.14433867254,
            94764.51142114567,
            93783.90817228667,
            93091.52827026883,
            93778.10358191631,
            93177.61328753472,
            92628.82282918232,
            92875.32894073278,
            93153.2599332778,
            93947.83041820853,
            95155.9932938399,
            94783.55282299334,
            94452.81486208398,
            94022.76657471212,
            93731.97579417886,
            94226.32288231308,
            94288.7786212906,
            94437.02811928229,
            93696.2286655834,
            94430.24704023327,
            93904.34514336252,
            93843.22864300416,
            93847.45149049634,
            94231.12625982042,
            94180.71055672027,
            95848.57730898821,
            97238.80611762808,
            98151.72570799723,
            98540.00714964255,
            98943.52498215239,
            98678.08559817578,
            97505.34132629931,
            97744.89154299659,
            98562.58601531523,
            98758.15555154771,
            98695.71400782601,
            98500.26067034216,
            97799.22367036463,
            98185.17824587427,
            97939.63300496976,
            98166.14843598155,
            98256.56321230729,
            98017.71510715655,
            97939.25170926686,
            97972.34608014901,
            98096.99301652769,
            98336.47528260502,
            97825.05610463647,
            98116.90414721801,
            98360.53224699968,
            98574.10579870746,
            98507.38795680397,
            98322.23617320624,
            98625.17641832161,
            98676.48814762365,
            98930.64036374552,
            99144.05633754666,
            98436.17536077047,
            99141.93981786452,
            99344.95417367229,
            98949.44292464617,
            98936.89534325956,
            98686.78953052338,
            98659.98368388147,
            98104.91726778065,
            98247.92246369661,
            98015.2331340629,
            96688.97259453255,
            95759.02291449787,
            95362.2899789659,
            95392.89411753211,
            95536.07804721202,
            95344.33579308933,
            95875.25001897622,
            95280.08348787813,
            95969.09729102344,
            96462.6594887941
        ]),
        priceChangePercentage24HInCurrency: 3952.64,
        currentHoldings: 1.5)
}


struct SparklineIn7D: Codable, Equatable, Hashable {
    let price: [Double]?
}
