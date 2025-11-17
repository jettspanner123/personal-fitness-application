//
//  WorkoutScreen.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 07/10/25.
//

import SwiftUI

struct WorkoutScreen: View {
    
    @Environment(ApplicationWorkoutStates.self) var applicationWorkoutStates
    
    @State var showWorkoutSplitSheet: Bool = false
    @State var showAllExercises: Bool = false
    @State var showAddExercisePage: Bool = false
    @State var showCreateWorkoutPage: Bool = false
    @State var showTimerPage: Bool = false
    @State var showWorkoutJournalPage: Bool = false
    
    let screen = UIScreen()
    
    var currentDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy | EEEE"
        return formatter.string(from: Date())
    }
    
    
    func getDayToday() -> DayName {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return DayName(rawValue: dateFormatter.string(from: .now).lowercased())!
    }
    
    var currentDayWorkout: DailyWorkout {
        let currentDay: DayName = self.getDayToday()
        return self.applicationWorkoutStates.weeklySplit.filter({ $0.forDay == currentDay }).first!
    }
    
    var targetCaloriesBurnedViaWorkout: Double {
        var totalReps: Int = .zero
        
        for exercise in self.currentDayWorkout.exercises {
            totalReps += exercise.key.reps.reduce(0) { return $0 + $1 }
        }
        return Double(totalReps) * 0.4
    }
    
    var actualCaloriesBurnedViaWorkout: Double {
        var totalReps: Int = .zero
        
        for exercise in self.currentDayWorkout.exercises {
            if exercise.value {
                totalReps += exercise.key.reps.reduce(0) { return $0 + $1 }
            }
        }
        return Double(totalReps) * 0.4
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            // MARK: Current Date and Day
            Text(self.currentDate)
                .foregroundStyle(.black)
                .font(.system(size: 12))
                .monospaced()
                .padding(5)
                .background(.appPrimary, in: RoundedRectangle(cornerRadius: 3))
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(y: 10)
            
            
            // MARK: Page heading
            HStack {
                Text("Workout Plan".uppercased())
                    .antonFont(with: 40)
                Spacer()
                
                
                Button(action: { self.showWorkoutSplitSheet = true }) {
                    Image(systemName: "gear")
                        .frame(width: 30, height: 30)
                        .contentShape(Circle())
                }
                .buttonStyle(.glass)
                .overlay {
                    GeometryReader { proxy in
                        Button(action: { self.showWorkoutSplitSheet = true }) {
                            Image(systemName: "house.fill")
                                .frame(width: 30, height: 30)
                                .contentShape(Circle())
                        }
                        .buttonStyle(.glass)
                        .offset(y: -proxy.size.height - 5)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            // MARK: Todays workout details
            HStack {
                Text(self.currentDayWorkout.name)
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                
                Spacer()
                
                Text(String(format: "%.1f", self.targetCaloriesBurnedViaWorkout))
                    .antonFont(with: 20)
                    .foregroundStyle(.appPrimary)
                Text("kCal")
                    .antonFont(with: 20)
                Text("🔥")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.appDark.opacity(0.6), in: RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.white.opacity(0.15))
            }
            
            
            HStack {
                
                VStack {
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .glassEffect(in: .rect(cornerRadius: 12.0))

                VStack {
                    
                    
                    
                    
                    
                    // MARK: Timer Button
                    
                    HStack {
                       Image(systemName: "clock.fill")
                            .foregroundStyle(.black)
                            .padding()
                    }
                    .frame(width: 80)
                    .frame(maxHeight: .infinity)
                    .glassEffect(.regular.tint(.appPrimary).interactive())
                    .contentShape(Capsule())
                    .onTapGesture {
                        self.showTimerPage = true
                    }
                    
                    
                    
                    
                    
                    // MARK: Notes button
                    
                    HStack {
                       Image(systemName: "pencil.tip.crop.circle.fill")
                            .padding()
                    }
                    .frame(width: 80)
                    .frame(maxHeight: .infinity)
                    .glassEffect(.regular.interactive())
                    .contentShape(Capsule())
                    .onTapGesture {
                        self.showWorkoutJournalPage = true
                    }
                }
                .frame(maxHeight: .infinity)
            }
            
            SectionHeading(heading: "NEXT WORKOUT", secondaryHeading: self.currentDayWorkout.isRestDay != nil ? "[ REST DAY ]" : "[ \(self.currentDayWorkout.exercises.count) EXERCISES ]")
            
            if currentDayWorkout.isRestDay != nil {
                VStack(spacing: -20) {
                    Image(systemName: "figure.cooldown")
                        .resizable()
                        .frame(width: 50, height: 60)
                    ContentUnavailableView("It's a Rest Day!", image: "", description: Text("Please take time to hydrate your body and perform some streaches."))
                }
                .padding(.top, 25)
                .opacity(0.75)
            } else {
                ForEach(Array(self.currentDayWorkout.exercises.prefix(2).enumerated()), id: \.offset) { index, exercise in
                    ExerciseStructureButton(index: index, exercise: exercise.key)
                }
                
                if self.showAllExercises {
                    ForEach(Array(self.currentDayWorkout.exercises.dropFirst(2).enumerated()), id: \.offset) { index, exercise in
                        ExerciseStructureButton(index: index+2, exercise: exercise.key)
                            .transition(.blurReplace.combined(with: .scale))
                    }
                }
                
                Button(action: {
                    withAnimation {
                        self.showAllExercises.toggle()
                    }
                }) {
                    if self.showAllExercises {
                        Text("Show Less")
                            .frame(maxWidth: .infinity)
                            .transition(.blurReplace)
                    } else {
                        Text("+\(self.currentDayWorkout.exercises.count - 2) More")
                            .frame(maxWidth: .infinity)
                            .transition(.blurReplace)
                    }
                }
                .buttonStyle(.glass)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            
            
            
            
            
            
            
            // MARK: Alternative workout things
            SectionHeading(heading: "ALTERNATE WORKOUT")
            
            HStack {
                CustomButton(text: "Add Exercise", image: "plus") {
                    self.showAddExercisePage = true
                }
                
                CustomButton(text: "Create Workout", image: "pencil.and.outline") {
                    self.showCreateWorkoutPage = true
                }
                
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 1)
            
            SectionHeading(heading: "Water Intake".uppercased())
            
            VStack {
                
            }
            .frame(height: 200)
            .frame(maxWidth: .infinity)
            .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 12.0))
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .contentMargins(ApplicationMarginPadding.current.scrollViewHorizontalMargin)
        .navigationDestination(isPresented: self.$showAddExercisePage) {
            AddExercisesScreen()
        }
        .navigationDestination(isPresented: self.$showCreateWorkoutPage) {
            CreateWorkoutScreen()
        }
        .navigationDestination(isPresented: self.$showTimerPage) {
            TimerScreen()
        }
        .navigationDestination(isPresented: self.$showWorkoutJournalPage) {
            TodoScreen(currentDay: self.getDayToday())
        }
        .sheet(isPresented: self.$showWorkoutSplitSheet) {
            WorkoutSplitScreen(currentDay: self.getDayToday())
        }
    }
}



struct CustomButton: View {
    var text: String
    var image: String
    var action: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            HStack {
                Image(systemName: self.image)
            }
            .frame(width: 40)
            .frame(maxHeight: .infinity)
            .background(.appPrimary)
            
            HStack {
                Text(self.text)
                    .font(.system(size: 13, weight: .regular, design: .rounded))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 55)
        .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 12.0, bottomLeading: 12.0)))
        .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 12.0))
        .onTapGesture {
            self.action()
        }
    }
}
