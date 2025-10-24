//
//  CustomBottomModal.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 12/10/25.
//

import SwiftUI

struct CustomBottomModal: View {
    
    @Environment(ApplicationBottomModal.self) var applicationBottomModal
    
    var body: some View {
        GeometryReader { geometry in
            
            let size = geometry.size
            
            VStack {
                VStack {
                    Text(self.applicationBottomModal.message)
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(self.applicationBottomModal.secondaryMessage)
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.6))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 5)
                    
                    HStack {
                        Text(self.applicationBottomModal.primaryButtonText)
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .glassEffect(.regular.tint(.appPrimary).interactive(), in: .rect(cornerRadius: 12.0))
                            .contentShape(.rect(cornerRadius: 12.0))
                            .onTapGesture {
                                self.applicationBottomModal.primaryAction()
                            }
                        
                        Text(self.applicationBottomModal.secondaryButtonText)
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .glassEffect(.regular.tint(.red).interactive(), in: .rect(cornerRadius: 12.0))
                            .contentShape(.rect(cornerRadius: 12.0))
                            .onTapGesture {
                                self.applicationBottomModal.secondaryAction()
                            }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 10)
                    .padding(.bottom, 15)
                }
                .padding(25)
                .frame(maxWidth: .infinity, alignment: .leading)
                .glassEffect(.regular, in: UnevenRoundedRectangle(cornerRadii: .init(topLeading: 20, bottomLeading: 50, bottomTrailing: 50, topTrailing: 20)))
                .ignoresSafeArea()
                .offset(y: self.applicationBottomModal.isVisible ? 0 : size.height)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .background(.black.opacity(self.applicationBottomModal.isVisible ? 0.8 : 0))
            .ignoresSafeArea()
            .allowsHitTesting(self.applicationBottomModal.isVisible ? true : false)
            .onTapGesture {
                self.applicationBottomModal.hideBottomModal()
            }
        }
    }
}
