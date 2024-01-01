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
        ZStack{
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }

}

struct DetailView: View {

    @StateObject private var vm: DetailViewModel
    
    private let columns : [GridItem] = [
    
        GridItem(.flexible()),
        GridItem(.flexible())

    ]
    
    private var spacing: CGFloat = 30

    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Coin name: \(coin.name)")
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ChartView(coin: vm.coin)
                Text("Overview")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()

                LazyVGrid(
                    columns: columns,
                    alignment: .leading,
                    spacing: spacing,
                    pinnedViews: [],
                    content:{
                        ForEach(vm.overViewStatistics) { stat in
                            StatisticView(stat: stat)
                        }
                    })

                Text("Additional Details")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()

                LazyVGrid(
                    columns: columns,
                    alignment: .leading,
                    spacing: spacing,
                    pinnedViews: [],
                    content:{
                        ForEach(vm.additionalStatistics) { stat in
                            StatisticView(stat: stat)
                        }
                    })

            } .padding()
        } .navigationTitle(vm.coin.name)
            .toolbar { 
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Text(vm.coin.symbol.uppercased())
                            .font(.headline)
                            .foregroundColor(Color.theme.secondaryText)
                        CoinImageView(coin: vm.coin)
                            .frame(width: 25, height: 25)
                    }
                }
            }

    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailView(coin: dev.coin)
        }
    }
}


  

