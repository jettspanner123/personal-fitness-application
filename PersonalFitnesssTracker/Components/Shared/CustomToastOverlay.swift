//
//  CustomToastOverlay.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 22/10/25.
//

import SwiftUI

struct CustomToastOverlay: View {
    
    @Environment(ApplicationToast.self) var applicationToast
    var body: some View {
        VStack {
            VStack {
                Text(self.applicationToast.message)
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                
                if let secondaryToastMessage = self.applicationToast.secondaryMessage {
                    Text(secondaryToastMessage)
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.8))
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .glassEffect(.regular.tint(.red).interactive())
            .padding(.horizontal, ApplicationMarginPadding.current.scrollViewHorizontalMargin)
            .offset(y: self.applicationToast.showToast ? 0 : -200)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            LinearGradient(gradient: .init(colors: [.black, .clear]), startPoint: .init(x: 0.5, y: 0), endPoint: .init(x: 0.5, y: 0.2))
                .opacity(self.applicationToast.showToast ? 1 : 0)
        )
        .allowsHitTesting(false)
    }
}
