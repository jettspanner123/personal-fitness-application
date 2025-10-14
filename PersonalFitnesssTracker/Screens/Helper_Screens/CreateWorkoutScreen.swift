//
//  CreateWorkoutScreen.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 10/10/25.
//

import SwiftUI


struct CreateWorkoutScreen: View {
    
    @Environment(KeyboardOvserver.self) var applicationKeyboardObserver
    @Environment(ApplicationToast.self) var applicationToast
    
    @State var prompt: String = ""
    @State var selectedMuscles: Array<Muscle> = []
    @State var currentSelectedMuscleGroup: String = "Abdomin"
    @State var totalExercises: Int = .zero
    @State var totalSets: String = ""
    @State var totalReps: String = ""
    @State var currentSelectedPresetOption: Array<String> = []
    @State var customPreset: String = ""
    
    @State var isWorkoutLoading: Bool = false
    @State var showCreatedWorkoutScreen: Bool = false

    
    let muscleCompounds: Dictionary<String, Array<Muscle>> = [
        "Chest": Muscle.chestMuscles,
        "Back": Muscle.backMuscles,
        "Shoulders": Muscle.shoulderMuscles,
        "Legs": Muscle.legMuscles,
        "Arms": Muscle.armMuscles,
        "Abdomin": Muscle.absMuscles,
    ]
    
    @State var selectAllMusclesFor: Dictionary<String, Bool> = [
        "Chest": false,
        "Back": false,
        "Shoulders": false,
        "Legs": false,
        "Arms": false,
        "Abdomin": false,
    ]
    
    
    
    var currentSelectedMuscleGroupMuscles: Array<Muscle> {
        switch self.currentSelectedMuscleGroup {
        case "Chest": return Muscle.chestMuscles
        case "Back": return Muscle.backMuscles
        case "Legs": return Muscle.legMuscles
        case "Arms": return Muscle.armMuscles
        case "Abdomin": return Muscle.absMuscles
        case "Shoulders": return Muscle.shoulderMuscles
        default:
            return []
        }
    }
    
    var presetOptions: Array<String> = [
        "High Volume",
        "Low Volume",
        "Cardio Vascular",
        "Other"
    ]
    
    func getAllMusclesFor(muscleGroup: String) -> Array<Muscle> {
        switch muscleGroup {
        case "Chest": return Muscle.chestMuscles
        case "Back": return Muscle.backMuscles
        case "Legs": return Muscle.legMuscles
        case "Arms": return Muscle.armMuscles
        case "Abdomin": return Muscle.absMuscles
        case "Shoulders": return Muscle.shoulderMuscles
        default:
            return []
        }
    }
    
    func handlePresetClick(preset: String) -> Void {
        if preset.lowercased() == "other" {
            
            withAnimation {
                if self.currentSelectedPresetOption.contains(preset) {
                    self.currentSelectedPresetOption.removeAll(where: {$0 == preset})
                } else {
                    self.currentSelectedPresetOption.removeAll()
                    self.currentSelectedPresetOption.append(preset)
                }
            }
            
            return
        }
        
        withAnimation {
            if !self.currentSelectedPresetOption.contains(preset) {
                self.currentSelectedPresetOption.append(preset)
                
            } else {
                self.currentSelectedPresetOption.removeAll(where: { $0 == preset })
            }
        }
    }
    
    func handleMuscleClick(muscle: Muscle) -> Void {
        withAnimation {
            if !self.selectedMuscles.contains(muscle) {
                self.selectedMuscles.append(muscle)
            } else {
                self.selectedMuscles.removeAll(where: {$0 == muscle})
            }
        }
    }
    
    func handleSelectAllMusclesForGroup() -> Void {
        for (muscle, isFullySelected) in self.selectAllMusclesFor {
            let _muscles: Array<Muscle> = self.getAllMusclesFor(muscleGroup: muscle)
            if isFullySelected {
                
                for muscle_t in _muscles {
                    withAnimation {
                        if !self.selectedMuscles.contains(muscle_t) {
                            self.selectedMuscles.append(muscle_t)
                        } else {
                            self.selectedMuscles.removeAll(where: {$0 == muscle_t })
                        }
                    }
                }
            } else {
                withAnimation {
                    for muscle_t in _muscles {
                        self.selectedMuscles.removeAll(where: {$0 == muscle_t})
                    }
                }
            }
        }
    }
    
