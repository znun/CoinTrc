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
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    
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
