//
//  PortfolioView.swift
//  CoinTrc
//
//  Created by Mahmudul Hasan on 13/12/23.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckMark: Bool = false
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        LazyHStack(spacing: 10) {
                            ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                                CoinLogoView(coin: coin)
                                    .frame(width: 75)
                                    .padding(4)
                                    .onTapGesture {
                                        withAnimation(.easeIn) {
                                            selectedCoin = coin
                                        }
                                    }
                                    .background (
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
                                    )
                            }
                        } .frame(height: 120)
                          .padding(.leading)
                    })
                    
                    if selectedCoin != nil {
                        VStack(spacing: 20) {
                            HStack {
                                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? "")")
                                Spacer()
                                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
                            }
                            Divider()
                            HStack {
                                Text("Amount of your portfolio:")
                                Spacer()
                                TextField("Ex: 1.4", text: $quantityText)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.decimalPad)
                            }
                            Divider()
                            HStack {
                                Text("Current value:")
                                Spacer()
                                Text(getCurrentValue().asCurrencyWith2Decimals())
                            }
                        } .animation(.none)
                          .padding()
                          .font(.headline)
                    }
                }
            }
                .navigationTitle("Edit Portfolio")
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading){
                        XMartButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing){
                        HStack(spacing: 10) {
                            Image(systemName: "checkmark")
                                .opacity(showCheckMark ? 1.0 : 0.0)
                            Button(action:{
                                saveButtonPressed()
                            },label: {
                                Text("save".uppercased())
                            })
                            .opacity(
                                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText))  ? 1.0 : 0.0
                            )
                                
                        }
                    }
                })
         }
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func saveButtonPressed() {
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
            else {return}
        
        //save to portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        //show checkmark
        withAnimation(.easeIn) {
            showCheckMark = true
            removeSelectedCoin()
        }
        
        //hide keyboard
        //UIApplication.shared.endEditing()
        
        //hide check mark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckMark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}
