//
//  SearchView.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 01.04.2026.
//

import SwiftUI

struct SearchView: View {
    @State private var vm : SearchViewModel
    
    init(vm: SearchViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(searchText: $vm.searchText, onSearch: {
                    Task { await vm.searchMeals() }
                })
                .padding(.top, 8)
                SearchContentView(vm: vm)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .onChange(of: vm.searchText) {
                vm.scheduleSearch()
            }
        }
    }
}


#Preview {
    SearchView(
        vm: SearchViewModel(
            repository: SearchRepositoryImpl(
                service: NetworkService()
            )
        )
    )
}


