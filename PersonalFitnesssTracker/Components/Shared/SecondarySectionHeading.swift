//
//  SecondaySectionHeading.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 10/10/25.
//

import SwiftUI

struct SecondarySectionHeading: View {
    
    var heading: String
    var secondaryHeading: String?
    var topMargin: CGFloat = 15
    
    var body: some View {
        HStack {
            Text(self.heading)
                .antonFont(with: 15)
                .foregroundStyle(.white.opacity(0.5))
            
            if let secondaryHeading = self.secondaryHeading {
                Text(secondaryHeading)
                    .antonFont(with: 15)
                    .foregroundStyle(.appPrimary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, self.topMargin)
    }
}
