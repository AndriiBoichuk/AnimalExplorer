//
//  FactPageView.swift
//  AnimalExplorer
//
//  Created by Andrii Boichuk on 12.07.2024.
//

import SwiftUI
import Kingfisher
import ComposableArchitecture

struct FactPageView: View {
    let store: StoreOf<FactPageFeature>
    
    let isNextDisabled: Bool
    let isPrevDisabled: Bool
    
    var body: some View {
        VStack(spacing: Constant.Spacing.main) {
            makeContentView(imageUrl: store.factInfo.image,
                            fact: store.factInfo.fact)
            makeButtonsView()
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal, Constant.Padding.horizontal)
    }
}

#Preview {
    FactPageView(store: .init(
        initialState: FactPageFeature.State(factInfo: .mock),
        reducer: { FactPageFeature() }), isNextDisabled: true, isPrevDisabled: false)
    .frame(width: 300)
}

// MARK: - Constants

extension FactPageView {
    enum Constant {
        enum Spacing {
            static let main: CGFloat = 17
        }
        
        enum Padding {
            static let imageMain: CGFloat = 10
            static let buttonMain: CGFloat = 20
            static let horizontal: CGFloat = 20
        }
        
        enum Height {
            static let button: CGFloat = 52
            static let image: CGFloat = 252
        }
    }
}

// MARK: - Subviews

extension FactPageView {
    @ViewBuilder
    func makeContentView(imageUrl: URL?, fact: String) -> some View {
        VStack(spacing: Constant.Spacing.main) {
            KFImage(imageUrl)
                .placeholder({ progress in
                    ProgressView(value: Double(progress.fractionCompleted))
                })
                .resizable()
                .scaledToFit()
                .frame(height: Constant.Height.image)
            Text(fact)
                .font(.aeBody)
                .lineLimit(6, reservesSpace: true)
        }
        .padding([.horizontal, .top], Constant.Padding.imageMain)
    }
    
    func makeButtonsView() -> some View {
        HStack {
            makeButtonView(Image(.prevPage), isDisabled: isPrevDisabled) {
                store.send(.prevPage)
            }
            Spacer()
            makeButtonView(Image(.nextPage), isDisabled: isNextDisabled) {
                store.send(.nextPage)
            }
        }
        .padding([.bottom, .horizontal], Constant.Padding.buttonMain)
    }
    
    func makeButtonView(_ image: Image, isDisabled: Bool, action: @escaping () -> Void) -> some View {
        Button {
            withAnimation(.easeInOut) {
                action()
            }
        } label: {
            image
                .resizable()
                .scaledToFit()
                .frame(height: Constant.Height.button)
        }
        .opacity(isDisabled ? 0.4 : 1)
        .disabled(isDisabled)
    }
}
