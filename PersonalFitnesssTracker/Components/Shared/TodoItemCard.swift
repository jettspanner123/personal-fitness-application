//
//  TodoItemCard.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 23/10/25.
//

import SwiftUI

enum TodoItemCardType: String, CaseIterable {
    case add, remove
}

struct TodoItemCard: View {
    
    var index: Int
    @Binding var todo: Todo
    var type: TodoItemCardType
    var wantButton: Bool = true
    @State var showEditTodoScreen: Bool = false
    
    var body: some View {
        HStack {
            HStack {
                Text(String(self.index))
                    .antonFont(with: 20)
                    .frame(maxHeight: .infinity)
                    .frame(width: 50)
                    .background(.white.opacity(0.1), in: UnevenRoundedRectangle(cornerRadii: .init(topLeading: 12.0, bottomLeading: 12.0)))
                
                VStack {
                    Text(self.todo.title)
                        .font(.system(size: 15, weight: .medium,design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(self.todo.description.prefix(28) + (self.todo.description.count > 32 ? "..." : ""))
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.leading, 5)
            }
            .frame(maxWidth: .infinity, maxHeight: 55, alignment: .leading)
            .glassEffect(.regular.tint(self.wantButton ? .appDark : self.todo.isCompleted ? .appPrimary : .red).interactive(), in: UnevenRoundedRectangle(cornerRadii: .init(topLeading: 12, bottomLeading: 12, bottomTrailing: 100, topTrailing: 100)))
            .contentShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 12, bottomLeading: 12, bottomTrailing: 100, topTrailing: 100)))
            .onTapGesture {
                self.showEditTodoScreen = true
            }
            
            
            if self.wantButton {
                Image(systemName: self.type == .add ? "checkmark" : "xmark")
                    .foregroundStyle(self.type == .add ? .black : .white)
                    .frame(width: 55, height: 55)
                    .glassEffect(.regular.tint(self.type == .add ? .appPrimary : .red).interactive(), in: Circle())
            }
        }
        .frame(maxWidth: .infinity)
        .navigationDestination(isPresented: self.$showEditTodoScreen) {
            EditTodoItemScreen(todo: self.$todo)
        }
    }
}

