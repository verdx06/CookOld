//
//  CookedView.swift
//  CulinarApp
//
//  Created by eventya on 09.04.2026.
//

import SwiftUI

struct CookedView: View {
    var chosen: [String]
    @State private(set) var state: ResponseStates = .empty
    let network: Network
    let makeDetailViewModel: (String) -> DetailViewModel

    @Environment(\.favoriteViewModel) private var favoriteViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(.whatWeFound)
                .font(.largeTitle)
                .bold()
                .padding(.horizontal, 16)
                .padding(.top, 10)

            switch state {
            case .empty:
                EmptyStateView()
            case .loading:
                Text(.loadingRecipes)
            case .failure(let error):
                ErrorStateView(detailMessage: error.localizedDescription)
            case .success:
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(state.allMeals) { meal in
                            let stamped = favoriteViewModel.stamped(meal)
                            NavigationLink {
                                DetailView(viewModel: makeDetailViewModel(meal.idMeal))
                            } label: {
                                CardDishView(meal: stamped) {
                                    favoriteViewModel.toggleLike(meal)
                                }
                                .padding(.horizontal)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .task {
            await fetchMeals()
        }
    }

    private func fetchMeals() async {
        guard state.isLoading == false else { return }
        do {
            let response: MealResponse = try await network.requestData(
                url: "/filter.php",
                params: ["i": chosen.joined(separator: ",")]
            )
            state = .success(response.meals ?? [])
        } catch {
            state = .failure(error)
        }
    }

    enum ResponseStates {
        case success([Meal])
        case loading
        case failure(Error)
        case empty

        var isLoading: Bool {
            if case .loading = self { return true }
            return false
        }

        var allMeals: [Meal] {
            if case .success(let meals) = self { return meals }
            return []
        }
    }
}

#Preview {
    CookedView(
        chosen: ["Chicken", "Garlic"],
        network: NetworkService(),
        makeDetailViewModel: { _ in fatalError("stub") }
    )
}
