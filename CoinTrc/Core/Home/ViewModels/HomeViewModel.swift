//
//  HomeViewModel.swift
//  CoinTrc
//
//  Created by Mahmudul Hasan on 6/12/23.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    
    @Published var statistics : [StatisticModel] = [
        StatisticModel(title: "title", value: "value", percentageChange: 1),
        StatisticModel(title: "title", value: "value"),
        StatisticModel(title: "title", value: "value"),
        StatisticModel(title: "title", value: "value", percentageChange: -8)
        ]
    
    @Published var allCoins : [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    @Published var searchText = ""
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        //Search Coin
        
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }

        let lowerCasedText = text.lowercased()

       return coins.filter { (coin) in
            return coin.name.lowercased().contains(lowerCasedText) ||
                   coin.symbol.lowercased().contains(lowerCasedText) ||
                   coin.id.lowercased().contains(lowerCasedText)
        }

    }
    
}
