//
//  CardDishView.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 01.04.2026.
//

import SwiftUI

struct CardDishView: View
{
    let title: String
    let image: URL?
    let category: String
    let area: String
    let isFavorite: Bool
    let onFavoriteTap: () -> Void

    var body: some View {
        self.content
    }
}

private extension CardDishView
{
    static let imageHeight: CGFloat = 168
    static let cornerRadius: CGFloat = 22

    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topTrailing) {
                self.imageSection
                self.favoriteButton
                    .padding(12)
            }
            .frame(height: Self.imageHeight)
            .frame(maxWidth: .infinity)
            .clipped()

            self.textSection
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: Self.cornerRadius, style: .continuous))
        .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
    }

    @ViewBuilder
    var imageSection: some View {
        if let url = image {
            LoadableImage(url: url)
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            Image(systemName: "photo")
                .foregroundStyle(.secondary)
        }
    }

    var textSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(self.title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
                .multilineTextAlignment(.leading)
                .lineLimit(2)

            self.metaRow
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
    }

    var metaRow: some View {
        HStack(alignment: .firstTextBaseline, spacing: 16) {
            if let categoryText = Self.nonEmpty(self.category) {
                HStack(spacing: 6) {
                    Image(systemName: "square.grid.2x2")
                    Text(categoryText)
                }
            }
            if let areaText = Self.nonEmpty(self.area) {
                HStack(spacing: 6) {
                    Image(systemName: "globe")
                    Text(areaText)
                }
            }
        }
        .font(.caption)
        .foregroundStyle(.secondary)
    }

    static func nonEmpty(_ raw: String) -> String? {
        let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }

    @ViewBuilder
    var favoriteButton: some View {
        Button {
            self.onFavoriteTap()
        } label: {
            Image(systemName: self.isFavorite ? "heart.fill" : "heart")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(self.isFavorite ? Color.red : Color.primary.opacity(0.85))
                .padding(8)
                .background(.ultraThinMaterial, in: Circle())
        }
        .buttonStyle(.borderless)
        .accessibilityLabel("Favorite")
    }
}
