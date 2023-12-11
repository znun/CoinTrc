//
//  SearchBarView.swift
//  CoinTrc
//
//  Created by Mahmudul Hasan on 11/12/23.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .padding(.horizontal,5)
                .foregroundColor(searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundColor(Color.theme.accent)
//                .overlay() {
//                    Image(systemName: "xmark.circle.fill")
//                        .padding()
//                        .foregroundColor(Color.theme.accent)
//                }
        }
        .frame(height: 50)
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.15),
                    radius: 10, x:0, y: 0
                )
                .padding()
            
        )
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            SearchBarView(searchText: .constant(""))
                .previewLayout(.sizeThatFits)
        }
    }
}

