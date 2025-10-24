import SwiftUI

struct AddExercisesScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(ApplicationWorkoutStates.self) var applicationWorkoutStates
    @Environment(ApplicationToast.self) var applicationToast
    @Environment(ApplicationBottomModal.self) var applicationBottomModal
    
    @Namespace var animationNamespace
    
    @State var text: String = ""
    @FocusState var keyboardFocusState: Bool
    
    
    var showSearchedExercises: Bool {
        return self.text.isEmpty
    }
    
    var searchedExercises: Array<Exercise> {
        return Exercises.all.filter { exercise in
            let searchName: String = self.text.lowercased()
            let exerciseName: String = exercise.name.lowercased()
            return (searchName == exerciseName) || (exerciseName.contains(searchName))
        }
    }
    
    func handleBackButtonTap() -> Void {
        if !self.applicationWorkoutStates.currentDayAlternateExercises.isEmpty {
            self.applicationBottomModal.showBottomModal(
                message: "Wanna Quit? Bitch!",
                secondaryMessage: "Quiting now will mean that all your progress will be lost forever.",
                primaryButtonText: "Continue",
                secondaryButtonText: "Exit",
                primaryAction: {
                    self.applicationBottomModal.hideBottomModal()
                },
                secondaryAction: {
                    self.dismiss()
                }
            )
            return
        }
        
        self.dismiss()
    }
    
    func createWorkoutWithExercises() -> Void {
        if self.applicationWorkoutStates.currentDayAlternateExercises.isEmpty {
            self.applicationToast.showToast(message: "No Exercises Added", secondaryMessage: "Please add atleast one before creating the workout.")
            return
        }
    }
    
    func handleAddExercise(exercise: Exercise) -> Void {
        if self.applicationWorkoutStates.currentDayAlternateExercises.contains(exercise) { return }
        
        withAnimation {
            self.applicationWorkoutStates.currentDayAlternateExercises.append(exercise)
        }
    }
    
    func handleRemoveExercise(exercise: Exercise) -> Void {
        if !self.applicationWorkoutStates.currentDayAlternateExercises.contains(exercise) { return }
        
        withAnimation {
            self.applicationWorkoutStates.currentDayAlternateExercises.removeAll(where: {$0.name == exercise.name})
        }
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView(showsIndicators: false) {
                
                // MARK: Page Description
                
                Text("Adding exercises here will neglect the existing day's plan and workout as a whole. Add with caution!")
                    .pageDescription()
                    
                
                
                // MARK: Exercise Text
                
                TextField("Enter Exercise Name", text: self.$text)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 12.0))
                    .padding(.top, 5)
                    .focused(self.$keyboardFocusState)
                
                
                
                
                
                
                
                
                if self.showSearchedExercises {
                    
                    
                    
                    // MARK: Content Not Available
                    
                    if self.applicationWorkoutStates.currentDayAlternateExercises.isEmpty {
                        VStack(spacing: -20) {
                            Image(systemName: "figure.run")
                                .resizable()
                                .frame(width: 50, height: 70)
                            ContentUnavailableView(
                                "No Exercises Added Yet",
                                systemImage: "",
                                description: Text("Try adding a exercise by searching it through the search bar.")
                            )
                        }
                        .opacity(0.5)
                        .padding(.top, 50)
                    }
                    
                    
                    
                    // MARK: Exercises if added to the list
                    
                    else {
                        SectionHeading(heading: "Added Exercises".uppercased())
                            .padding(.top)
                        
                        
                        ForEach(Array(self.applicationWorkoutStates.currentDayAlternateExercises.enumerated()), id: \.offset) { index, exercise in
                            AddExerciseAlternateWorkoutCard(index: index+1, exercise: exercise, type: .add) {
                            }
                        }
                    }
                }
                
               
                // MARK: Result for the searched exercises
                
                else {
                    
                    VStack {
                        SectionHeading(heading: "RESULT FOR: ", secondaryHeading: self.text.split(separator: " ").first?.uppercased() ?? self.text)
                            .padding(.top)
                        ForEach(Array(self.searchedExercises.enumerated()), id: \.offset) { index, exercise in
                            let condition: Bool = self.applicationWorkoutStates.currentDayAlternateExercises.contains(exercise)
                            
                            AddExerciseAlternateWorkoutCard(index: index+1, exercise: exercise, type: condition ? .delete : .add) {
                                if condition {
                                    self.handleRemoveExercise(exercise: exercise)
                                } else {
                                    self.handleAddExercise(exercise: exercise)
                                }
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentMargins(ApplicationMarginPadding.current.scrollViewHorizontalMargin)
            .scrollDismissesKeyboard(.immediately)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            
            
            
            // MARK: Back Button
            
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    self.handleBackButtonTap()
                }) {
                    Image(systemName: "chevron.left")
                        .scaleEffect(0.9)
                }
                .contentShape(Circle())
            }
            
            // MARK: Main Title
            
            ToolbarItem(placement: .principal) {
                Text("Add Exercise".uppercased())
                    .antonFont(with: 25)
            }
            
            
            
            // MARK: Create Wokrout button
            
            ToolbarItem(placement: .bottomBar) {
                Button(action: {
                    self.createWorkoutWithExercises()
                }) {
                    Text("create workout".uppercased())
                        .fontWeight(.regular)
                        .frame(maxWidth: .infinity)
                        .contentShape(.rect(cornerRadius: 12.0))
                }
                .frame(maxWidth: .infinity)
            }
            
            
            
            
            // MARK: Dismiss keyboard button
            
            if self.keyboardFocusState {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { withAnimation { self.keyboardFocusState = false } }) {
                        Image(systemName: "keyboard.chevron.compact.down.fill")
                            .scaleEffect(0.85)
                    }
                }
                .matchedTransitionSource(id: "dismiss_keyboard", in: self.animationNamespace)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct AddExerciseAlternateWorkoutCard: View {
    
    @Environment(ApplicationWorkoutStates.self) var applicationWorkoutStates
    
    var index: Int
    var exercise: Exercise
    var type: AddExerciseAlternateWorkoutCardType = .add
    var action: () -> Void
    
    init(index: Int, exercise: Exercise, type: AddExerciseAlternateWorkoutCardType, action: @escaping () -> Void) {
        self.index = index
        self.exercise = exercise
        self.type = type
        self.action = action
    }
    
    var body: some View {
        HStack {
            
            
            // MARK: Index number
            HStack {
                Text(String(self.index))
                    .antonFont(with: 20)
                    .foregroundStyle(.black)
                
                
            }
            .frame(width: 55, height: 50)
            .background(.appPrimary, in: Circle())
            
            
            
            
            // MARK: Info Area
            
            VStack {
                Text(self.exercise.name)
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundStyle(.white)
                    .padding()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 55)
            .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 12.0))
            
            
            
            
            // MARK: Action button
            
            if self.type == .add {
                HStack {
                    Image(systemName: "checkmark")
                }
                .frame(width: 55, height: 50)
                .glassEffect(.regular.tint(.blue).interactive(), in: Capsule())
                .contentShape(Capsule())
                .transition(.offset(x: 70))
                .onTapGesture {
                    self.action()
                }
            } else {
                HStack {
                    Image(systemName: "xmark.bin.fill")
                }
                .frame(width: 55, height: 50)
                .glassEffect(.regular.tint(.red).interactive(), in: Capsule())
                .contentShape(Capsule())
                .transition(.offset(x: 70))
                .onTapGesture {
                    self.action()
                }
            }
            
            
        }
        .frame(maxWidth: .infinity)
    }
}

enum AddExerciseAlternateWorkoutCardType {
    case add, delete
}
