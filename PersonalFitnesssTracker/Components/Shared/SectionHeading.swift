//
//  SectionHeading.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 09/10/25.
//

import SwiftUI

struct SectionHeading: View {
    var heading: String
    var secondaryHeading: String?
    var topMargin: CGFloat = 15
    
    var body: some View {
        HStack {
            Text(self.heading)
                .antonFont(with: 25)
            
            if let secondaryHeading = self.secondaryHeading {
                Text(secondaryHeading)
                    .antonFont(with: 25)
                    .foregroundStyle(.appPrimary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, self.topMargin)
        .padding(.bottom, -1)
    }
}
