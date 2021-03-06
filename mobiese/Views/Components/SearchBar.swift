//
//  SearchBar.swift
//  mobiese
//
//  Created by Shaashop on 2022/01/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack{
            TextField("Search...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
        }.overlay(HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 15)
     
            if self.text.count > 0 {
                Button(action: {
                    self.text = ""
                }) {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 20)
                }
            }
        })
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
