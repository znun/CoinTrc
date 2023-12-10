//
//  CoinImageService.swift
//  CoinTrc
//
//  Created by Mahmudul Hasan on 10/12/23.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {

    @Published var image:UIImage?
    var imageSubscription: Cancellable?
    private let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        guard let url = URL (string:coin.image) else {
            return
        }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
           .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImages) in
                self?.image = returnedImages
                self?.imageSubscription?.cancel()
            })
    }
}
