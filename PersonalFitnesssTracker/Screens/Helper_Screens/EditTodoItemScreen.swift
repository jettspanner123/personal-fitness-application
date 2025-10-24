//
//  EditTodoItemScreen.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 24/10/25.
//

import SwiftUI

struct EditTodoItemScreen: View {
    
    @Environment(ApplicationBottomModal.self) var applicationBottomModal
    @Environment(KeyboardOvserver.self) var keyboardObserver
    @Environment(\.dismiss) var dismiss
    
    @Binding var todo: Todo
    @State var copyTodo: Todo
    
    var isOriginalTodoChanged: Bool {
        return self.todo != self.copyTodo
    }
    
    init(todo: Binding<Todo>) {
        self._todo = todo
        self._copyTodo = State(initialValue: todo.wrappedValue)
    }
    
    
    
    
    
    // MARK: Handle Dismiss Handler
    func handleDismiss() -> Void {
        if !self.isOriginalTodoChanged {
            self.dismiss()
            return
        }
        
        
        ApplicationHelper.current.dismissKeyboard()
            
        self.applicationBottomModal.showBottomModal(
            message: "Changes Won't Be Saved!",
            secondaryMessage: "If you quit now, no changes will be saved! Make sure save the changes before quiting.",
            primaryButtonText: "Continue Edit",
            secondaryButtonText: "Exit Anyway",
            primaryAction: {
                self.applicationBottomModal.hideBottomModal()
            },
            secondaryAction: {
                self.applicationBottomModal.hideBottomModal()
                self.dismiss()
            }
        )
        
    }
    
    
    // MARK: Save CHanges Handler
    func saveChanges() -> Void {
        
        if !self.isOriginalTodoChanged {
            return
        }
        
        withAnimation {
            self.todo = self.copyTodo
            ApplicationHelper.current.dismissKeyboard()
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss()
        }
    }
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                
                
                
                // MARK: Page Description
                Text("This page will allow you to edit your already created todo list items for the day.")
                    .pageDescription()
                
                
                
                
                // MARK: Todo Title Input
                TextField("Title", text: self.$copyTodo.title)
                    .applicationTextField()
                    .padding(.top, 10)
                
                
                
                
                
                // MARK: Todo Description Input
                TextEditor(text: self.$copyTodo.description)
                    .frame(minHeight: 120)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 5)
                    .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 12.0))
                    .scrollContentBackground(.hidden)
                
                
                
                
                
                
                // MARK: OTher TOdo Details
                SecondarySectionHeading(heading: "Other Details".uppercased())
                
                
                
                
                
                
                // MARK: Other Todo Details List
                VStack {
                    
                    
                    // MARK: Is Todo Completed
                    Toggle("Is Completed", isOn: self.$copyTodo.isCompleted)
                    
                    
                    
                    
                    
                    
                    Divider()
                        .padding(.vertical, 5)
                    
                    
                    
                    
                    
                    // MARK: TOdo ITem Creating Date
                    HStack {
                        Text("Creation Date")
                        Spacer()
                        Text(self.todo.date.formatted(.dateTime))
                            .foregroundStyle(.white.opacity(0.25))
                    }
                    .frame(maxWidth: .infinity)
                    
                    
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
                .glassEffect(.regular, in: .rect(cornerRadius: 12.0))
            }
            .fullScreenHeightWidth()
            .contentMargins(ApplicationMarginPadding.current.scrollViewHorizontalMargin)
        }
        .fullScreenHeightWidth()
        .navigationBarBackButtonHidden()
        .toolbar {
            
            
            
            // MARK: Dismiss Button
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    self.handleDismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .scaleEffect(0.9)
                }
            }
            
            // MARK: Main Title
            ToolbarItem(placement: .principal) {
                Text("EDIT TODO")
                    .antonFont(with: 25)
            }
            
            
            
            // MARK: Dismiss Keyboard
            if self.keyboardObserver.isVisible {
                ToolbarItem(placement: .topBarTrailing) {
                    DismissKeyboardToolBarItem()
                }
            }
            
            
            // MARK: Check button
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    self.saveChanges()
                }) {
                    Image(systemName: "checkmark")
                        .scaleEffect(0.9)
                }
                .buttonStyle(.glassProminent)
                .tint(.appPrimary)
                .disabled(!self.isOriginalTodoChanged)
            }
        }
    }
}
