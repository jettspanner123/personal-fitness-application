//
//  JournalScreen.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 21/10/25.
//

import SwiftUI

struct TodoScreen: View {
    
    enum CurrentTodoScreenType: String, CaseIterable {
        case pending = "Pending", completed = "Completed"
    }
    
    @Environment(ApplicationWorkoutStates.self) var applicationWorkoutStates
    @Environment(ApplicationToast.self) var applicationToast
    @Environment(ApplicationBottomModal.self) var applicationBottomModal
    @Environment(KeyboardOvserver.self) var keyboardObserver
    @Environment(\.dismiss) var dismiss
    
    @Namespace private var animationNamespace
    
    var currentDay: DayName
    
    
    
    @State var todo: String = ""
    @State var todos: Array<Todo> = [
        .init(title: "Buy Milk", description: "Hellow rold my name is uddeshy asingh", date: .now, isCompleted: false)
    ]
    @State var currentSelectedTodoType: CurrentTodoScreenType = .pending
    
    var currentDayWorkout: DailyWorkout {
        if let workout = self.applicationWorkoutStates.weeklySplit.filter({ $0.forDay == self.currentDay }).first {
            return workout
        }
        return .init(name: "Rest Day", exercises: [:], forDay: self.currentDay)
    }
    
    
    func handleDismiss() -> Void {
        if self.todo.isEmpty {
            self.dismiss()
            return
        }
        
        withAnimation {
            ApplicationHelper.current.dismissKeyboard()
            self.applicationBottomModal.showBottomModal(
                message: "Exit Without Todo!",
                secondaryMessage: "If you exit now your change will not be saved for the todo list.",
                primaryButtonText: "Continue Edit",
                secondaryButtonText: "Cancel Edit",
                primaryAction: {
                    self.applicationBottomModal.hideBottomModal()
                }, secondaryAction: {
                    self.applicationBottomModal.hideBottomModal()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.dismiss()
                    }
                })
        }
    }
    
    func addTodo() -> Void {
        if self.todo.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || self.todo.split(separator: " ").count < 2 {
            self.applicationToast.showToast(message: "Invalid Todo Item!", secondaryMessage: "The todo must have atleast 2 words to continue adding.")
            return
        }
        
        withAnimation {
            self.todos.append(.init(title: self.todo, description: "", date: .now, isCompleted: false))
            self.todo = ""
        }
    }
    
    var body: some View {
        ZStack {
            
            ScrollView(showsIndicators: false) {
                
                
                // MARK: Page description
                
                Text("This is the to-do part of the application, write anything for the day or for any day.")
                    .pageDescription()
                    .padding(ApplicationMarginPadding.current.scrollViewHorizontalMargin)
                
                
                
                
                // MARK: Date Selction Marquee
                
                ScrollViewReader { scrollProxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        
                        HStack {
                            
                            ForEach(-6...6, id: \.self) { index in
                                let backgroundColor: Color = index + 22 == 22 ? .appPrimary : .clear
                                let foregroundColor: Color = index + 22 == 22 ? .black : .white
                                
                                VStack {
                                    Text(String(22 + index))
                                        .antonFont(with: 30)
                                        .foregroundStyle(foregroundColor)
                                    
                                    Text("Monday")
                                        .font(.system(size: 10, weight: .regular, design: .rounded))
                                        .foregroundStyle(foregroundColor.opacity(0.5))
                                }
                                .padding()
                                .frame(width: 70, height: 90)
                                .glassEffect(.regular.tint(backgroundColor).interactive(), in: RoundedRectangle(cornerRadius: 12.0))
                                .id(index+22 == 22 ? "current-day" : "other-day")
                            }
                        }
                        .padding(.horizontal, ApplicationMarginPadding.current.scrollViewHorizontalMargin)
                    }
                    .scrollClipDisabled()
                    .onAppear {
                        scrollProxy.scrollTo("current-day", anchor: .init(x: 0.08, y: 0))
                    }
                }
                
                
                // MARK: Actual Todo Section
                SecondarySectionHeading(heading: "Current Todos".uppercased())
                    .padding(.horizontal, ApplicationMarginPadding.current.scrollViewHorizontalMargin)
                
                
                if self.todos.isEmpty {
                    VStack(spacing: -15) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                        ContentUnavailableView("No Todo's For Today", image: "", description: Text("The todo list is empty for today bitch! Go get some work done!"))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 50)
                    .opacity(0.5)
                } else {
                    ForEach(Array(self.todos.enumerated()), id: \.offset) { index, _ in
                        TodoItemCard(index: index+1, todo: self.$todos[index], type: .add)
                            .padding(.horizontal, ApplicationMarginPadding.current.scrollViewHorizontalMargin)
                    }
                }
                
            }
            .fullScreenHeightWidth()
        }
        .fullScreenHeightWidth()
        .navigationBarBackButtonHidden()
        .toolbar {
            
            // MARK: Back Button
            
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    self.handleDismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .scaleEffect(0.9)
                }
            }
            
            
            
            // MARK: Main page header
            
            ToolbarItem(placement: .principal) {
                Text("To-Do".uppercased())
                    .antonFont(with: 25)
            }
            
            
            
            
            // MARK: Dismiss Keyboard Button
            
            if self.keyboardObserver.isVisible {
                ToolbarItem(placement: .topBarTrailing) {
                    DismissKeyboardToolBarItem()
                }
                .matchedTransitionSource(id: "dismiss_keyboard", in: self.animationNamespace)
            }
            
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "eye.fill")
                        .scaleEffect(0.9)
                }
            }
            .matchedTransitionSource(id: "dismiss_keyboard", in: self.animationNamespace)
            
        }
        .overlay(alignment: .bottom) {
            
            
            
            // MARK: Bottom text field
            
            HStack {
                TextField("Enter Todo", text: self.$todo)
                    .applicationTextField()
                
                Image(systemName: "plus")
                    .padding(15)
                    .glassEffect(.regular.interactive(), in: Circle())
                    .contentShape(Circle())
                    .onTapGesture {
                        self.addTodo()
                    }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, ApplicationMarginPadding.current.scrollViewHorizontalMargin)
            .padding(.bottom, self.keyboardObserver.isVisible ? 15 : 0)
        }
        .sensoryFeedback(.impact, trigger: self.todos.count)
    }
}




