//
//  WorkoutSplitScreen.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 08/10/25.
//

import SwiftUI

struct WorkoutSplitScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(ApplicationWorkoutStates.self) var applicationWorkoutStates
    
    
    var currentDay: DayName
    
    var currentDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyy"
        return dateFormatter.string(from: Date())
    }
    
    
    
    
    var body: some View {
        CustomSheetView<VStack, HStack>(
            heading: "Weekly Split",
            content: {
                VStack {
                    
                    Text("All your workouts for the week’s split will appear here, complete with detailed exercises and routines for each day.")
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .padding(.top)
                        .onAppear {
                            print(self.currentDay)
                        }
                   
                    SectionHeading(
                        heading: "Today Day".uppercased(),
                        secondaryHeading: self.currentDate
                    )
                    
                    let currentDayWorkout: DailyWorkout = self.applicationWorkoutStates.weeklySplit.filter({ $0.forDay == self.currentDay }).first!
                    
                    FullDayWorkoutCard(dailyWorkoutPlan: currentDayWorkout, currentDay: self.currentDay)
                    
                    SectionHeading(
                        heading: "Other Days".uppercased()
                    )

                    
                    ForEach(Array(self.applicationWorkoutStates.weeklySplit.enumerated()), id: \.offset) { index_t, day in
                        if day.forDay != self.currentDay {
                            FullDayWorkoutCard(dailyWorkoutPlan: day, currentDay: self.currentDay)
                        }
                    }
                    
                }
            },
            secondaryContent: {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "ellipsis")
                            .frame(width: 30, height: 30)
                    }
                    .buttonStyle(.glass)
                }
            },
            margin: ApplicationMarginPadding.current.scrollViewHorizontalMargin
        )
    }
}


