//
//  PersonalFitnesssTrackerApp.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 07/10/25.
//

import SwiftUI
import SwiftData

@main
struct PersonalFitnesssTrackerApp: App {
    @State var applicationWorkoutStates: ApplicationWorkoutStates = .init()
    @State var applicationHealthManager: ApplicationHealthKitManager = .init()
    @State var applicationKeyboardObserver: KeyboardOvserver = .init()
    @State var applicationToast: ApplicationToast = .init()
    @State var applicationBottomModal: ApplicationBottomModal = .init()
    
    @State var showSplashScreen: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            
            
            // MARK: Custom Toast Overlay
            
                .overlay(alignment: .leading) {
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
            
            
            
            
            // MARK: Custom Bottom Modal
                .overlay {
                   CustomBottomModal()
                }
        }
        .environment(self.applicationWorkoutStates)
        .environment(self.applicationHealthManager)
        .environment(self.applicationKeyboardObserver)
        .environment(self.applicationToast)
        .environment(self.applicationBottomModal)
    }
}
