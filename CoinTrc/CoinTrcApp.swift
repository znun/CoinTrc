//
//  CoinTrcApp.swift
//  CoinTrc
//
//  Created by Mahmudul Hasan on 23/10/23.
//

import SwiftUI

@main
struct CoinTrcApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
              HomeView()
                    .navigationBarHidden(false)
                
            }
            .environmentObject(vm)
        }
    }
}
