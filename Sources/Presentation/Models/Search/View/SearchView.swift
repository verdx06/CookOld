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
            .task {
                await vm.loadCategories()
            }
            .onAppear {
                vm.searchResult = .idle
                vm.searchText = ""
            }
            .onChange(of: vm.searchText) {
                guard !vm.isInCategoryMode else { return }
                vm.scheduleSearch()
            }
        }
    }
<<<<<<< HEAD
=======
    
    var categoriesHeader: some View {
        Text("Категории")
            .font(.title2)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
    }
    
    var preview: some View {
        ScrollView {
            categoriesHeader
            CategoryGridPreview()
                .padding(.horizontal)
        }
    }
>>>>>>> f590069 (Экран поиска)
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


