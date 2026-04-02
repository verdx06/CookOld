//
//  SearchBar.swift
//  CulinarApp
//
//  Created by Варя Черепенникова on 01.04.2026.
//

import SwiftUI

struct SearchBar: View {
    @FocusState private var isFocused: Bool
    @Binding var searchText: String
    let onSearch: () -> Void
     
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color(.black))
            
            TextField("Найти рецепт...", text: $searchText)
                .focused($isFocused)
                .foregroundColor(.primary)
                .onChange(of: searchText) {
                    onSearch()
                }
                .onSubmit {
                    onSearch()
                }
            
            if isFocused {
                Button(action: {
                    searchText = ""
                    isFocused = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.black)
                }
            }
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal, 16)
        .scaleEffect(isFocused ? 1.02 : 1.0)
        .animation(.spring(duration: 0.3, bounce: 0.5), value: isFocused)
    }
    
}






