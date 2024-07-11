//
//  AnimalItemView.swift
//  AnimalExplorer
//
//  Created by Andrii Boichuk on 11.07.2024.
//

import SwiftUI
import Kingfisher

struct AnimalItemView: View {
    let animal: Animal
    
    var body: some View {
        HStack(spacing: Constant.Spacing.main) {
            makeImageView(from: animal.image)
            VStack(alignment: .leading) {
                makeHeaderView(title: animal.title,
                               subtitle: animal.description)
                Spacer()
                if let status = animal.status {
                    makeStatusLabelView(from: status)
                }
            }
        }
        .padding(Constant.Padding.small)
        .background {
            Color.white
                .shadow(radius: 3, y: 3)
        }
        .overlay {
            ZStack(alignment: .trailing) {
                Color.aeBlack60
                Image(.comingSoon)
                    .resizable()
                    .scaledToFit()
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: Constant.cornerRadius))
    }
}

#Preview {
    AnimalItemView(animal: .mock)
}

// MARK: Constants

private extension AnimalItemView {
    enum Constant {
        static let cornerRadius: CGFloat = 8
        
        enum Size {
            static let imageHeight: CGFloat = 90
            static let imageWidth: CGFloat = 121
            static let lockIconHeight: CGFloat = 12
        }
        
        enum Padding {
            static let small: CGFloat = 5
        }
        
        enum Spacing {
            static let main: CGFloat = 17
            static let status: CGFloat = 4
        }
    }
}

// MARK: - Subviews

private extension AnimalItemView {
    func makeImageView(from imageUrl: URL?) -> some View {
        KFImage(imageUrl)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: Constant.Size.imageWidth,
                   maxHeight: Constant.Size.imageHeight)
            .clipped()
    }
    
    func makeHeaderView(title: String, subtitle: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundStyle(Color.aeBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(subtitle)
                .foregroundStyle(Color.aeBlack50)
        }
    }
    
    @ViewBuilder
    func makeStatusLabelView(from status: Animal.Status) -> some View {
        switch status {
        case .paid:
            HStack(spacing: Constant.Spacing.status) {
                Image(.lock)
                    .resizable()
                    .scaledToFit()
                    .frame(height: Constant.Size.lockIconHeight)
                Text("Premium")
                    .foregroundStyle(.aeBlue)
            }
        case .free:
            EmptyView()
        }
    }
}
