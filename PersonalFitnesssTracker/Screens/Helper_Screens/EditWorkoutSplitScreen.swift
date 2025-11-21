//
//  EditWorkoutSplitScreen.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 17/11/25.
//

import SwiftUI

struct EditWorkoutSplitScreen: View {
    
    @Environment(ApplicationWorkoutStates.self) var applicationWorkoutStates
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Text("Changes to your workout split will apply globally. Edit carefully—there’s no undo. All changes become final once you confirm.")
                    .pageDescription()
                    .padding(.top, -40)
                
                VStack {
                    ForEach(Array(self.applicationWorkoutStates.weeklySplit.enumerated()), id: \.offset) { (index, dailyWorkout) in
                        EditWorkoutDayCard(dailyWorkoutIndex: index)
                            .padding(.top, index == 0 ? 10 : 0)
                    }
                }
                .frame(maxWidth: .infinity)
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
                Text("Edit Split".uppercased())
                    .antonFont(with: 25)
            }
            
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "checkmark")
                        .scaleEffect(0.9)
                }
                .tint(.appPrimary)
                .buttonStyle(.glassProminent)
            }
        }
    }
}

struct EditWorkoutDayCard: View {
    var dailyWorkoutIndex: Int
    @Environment(ApplicationWorkoutStates.self) var applicationWorkoutStates
    
    var dailyWorkout: DailyWorkout {
        return self.applicationWorkoutStates.weeklySplit[self.dailyWorkoutIndex]
    }
    
    @State var showEditDailyWorkoutScreen: Bool = false
    var body: some View {
        VStack {
            HStack {
                
                Text(String(self.dailyWorkout.forDay.rawValue.uppercased().first!))
                    .antonFont(with: 15)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.appPrimary, in: RoundedRectangle(cornerRadius: 5.0))
                    .padding(.trailing, 5)
                
                Text(self.dailyWorkout.forDay.rawValue.uppercased())
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                
                Text(String(format: "[%@]", self.dailyWorkout.name))
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                
                Spacer()
               
                HStack {
                   Image(systemName: "chevron.right")
                        .scaleEffect(0.7)
                }
                .frame(width: 35, height: 35)
                .glassEffect(.regular, in: Circle())
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .glassEffect(.regular.interactive(), in: RoundedRectangle(cornerRadius: 8.0))
        .navigationDestination(isPresented: self.$showEditDailyWorkoutScreen) {
            EditWorkoutDayScreen(dailyWorkoutIndex: self.dailyWorkoutIndex)
        }
        .onTapGesture {
            self.showEditDailyWorkoutScreen = true
        }
    }
}


struct EditWorkoutDayScreen: View {
    
    var dailyWorkoutIndex: Int
    @Environment(ApplicationWorkoutStates.self) var applicationWorkoutStates
    @Environment(KeyboardOvserver.self) var keyboardObserver
    
    let dayDropdownOptions: Array<String> = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday"
    ]
    
    func deleteExercise(exercise: Exercise) -> Void {
        let exerciseKey = exercise
        withAnimation {
            self.applicationWorkoutStates.weeklySplit[self.dailyWorkoutIndex].exercises.removeValue(forKey: exerciseKey)
        }
    }
    
    func saveWorkout() -> Void {
        
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            Text("Edit the name, day and other details about the workout. Add or remove exericses as needed.")
                .pageDescription()
            
            SecondarySectionHeading(heading: "Workout Name".uppercased())
            TextField("Workout Name", text: Binding(
                get: {
                    self.applicationWorkoutStates.weeklySplit[self.dailyWorkoutIndex].name
                },
                set: { newValue in
                    self.applicationWorkoutStates.weeklySplit[self.dailyWorkoutIndex].name = newValue
                }
            ))
            .applicationTextField()
            
            
            
            SecondarySectionHeading(heading: "For Which Day".uppercased())
            CustomDropDown(title: self.applicationWorkoutStates.weeklySplit[self.dailyWorkoutIndex].forDay.rawValue, options: self.dayDropdownOptions)
            
            HStack {
                Toggle("Is Rest Day", isOn: Binding(
                    get: {
                        self.applicationWorkoutStates.weeklySplit[self.dailyWorkoutIndex].isRestDay ?? false
                    },
                    set: { newValue in
                        self.applicationWorkoutStates.weeklySplit[self.dailyWorkoutIndex].isRestDay = newValue
                    }
                ))
            }
            .padding()
            .frame(maxWidth: .infinity)
            .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 12.0))
            
            SecondarySectionHeading(heading: "Exercises".uppercased())
            
            
            
            // MARK: Fallback for when the array is empty
            if self.applicationWorkoutStates.weeklySplit[self.dailyWorkoutIndex].exercises.isEmpty {
                VStack(spacing: -20) {
                    Image(systemName: "figure.cooldown")
                        .resizable()
                        .frame(width: 50, height: 60)
                    ContentUnavailableView("No Exercises for the day.", image: "", description: Text("Try adding exercises to the day."))
                }
                .padding(.top, 50)
                .opacity(0.75)
                .transition(.blurReplace)
            }
            
            ForEach(Array(self.applicationWorkoutStates.weeklySplit[self.dailyWorkoutIndex].exercises.keys.enumerated()), id: \.offset) { (index, exercise) in
                HStack {
                    ExerciseStructureButton(index: index, exercise: exercise)
                    
                    HStack {
                       Image(systemName: "xmark")
                            .padding()
                    }
                    .frame(maxHeight: .infinity)
                    .background(.red, in: RoundedRectangle(cornerRadius: 8.0))
                    .onTapGesture {
                        self.deleteExercise(exercise: exercise)
                    }
                }
                .transition(.offset(x: UIScreen.main.bounds.width))
                .animation(.default, value: self.applicationWorkoutStates.weeklySplit[self.dailyWorkoutIndex].exercises)
            }
        }
        .contentMargins(ApplicationMarginPadding.current.scrollViewHorizontalMargin)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Edit Workout".uppercased())
                    .antonFont(with: 25)
            }
            
            if self.keyboardObserver.isVisible {
                ToolbarItem(placement: .topBarTrailing) {
                    DismissKeyboardToolBarItem()
                        .transition(.blurReplace)
                }
                
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "checkmark")
                        .scaleEffect(0.9)
                }
                .tint(.appPrimary)
                .buttonStyle(.glassProminent)
            }
        }
    }
}

struct CustomDropDown: View {
    
    var title: String
    var options: Array<String>
    var expandedHeight: Double = 120
    
    @State var isExpanded: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text(self.title.prefix(1).uppercased() + self.title.dropFirst())
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .scaleEffect(0.9)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.white.opacity(0.001))
            .onTapGesture {
                withAnimation {
                    self.isExpanded.toggle()
                }
            }
            
            
            
            if self.isExpanded {
                VStack {
                    ForEach(self.options, id: \.self) { option in
                        Text(option)
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .glassEffect(.regular.tint(.white.opacity(0.05)).interactive(), in: RoundedRectangle(cornerRadius: 8.0))
                            .padding(.horizontal)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom)
                .transition(.offset(y: 100))
            }
        }
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 12.0))
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 12.0))
        .sensoryFeedback(.impact, trigger: self.isExpanded)
    }
}
