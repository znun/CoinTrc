//
//  DetailViewModel.swift
//  CoinTrc
//
//  Created by Mahmudul Hasan on 26/12/23.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscriber()
    }
    
    private func addSubscriber() {
        coinDetailService.$coinDetails
            .sink { (returnedCoinDetails) in
                print("RECEIVED COIN DETAIL DATA")
                print(returnedCoinDetails)
            } .store(in: &cancellables)
    }
}
