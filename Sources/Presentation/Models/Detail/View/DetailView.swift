//
//  DetailView.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 06.04.2026.
//

import SwiftUI

struct DetailView: View
{
    let initialMeal: Meal
    @State private var viewModel: DetailViewModel
    @State private var isFavorite = false

    init(initialMeal: Meal, viewModel: DetailViewModel) {
        self.initialMeal = initialMeal
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        Group {
            switch self.viewModel.contentState {
            case .idle, .loading:
                ProgressView("Загрузка…")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .loaded:
                content(meal: self.viewModel.meal ?? self.initialMeal)
            case .failed(let message):
                ErrorStateView(detailMessage: message) {
                    Task { await self.viewModel.retry() }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) { favoriteButton }
        }
        .onAppear {
            Task { await self.viewModel.loadContent() }
        }
    }
}

private extension DetailView
{
    func content(meal: Meal) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                hero(meal: meal)
                titleBlock(meal: meal)
                ingredientsSection(meal: meal)
                instructionsSection(meal: meal)
            }
        }
        .refreshable {
            await self.viewModel.loadContent()
        }
        .ignoresSafeArea(edges: .top)
    }

    func hero(meal: Meal) -> some View {
        AsyncImage(url: URL(string: meal.strMealThumb)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            default:
                PreviewRectangle(cornerRadius: 0)
            }
        }
        .frame(height: 300)
        .frame(maxWidth: .infinity)
        .clipped()
        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: 0,
                bottomLeadingRadius: Constants.heroCorner,
                bottomTrailingRadius: Constants.heroCorner,
                topTrailingRadius: 0,
                style: .continuous
            )
        )
    }

    var favoriteButton: some View {
        Button {
            // TODO: - Добавить действие для добавления в избранно
            isFavorite.toggle()
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(isFavorite ? Color.red : Color.primary.opacity(0.9))
        }
        .buttonStyle(.plain)
    }

    func titleBlock(meal: Meal) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(meal.strMeal)
                .font(.title.bold())
                .foregroundStyle(.primary)

            HStack(alignment: .firstTextBaseline, spacing: 16) {
                if let category = meal.strCategory {
                    HStack(spacing: 6) {
                        Image(systemName: "square.grid.2x2")
                        Text(category)
                    }
                }
                if let area = meal.strArea {
                    HStack(spacing: 6) {
                        Image(systemName: "globe")
                        Text(area)
                    }
                }
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)

            if let tag = meal.strCategory {
                Text(tag)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(Constants.accentTag, in: Capsule())
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, Constants.horizontalPadding)
        .padding(.top, 20)
    }

    func ingredientsSection(meal: Meal) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(.detailIngredients)
                .font(.title2.bold())
                .foregroundStyle(.primary)
                .padding(.top, 28)

            let rows = meal.ingredientRows
            ForEach(Array(rows.enumerated()), id: \.offset) { _, row in
                HStack(alignment: .firstTextBaseline) {
                    Text(row.name)
                        .font(.body)
                        .foregroundStyle(.primary)
                    Spacer(minLength: 12)
                    Text(row.measure)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.trailing)
                }
                .padding(.vertical, 4)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, Constants.horizontalPadding)
    }

    func instructionsSection(meal: Meal) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(.detailInstructions)
                .font(.title3.bold())
                .foregroundStyle(.primary)

            Text(meal.strInstructions ?? "")
                .font(.body)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Constants.instructionCard, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .padding(.horizontal, Constants.horizontalPadding)
        .padding(.top, 24)
        .padding(.bottom, 32)
    }
}

// MARK: - Constants
private extension DetailView
{
    enum Constants
    {
        static let heroCorner: CGFloat = 24
        static let horizontalPadding: CGFloat = 20
        static let accentTag = Color(red: 1, green: 0.44, blue: 0.26)
        static let instructionCard = Color(red: 0.96, green: 0.96, blue: 0.96)
    }
}
