//
//  SearchBarView.swift
//  EfcRickMorty
//
//  Created by efulgencio on 22/4/24.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    @Binding var clearSearch: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.secondary : Color.accentColor
                )
            
            TextField("Introducir nombre para filtar ...", text: $searchText)
                .font(.system(size: 16))
                .foregroundColor(Color.accentColor)
                .disableAutocorrection(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.accentColor)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                            clearSearch = true
                        }
                    
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .shadow(
                    color: Color.accentColor.opacity(0.15),
                    radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""), clearSearch: .constant(false))
}

