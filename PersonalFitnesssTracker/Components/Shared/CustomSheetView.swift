//
//  CustomSheetView.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 07/10/25.
//

import SwiftUI

struct CustomSheetView<Content: View , SecondaryContent: View>: View {
    
    @Environment(\.dismiss) var dismiss
    var heading: String
    var content: Content?
    var secondarButton: SecondaryContent?
    var margin: CGFloat
    
    init(heading: String, content: (() -> Content)? = nil, secondaryContent: (() -> SecondaryContent)? = nil, margin: CGFloat = 25) {
        self.heading = heading
        self.content = content?()
        self.secondarButton = secondaryContent?()
        self.margin = margin
    }
    
    
    
    
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                
                
                
                // MARK: This is the header of the page
                HStack {
                    
                    Button(action: { self.dismiss() }) {
                        Image(systemName: "xmark")
                            .frame(width: 30, height: 30)
                    }
                    .buttonStyle(.glass)
                    
                    Spacer()
                    
                    Text(self.heading.uppercased())
                        .antonFont(with: 25)
                    
                    Spacer()
                    
                    if let sB = self.secondarButton {
                        sB
                    } else {
                        Button(action: { self.dismiss() }) {
                            Image(systemName: "ellipsis")
                                .frame(width: 30, height: 30)
                        }
                        .buttonStyle(.glass)
                        .opacity(0)
                        .disabled(true)
                    }
                    
                }
                
                
                
                // MARK: Actual Content
                if let content = self.content {
                    content
                }
            }
            .contentMargins(self.margin)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.appDark)
    }
}

