//
//  Extentions.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 09/10/25.
//

import SwiftUI
import Foundation

extension Text {
    func antonFont(with size: CGFloat) -> some View {
        self
            .font(.custom(ApplicationFonts.anton, size: size))
    }
    
    func sheetHeading() -> some View {
        self
            .antonFont(with: 25)
    }
    
    func pageDescription() -> some View {
        self
            .font(.system(size: 13, weight: .regular, design: .rounded))
            .foregroundStyle(.white.opacity(0.5))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func applicationButtons(color tintColor: Color = .clear) -> some View {
        self
            .font(.system(size: 15, weight: .regular, design: .rounded))
            .padding(.horizontal)
            .padding(.vertical, 13)
            .frame(maxWidth: .infinity)
            .glassEffect(.regular.tint(tintColor).interactive(), in: .rect(cornerRadius: 12.0))
            .transition(.blurReplace)
    }
}

extension View {
    
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool,
                             transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    func glassButtonBackground(withRoundness roundness: CGFloat, action: @escaping () -> Void = {}, scale: CGFloat = 1.3) -> some View {
        self
            .background {
                Button(action: action) {
                    HStack {
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .scaleEffect(scale)
                .buttonStyle(.glass)
                .clipShape(RoundedRectangle(cornerRadius: roundness))
                .overlay {
                    RoundedRectangle(cornerRadius: roundness)
                        .stroke(.white.opacity(0.15))
                }
            }
    }
    
    func fullScreenHeightWidth() -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func fullWidthLeading() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension TextField {
    func applicationTextField() -> some View {
        self
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 12.0))
    }
}


extension UINavigationController: UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
