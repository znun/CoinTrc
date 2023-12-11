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
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
       
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("Retrieved image from fileManager")
        } else {
            downloadCoinImage()
            print("Downloading coin image")
        }
    }
    
    private func downloadCoinImage() {
        print("downloading image now")
        guard let url = URL (string:coin.image) else {
            return
        }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
           .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImages) in
               guard let self = self, let downloadedImage = returnedImages else {return}
                self.image = returnedImages
                self.imageSubscription?.cancel()
               self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
