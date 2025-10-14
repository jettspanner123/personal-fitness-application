//
//  TimerScreen.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 14/10/25.
//

import SwiftUI

struct TimerScreen: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var picker: Date = .now
    
    var body: some View {
        ZStack {
            ScrollView {
                Text("Select any timer preset or create your own for the timer to start. This is for your recovery between the sets.")
                    .pageDescription()
                
                DatePicker(
                    "", selection: self.$picker,
                    displayedComponents: .hourAndMinute
                )
                .datePickerStyle(.wheel)
                .labelsHidden()
                
                SecondarySectionHeading(heading: "PRESETS")

            }
            .fullScreenHeightWidth()
            .contentMargins(ApplicationMarginPadding.current.scrollViewHorizontalMargin)
        }
        .fullScreenHeightWidth()
        .toolbar {
            // MARK: Main Title
            
            ToolbarItem(placement: .principal) {
                Text("Workout TIMER".uppercased())
                    .antonFont(with: 25)
            }
        }
    }
}
