//
//  PersonalFitnesssTrackerApp.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 07/10/25.
//

import SwiftUI
import SwiftData


struct ApplicationOption {
    var id: String = UUID().uuidString
    var name: String
    var backgroundColor: Color
    var icon: String
    var view: AnyView
    
    static var allCases: Array<ApplicationOption> {
        return [
            .init(name: "Fitness And Diet", backgroundColor: .appPrimary, icon: "workout", view: AnyView(ContentView())),
            .init(name: "Productivity", backgroundColor: .appDark, icon: "workout", view: AnyView(EmptyView())),
            .init(name: "Consistancy", backgroundColor: .appBlue, icon: "workout", view: AnyView(EmptyView())),
        ]
    }
}

@main
struct PersonalFitnesssTrackerApp: App {
    @State var applicationWorkoutStates: ApplicationWorkoutStates = .init()
    @State var applicationHealthManager: ApplicationHealthKitManager = .init()
    @State var applicationKeyboardObserver: KeyboardOvserver = .init()
    @State var applicationToast: ApplicationToast = .init()
    @State var applicationBottomModal: ApplicationBottomModal = .init()
    
    
    @State var showSelectedApplicationOption: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            // MARK: Custom Toast Overlay
                .overlay(alignment: .leading) {
                    CustomToastOverlay()
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


