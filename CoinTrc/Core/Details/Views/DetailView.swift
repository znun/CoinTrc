//
//  DetailView.swift
//  CoinTrc
//
//  Created by Mahmudul Hasan on 17/12/23.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: CoinModel?
    
    var body: some View {
        if let coin = coin {
           DetailView(coin: coin)
        }
    }

}

struct DetailView: View {
    
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        print("Coin name: \(coin.name)")
    }
    
    var body: some View {
            Text(coin.name)
   
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
