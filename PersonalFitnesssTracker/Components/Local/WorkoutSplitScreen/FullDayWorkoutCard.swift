//
//  FullDayWorkoutCard.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 09/10/25.
//

import SwiftUI

struct FullDayWorkoutCard: View {
    
    var dailyWorkoutPlan: DailyWorkout
    var currentDay: DayName
    
    
    
    @State var isExpanded: Bool = false
    
    init(dailyWorkoutPlan: DailyWorkout, currentDay: DayName) {
        self.dailyWorkoutPlan = dailyWorkoutPlan
        self.currentDay = currentDay
        _isExpanded = State(initialValue: self.currentDay == self.dailyWorkoutPlan.forDay ? true : false)
    }
    
    var body: some View {
        VStack {
            
            // MARK: Header
            HStack {
                Text(self.dailyWorkoutPlan.forDay.rawValue.uppercased())
                    .antonFont(with: 15)
                    .foregroundStyle(self.currentDay == self.dailyWorkoutPlan.forDay ? .black : .appPrimary)
                
                Spacer()
                
                HStack {
                    Image(systemName: "chevron.down")
                        .scaleEffect(0.7)
                        .foregroundStyle(self.currentDay == self.dailyWorkoutPlan.forDay ? .appPrimary : .white)
                        .rotationEffect(.degrees(self.isExpanded ? 180 : 0))
                }
                .frame(width: 35, height: 35)
                .if(self.currentDay == self.dailyWorkoutPlan.forDay) { view in
                    view.background(.black, in: Circle())
                }
                .if(self.currentDay != self.dailyWorkoutPlan.forDay) { view in
                    view.glassButtonBackground(withRoundness: 100) {
                        withAnimation {
                            self.isExpanded.toggle()
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            
            
            // MARK: Exercises
            if self.isExpanded {
                VStack(spacing: 10) {
                    ForEach(Array(self.dailyWorkoutPlan.exercises.enumerated()), id: \.offset) { index, exercise in
                        ExerciseStructureButton(index: index, exercise: exercise.key, isClickable: false, wantDarkMode: self.currentDay == self.dailyWorkoutPlan.forDay)
                    }
                    
                }
                .padding(.horizontal)
                .padding(.bottom)
                .transition(.offset(y: 200))
                
            }
        }
        .frame(maxWidth: .infinity)
        .if(self.currentDay == self.dailyWorkoutPlan.forDay) { view in
            view.background(.appPrimary, in: RoundedRectangle(cornerRadius: 12))
        }
        .if(self.currentDay != self.dailyWorkoutPlan.forDay) { view in
            view.background(.white.opacity(0.02), in: RoundedRectangle(cornerRadius: 12))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.white.opacity(0.15))
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onTapGesture {
            withAnimation {
                self.isExpanded.toggle()
            }
        }
    }
}
