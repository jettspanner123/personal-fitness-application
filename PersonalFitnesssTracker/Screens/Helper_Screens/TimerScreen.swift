//
//  TimerScreen.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 14/10/25.
//

import SwiftUI
import Combine

struct TimerScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(ApplicationBottomModal.self) var applicationBottomModal
    
    @State var selectedMinutes: Int = 5
    @State var selectedSeconds: Int = 20
    @State var vibrationState: Bool = false
    @State var showTimerCompleted: Bool = false
    @State var isTimerStarted: Bool = false
    @State var isPlaySound: Bool = true
    
    var presets: Array<(minutes: Int, seconds: Int, index: Int)> = [
        (5, 15, 1),
        (2, 0, 2),
        (3, 0, 3),
        (4, 0, 4),
        (4, 30, 5),
    ]
    @State private var timer: AnyCancellable?
    
    func startTimer() -> Void {
        withAnimation {
            self.isTimerStarted = true
        }
        
        self.timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                
                
                if self.selectedMinutes == 0 && self.selectedSeconds == 0 {
                    self.stopTimer()
                    withAnimation {
                        self.showTimerCompleted = true
                    }
                    return
                }
                
                if self.selectedSeconds == 0 && self.selectedMinutes > 0 {
                    withAnimation {
                        self.selectedSeconds = 59
                        self.selectedMinutes -= 1
                    }
                } else {
                    withAnimation {
                        self.selectedSeconds -= 1
                    }
                }
                
            }
    }
    
    func stopTimer() -> Void {
        withAnimation {
            self.isTimerStarted = false
        }
        self.timer?.cancel()
        self.timer = nil
    }
    
    func handleAddSecondsTimer(seconds: Int) {
        withAnimation {
            let totalSeconds = self.selectedMinutes * 60 + self.selectedSeconds + seconds

            if totalSeconds <= 0 {
                self.selectedMinutes = 0
                self.selectedSeconds = 0
            } else {
                self.selectedMinutes = totalSeconds / 60
                self.selectedSeconds = totalSeconds % 60
            }
        }
    }
    
    
    var body: some View {
        ZStack {
            ScrollView {
                Text("Select any timer preset or create your own for the timer to start. This is for your recovery between the sets.")
                    .pageDescription()
                
                
                
                
                
                
                // MARK: Current Minut and Sconds Picker
                
                HStack {
                    Picker("Minutes", selection: self.$selectedMinutes) {
                        ForEach(0..<60, id: \.self) { minute in
                            Text("\(minute) m").tag(minute)
                        }
                    }
                    .clipped()
                    .pickerStyle(.wheel)
                    
                    Picker("Seconds", selection: self.$selectedSeconds) {
                        ForEach(0..<60, id: \.self) { second in
                            Text("\(second) s").tag(second)
                        }
                    }
                    .clipped()
                    .pickerStyle(.wheel)
                }
                .fullWidthLeading()
                
                
                
                
                
                
                
                
                
                
                // MARK: Playback buttons
                
                HStack {
                    HStack {
                        Text("-20s")
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                    }
                    .frame(width: 60, height: 60)
                    .glassEffect(.regular.interactive(), in: Circle())
                    .contentShape(Circle())
                    .onTapGesture {
                        self.handleAddSecondsTimer(seconds: -20)
                    }
                    
                    HStack {
                        Text("-10s")
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                    }
                    .frame(width: 60, height: 60)
                    .glassEffect(.regular.interactive(), in: Circle())
                    .contentShape(Circle())
                    .onTapGesture {
                        self.handleAddSecondsTimer(seconds: -10)
                    }
                    
                    
                    HStack {
                        Text("+10s")
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                    }
                    .frame(width: 60, height: 60)
                    .glassEffect(.regular.interactive(), in: Circle())
                    .contentShape(Circle())
                    .onTapGesture {
                        self.handleAddSecondsTimer(seconds: 10)
                    }
                    
                    HStack {
                        Text("+20s")
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                    }
                    .frame(width: 60, height: 60)
                    .glassEffect(.regular.interactive(), in: Circle())
                    .contentShape(Circle())
                    .onTapGesture {
                        self.handleAddSecondsTimer(seconds: 20)
                    }
                }
                .frame(maxWidth: .infinity)
                .opacity(self.isTimerStarted ? 1 : 0.5)
                .allowsHitTesting(self.isTimerStarted)
                
                
                
                
                
                
                
                
                
                
                // MARK: Present options
                
                SecondarySectionHeading(heading: "PRESETS")
                
                
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 4)) {
                    ForEach(self.presets, id: \.index) { (minute, second, index) in
                        let isSelected: Bool = (minute * 60 + second) == (self.selectedMinutes * 60 + self.selectedSeconds)
                        let totalSeconds: Int = minute * 60 + second
                        
                        Text(ApplicationHelper.current.secondsToMinutes(with: totalSeconds))
                            .font(.system(size: 13, weight: .regular, design: .rounded))
                            .foregroundStyle(isSelected ? .black : .white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .glassEffect(.regular.tint(isSelected ? .appPrimary : .clear).interactive(), in: .rect(cornerRadius: 12.0))
                            .contentShape(.rect(cornerRadius: 12.0))
                            .onTapGesture {
                                withAnimation {
                                    self.selectedMinutes = minute
                                    self.selectedSeconds = second
                                }
                            }
                        
                    }
                }
                
            }
            .fullScreenHeightWidth()
            .contentMargins(ApplicationMarginPadding.current.scrollViewHorizontalMargin)
        }
        .navigationBarBackButtonHidden()
        .fullScreenHeightWidth()
        .toolbar {
            
            
            // MARK: Curomst back button
            
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    if self.isTimerStarted {
                        self.applicationBottomModal.showBottomModal(message: "No Rest For The King 🗿", secondaryMessage: "Do you want to exit the timer screen, this will reset the timer!", primaryButtonText: "Exit Timer", secondaryButtonText: "Cancel", primaryAction: {
                            self.applicationBottomModal.hideBottomModal()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.dismiss()
                            }
                        }, secondaryAction: {
                            self.applicationBottomModal.hideBottomModal()
                        })
                    } else {
                        self.dismiss()
                    }
                }) {
                    Image(systemName: "chevron.left")
                        .scaleEffect(0.9)
                }
            }
            
            
            
            
            // MARK: Main Title
            
            ToolbarItem(placement: .principal) {
                Text("Workout TIMER".uppercased())
                    .antonFont(with: 25)
            }
            
            
            
            // MARK: Start Button
            
            ToolbarItem(placement: .bottomBar) {
                Button(action: {
                    if self.isTimerStarted {
                        self.applicationBottomModal.showBottomModal(
                            message: "Bitch You Need Rest!",
                            secondaryMessage: "Do you want to stop the timer? BITCH you need to rest!",
                            primaryButtonText: "No Rest",
                            secondaryButtonText: "Rest",
                            primaryAction: {
                                self.stopTimer()
                                self.applicationBottomModal.hideBottomModal()
                            }, secondaryAction: {
                                self.applicationBottomModal.hideBottomModal()
                            })
                    } else {
                        self.startTimer()
                    }
                }) {
                    if self.isTimerStarted {
                        Text("STOP")
                            .fontWeight(.bold)
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity)
                    } else {
                        Text("START")
                            .frame(maxWidth: .infinity)
                    }
                    
                }
                .frame(maxWidth: .infinity)
            }
            
            
            
            
            
            // MARK: Play should or should not  button
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    withAnimation {
                        self.isPlaySound.toggle()
                    }
                }) {
                    Image(systemName: self.isPlaySound ? "speaker.slash.fill" : "speaker.wave.1.fill")
                }
            }
        }
        .fullScreenCover(isPresented: self.$showTimerCompleted) {
            
            
            
            
            // MARK: Full Screen Success Screen
            
            VStack(spacing: -20) {
                ContentUnavailableView {
                   Label("Timer Completed!", systemImage: "checkmark.circle.fill")
                        .foregroundStyle(.black)
                } description: {
                    Text("You Did It Bitch! Go Back and kill the workout you are performing right now!")
                        .foregroundStyle(.black)
                } actions: {
                    Text("Continue Workout")
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .padding(12)
                        .background(.black, in: Capsule())
                        .onTapGesture {
                            withAnimation {
                                self.showTimerCompleted = false
                            }
                        }
                }
            }
            .fullScreenHeightWidth()
            .background(.appPrimary)
            .onAppear {
                ApplicationSoundManager.current.play(sound: .alarm, with: .mp3, playForever: true)
            }
            .onDisappear {
                ApplicationSoundManager.current.stop()
            }
        }
        .sensoryFeedback(.impact, trigger: self.selectedSeconds)
        .sensoryFeedback(.impact, trigger: self.selectedMinutes)
        .onChange(of: self.selectedSeconds) {
            if self.isTimerStarted {
                if self.isPlaySound {
                    ApplicationSoundManager.current.play(sound: .tick, with: .wav)
                }
            }
        }
    }
}


