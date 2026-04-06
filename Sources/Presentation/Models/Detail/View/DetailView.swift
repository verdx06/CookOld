//
//  DetailView.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 06.04.2026.
//

import SwiftUI

struct DetailView: View
{
    @Environment(\.dismiss) private var dismiss
    let meal: Meal
    @State private var isFavorite = false

    var body: some View {
        self.detailContent(meal: self.meal)
            .background(Color(.systemBackground))
            .toolbar(.hidden, for: .navigationBar)
    }
}

private extension DetailView
{
    static let heroHeight: CGFloat = 300
    static let heroCorner: CGFloat = 24
    static let accentTag = Color(red: 1, green: 0.44, blue: 0.26)
    static let instructionCard = Color(red: 0.96, green: 0.96, blue: 0.96)

    func detailContent(meal: Meal) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                self.hero(meal: meal)
                self.titleBlock(meal: meal)
                self.ingredientsSection(meal: meal)
                self.instructionsSection(meal: meal)
            }
        }
        .ignoresSafeArea(edges: .top)
    }

    func hero(meal: Meal) -> some View {
        ZStack(alignment: .top) {
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
            .frame(height: Self.heroHeight)
            .frame(maxWidth: .infinity)
            .clipped()
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: Self.heroCorner,
                    bottomTrailingRadius: Self.heroCorner,
                    topTrailingRadius: 0,
                    style: .continuous
                )
            )

            HStack {
                self.circleIconButton(
                    systemName: "chevron.left",
                    foreground: Color.primary.opacity(0.9)
                ) {
                    self.dismiss()
                }
                Spacer()
                self.circleIconButton(
                    systemName: self.isFavorite ? "heart.fill" : "heart",
                    foreground: self.isFavorite ? Color.red : Color.primary.opacity(0.9)
                ) {
                    self.isFavorite.toggle()
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 56)
        }
    }

    func circleIconButton(systemName: String, foreground: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(foreground)
                .padding(10)
                .background(.ultraThinMaterial, in: Circle())
        }
        .buttonStyle(.plain)
    }

    func titleBlock(meal: Meal) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(meal.strMeal)
                .font(.title.bold())
                .foregroundStyle(.primary)

            HStack(alignment: .firstTextBaseline, spacing: 16) {
                if let category = Self.nonEmpty(meal.strCategory) {
                    HStack(spacing: 6) {
                        Image(systemName: "square.grid.2x2")
                        Text(category)
                    }
                }
                if let area = Self.nonEmpty(meal.strArea) {
                    HStack(spacing: 6) {
                        Image(systemName: "globe")
                        Text(area)
                    }
                }
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)

            if let tag = Self.displayTag(for: meal) {
                Text(tag)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(Self.accentTag, in: Capsule())
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }

    func ingredientsSection(meal: Meal) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("detail_ingredients".localized())
                .font(.title2.bold())
                .foregroundStyle(.primary)
                .padding(.top, 28)

            let rows = Self.ingredientRows(for: meal)
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
        .padding(.horizontal, 20)
    }

    func instructionsSection(meal: Meal) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("detail_instructions".localized())
                .font(.title3.bold())
                .foregroundStyle(.primary)

            Text(Self.normalizedInstructions(meal.strInstructions))
                .font(.body)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Self.instructionCard, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .padding(.horizontal, 20)
        .padding(.top, 24)
        .padding(.bottom, 32)
    }

    static func nonEmpty(_ raw: String?) -> String? {
        guard let raw else { return nil }
        let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }

    static func displayTag(for meal: Meal) -> String? {
        if let tags = meal.strTags {
            let first = tags.split(separator: ",").first.map(String.init)?.trimmingCharacters(in: .whitespaces)
            if let first, first.isEmpty == false { return first }
        }
        return nonEmpty(meal.strCategory)
    }

    static func ingredientRows(for meal: Meal) -> [(name: String, measure: String)] {
        let ings = meal.ingredients
        let measures = meal.measures
        return ings.enumerated().map { index, name in
            (name, index < measures.count ? measures[index] : "")
        }
    }

    static func normalizedInstructions(_ raw: String?) -> String {
        guard let raw else { return "" }
        return raw
            .replacingOccurrences(of: "\r\n", with: "\n")
            .replacingOccurrences(of: "\r", with: "\n")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
