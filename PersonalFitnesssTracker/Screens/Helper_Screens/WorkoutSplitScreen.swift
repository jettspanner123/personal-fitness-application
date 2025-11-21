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
    
    @State var showEditSplitScreen: Bool = false
    
    
    var currentDay: DayName
    
    var currentDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyy"
        return dateFormatter.string(from: Date())
    }
    
    
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                
                Text("All your workouts for the week’s split will appear here, and completed with detailed exercises and routines for each day.")
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.white.opacity(0.5))
                    .padding(.top, -40)
                
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
        }
        .padding(.horizontal, ApplicationMarginPadding.current.scrollViewHorizontalMargin)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    self.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .scaleEffect(0.9)
                }
            }
            
            
            ToolbarItem(placement: .principal) {
                Text("Weekly Split".uppercased())
                    .antonFont(with: 25)
            }
           
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    self.showEditSplitScreen = true
                }) {
                    Image(systemName: "ellipsis")
                        .scaleEffect(0.9)
                }
            }
        }
        .sheet(isPresented: self.$showEditSplitScreen) {
            NavigationStack {
                EditWorkoutSplitScreen()
            }
        }
    }
}


