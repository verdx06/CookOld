//
//  DishBuilderView.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 01.04.2026.
//

import SwiftUI

struct DishBuilderView: View
{
    @State var viewModel: DishBuilderViewModel
    @State private var showAnimation = false

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(.craftTitle)
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                Text(.craftDescription)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 16)
                    .font(.system(size: 14))
            }

            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("ingredients_finder".localized(), text: $viewModel.searchText)
                if viewModel.searchText.isEmpty == false {
                    Button(.cancel) {
                        viewModel.searchText = ""
                    }
                    .foregroundColor(.blue)
                }
            }
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 16)

            // Chosen chips — outside vertical ScrollView to avoid gesture conflict
            if viewModel.chosenIngredients.isEmpty == false {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(viewModel.chosenIngredients) { ingredient in
                            IngredientSmallCardView(
                                ingredient: ingredient,
                                onClick: {
                                    withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                        viewModel.toggle(ingredient)
                                    }
                                }
                            )
                            .transition(AnyTransition.scale(scale: 0.8).combined(with: AnyTransition.opacity))
                        }
                    }
                    .padding(.horizontal, 16)
                }
                Rectangle()
                    .fill(Color(.separator))
                    .frame(height: 0.5)
                    .padding(.horizontal, 8)
                    .transition(.opacity)
            }

            ZStack {
                switch viewModel.state {
                case .success:
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 12) {
                            ForEach(viewModel.availableIngredients) { ingredient in
                                IngredientCardView(
                                    ingredient: ingredient,
                                    onClick: {
                                        withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                            viewModel.toggle(ingredient)
                                        }
                                    },
                                    isChosen: false
                                )
                                .transition(AnyTransition.scale(scale: 0.85).combined(with: AnyTransition.opacity))
                            }
                        }
                        .padding(.horizontal, 16)
                        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: viewModel.chosen)
                    }
                    .refreshable {
                        await viewModel.reload()
                    }

                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            LetHimCookButton {
                                showAnimation = true
                            }
                        }
                    }
                    .padding(16)
                case .loading:
                    Text(.loadingIngredients)
                case .failure(let error):
                    ErrorStateView(detailMessage: error.localizedDescription)
                case .empty:
                    EmptyStateView()
                }
            }
        }
        .navigationDestination(isPresented: $viewModel.showCooked) {
            CookedView(chosen: viewModel.allChosenIngredients, network: viewModel.network)
        }
        .overlay {
            if showAnimation {
                AnimationView {
                    showAnimation = false
                    viewModel.showCooked = true
                }
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: showAnimation)
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: viewModel.chosen)
        .frame(maxWidth: .infinity, alignment: .leading)
        .task {
            await viewModel.reload()
        }
    }
}

#Preview {
    let dbvm = DishBuilderViewModel(network: NetworkService())
    return DishBuilderView(viewModel: dbvm)
}