    func generateWorkout() async throws -> Void {
//        if self.prompt.isEmpty || self.prompt.split(separator: " ").count < 3 {
//            self.applicationToast.showToast(message: "Invalid Input Field", secondaryMessage: "The Prompt Should be at least 3 words long.")
//            return
//        }
//        
//        if self.selectedMuscles.isEmpty {
//            self.applicationToast.showToast(message: "No Muscles Selected", secondaryMessage: "Select atleast 1 target muscle to continue.")
//            return
//        }
        
        withAnimation {
            self.isWorkoutLoading = true
            self.showCreatedWorkoutScreen = true
        }
        
        defer {
            withAnimation {
                self.isWorkoutLoading = false
            }
        }
        
        let workout = try await ApplicationAI.current.generateWorkout(for: [.upperChest, .lowerChest, .longHeadTriceps, .shortHeadTriceps, .medialHeadTriceps], withExerciseCount: 1, withSets: 3, withReps: 12, andPresets: ["High Volume"])
        print(workout ?? "No Workout")
        
    }
    
    var body: some View {
        ZStack {
            ScrollViewReader { scrollProxy in
                ScrollView(showsIndicators: false) {
                    
                    Text("Create a whole new workout using AI, select the muscles you want to target, enter prompt and get started!")
                        .font(.system(size: 13, weight: .regular,design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .fullWidthLeading()
                        .padding(.horizontal, ApplicationMarginPadding.current.scrollViewHorizontalMargin)
                    
                    
                    TextField("Enter Prompt", text: self.$prompt)
                        .applicationTextField()
                        .padding(.top, 5)
                        .padding(.horizontal, ApplicationMarginPadding.current.scrollViewHorizontalMargin)
                    
                    
                    
                    
                    
                    
                    // MARK: Targetted muscles
                    
                    SecondarySectionHeading(heading: "Targetted Muscles".uppercased())
                        .padding(.horizontal, ApplicationMarginPadding.current.scrollViewHorizontalMargin)
                    
                    
                    
                    
                    // MARK: Horizontal Scroll Muscle Group Selection
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(Array(self.muscleCompounds.keys.sorted()), id: \.self) { muscleCompound in
                                
                                let condition: Bool = self.currentSelectedMuscleGroup == muscleCompound
                                
                                Text(muscleCompound)
                                    .font(.system(size: 16, weight: .regular, design: .rounded))
                                    .foregroundStyle(condition ? .black : .white.opacity(0.5))
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 10)
                                    .glassEffect(.regular.tint(condition ? .appPrimary : .clear).interactive())
                                    .animation(nil, value: condition)
                                    .onTapGesture {
                                        withAnimation {
                                            self.currentSelectedMuscleGroup = muscleCompound
                                        }
                                    }
                            }
                        }
                        .padding(.horizontal, ApplicationMarginPadding.current.scrollViewHorizontalMargin)
                    }
                    .scrollClipDisabled()
                    
                    
                    
                    
                    
                    
                    
                    // MARK: Select all muscles for selected muscle group
                    
                    Toggle(isOn: Binding(
                        get: { self.selectAllMusclesFor[self.currentSelectedMuscleGroup, default: false] },
                        set: { self.selectAllMusclesFor[self.currentSelectedMuscleGroup] = $0 }
                    )) {
                        HStack {
                            Text("Select All Muscles: ")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                            +
                            Text(self.currentSelectedMuscleGroup.uppercased())
                                .font(.custom(ApplicationFonts.anton, size: 15))
                        }
                    }
                    .tint(.black)
                    .foregroundStyle(.black)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(.appPrimary, in: RoundedRectangle(cornerRadius: 12.0))
                    .padding(.horizontal, ApplicationMarginPadding.current.scrollViewHorizontalMargin)
                    .padding(.top)
                    
                    
                    
                    
                    
                    
                    
                    
                    // MARK: Selected Muscle Group Muscles
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                        
                        
                        
                        ForEach(self.currentSelectedMuscleGroupMuscles, id: \.self) { muscle in
                            
                            let condition: Bool = self.selectedMuscles.contains(muscle)
                            Text(muscle.rawValue)
                                .font(.system(size: 15, weight: .regular, design: .rounded))
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                                .padding(.vertical, 13)
                                .frame(maxWidth: .infinity)
                                .glassEffect(.regular.tint(condition ? .white.opacity(0.35) : .clear).interactive(), in: .rect(cornerRadius: 12.0))
                                .transition(.blurReplace)
                                .onTapGesture {
                                    self.handleMuscleClick(muscle: muscle)
                                }
                        }
                    }
                    .padding(.horizontal, ApplicationMarginPadding.current.scrollViewHorizontalMargin)
                    
                    
                    SecondarySectionHeading(heading: "Total Exercises".uppercased())
                        .padding(.horizontal, ApplicationMarginPadding.current.scrollViewHorizontalMargin)
                    
                    
                    Stepper("\(self.totalExercises) Exercises", value: self.$totalExercises, in: 1...10)
                        .padding()
                        .glassEffect(.regular, in: .rect(cornerRadius: 12.0))
                        .padding(.horizontal, ApplicationMarginPadding.current.scrollViewHorizontalMargin)

                    
                    
                    
                    
                    
                    
                    // MARK: Sets and Reps Text Inputs
                    
                    SecondarySectionHeading(heading: "SETS & REPS", secondaryHeading: "[ Optional ]".uppercased())
                        .padding(.horizontal, ApplicationMarginPadding.current.scrollViewHorizontalMargin)
                    
                    HStack {
                        TextField("Enter Sets", text: self.$totalSets)
                            .applicationTextField()
                            .keyboardType(.numberPad)
                        
                        TextField("Enter Reps", text: self.$totalReps)
                            .applicationTextField()
                            .keyboardType(.numberPad)
                    }
                    .fullWidthLeading()
                    .padding(.horizontal, ApplicationMarginPadding.current.scrollViewHorizontalMargin)
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    // MARK: Presets
                    
                    SecondarySectionHeading(heading: "Presets".uppercased(), secondaryHeading: "[ Optional ]".uppercased())
                        .padding(.horizontal, ApplicationMarginPadding.current.scrollViewHorizontalMargin)
                    
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                        ForEach(self.presetOptions, id: \.self) { preset in
                            let condition: Bool = self.currentSelectedPresetOption.contains(preset)
                            Text(preset)
                                .foregroundStyle(.white)
                                .applicationButtons(color: condition ? .white.opacity(0.35) : .clear)
                                .onTapGesture {
                                    self.handlePresetClick(preset: preset)
                                }
                        }
                    }
                    .padding(.horizontal, ApplicationMarginPadding.current.scrollViewHorizontalMargin)
                    .padding(.bottom, self.currentSelectedPresetOption.contains("Other") ? 0 : 35)
                    
                    
                    
                    
                    
                    // MARK: Custom Preset text inpuit
                    
                    if self.currentSelectedPresetOption.contains("Other") {
                        SecondarySectionHeading(heading: "CUSTOM PRESET")
                            .padding(.horizontal, ApplicationMarginPadding.current.scrollViewHorizontalMargin)
                        TextField("Enter Custom Preset", text: self.$customPreset)
                            .applicationTextField()
                            .padding(.bottom, 35)
                            .padding(.horizontal, ApplicationMarginPadding.current.scrollViewHorizontalMargin)
                    }
                    
                    HStack {}
                        .frame(maxWidth: .infinity)
                        .frame(height: 10)
                        .background(.blue)
                        .opacity(0)
                        .id("bottom-last-anchor")
                    
                }
                .fullScreenHeightWidth()
                .onChange(of: self.applicationKeyboardObserver.isVisible == true) {
                    withAnimation {
                        scrollProxy.scrollTo("bottom-last-anchor", anchor: .bottom)
                    }
                }
                .onChange(of: self.currentSelectedPresetOption.contains("Other") == true) {
                    withAnimation {
                        scrollProxy.scrollTo("bottom-last-anchor", anchor: .bottom)
                    }
                }
                .onChange(of: self.selectAllMusclesFor) {
                    self.handleSelectAllMusclesForGroup()
                }
            }
            .fullScreenHeightWidth()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Create WOrkout".uppercased())
                        .antonFont(with: 25)
                }
                
                ToolbarItem(placement: .bottomBar) {
                    
                    Button(action: {
                        Task {
                            try await self.generateWorkout()
                        }
                    }) {
                        if self.isWorkoutLoading {
                            ProgressView()
                                .tint(.white)
                                .transition(.blurReplace)
                        } else {
                            Text("generate".uppercased())
                                .frame(maxWidth: .infinity)
                                .transition(.blurReplace)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                
                if self.applicationKeyboardObserver.isVisible {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: { ApplicationHelper.current.dismissKeyboard() }) {
                            Image(systemName: "keyboard.chevron.compact.down.fill")
                                .scaleEffect(0.85)
                        }
                    }
                }
            }
        }
        .sensoryFeedback(.impact, trigger: self.currentSelectedMuscleGroup)
        .sensoryFeedback(.impact, trigger: self.totalExercises)
        .sensoryFeedback(.impact, trigger: self.currentSelectedPresetOption)
    }
}

