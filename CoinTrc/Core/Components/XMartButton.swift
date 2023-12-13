//
//  XMartButton.swift
//  CoinTrc
//
//  Created by Mahmudul Hasan on 13/12/23.
//

import SwiftUI

struct XMartButton: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
        presentationMode.wrappedValue.dismiss()
    }, label: {
        Image(systemName: "xmark")
            .font(.headline)
        
    })
    }
}

struct XMartButton_Previews: PreviewProvider {
    static var previews: some View {
        XMartButton()
    }
}
