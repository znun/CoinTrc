//
//  HomeStatsView.swift
//  CoinTrc
//
//  Created by Mahmudul Hasan on 11/12/23.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    let statistics : [StatisticModel] = [
    StatisticModel(title: "title", value: "value", percentageChange: 1),
    StatisticModel(title: "title", value: "value"),
    StatisticModel(title: "title", value: "value"),
    StatisticModel(title: "title", value: "value", percentageChange: -8)
    
    ]
    
    @Binding var showPortfolio: Bool
    var body: some View {
        HStack{
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPortfolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
