//
//  ExerciseStructureButton.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 09/10/25.
//

import SwiftUI

struct ExerciseStructureButton: View {
    
    var index: Int
    var exercise: Exercise
    var isClickable: Bool = true
    var wantDarkMode: Bool = false
    
    var body: some View {
        HStack(spacing: 5) {
            
            VStack {
                Text("\(index+1)")
                    .antonFont(with: 20)
                    .foregroundStyle(self.wantDarkMode ? .appPrimary : .black)
            }
            .frame(maxHeight: .infinity)
            .frame(width: 50)
            .background(self.wantDarkMode ? .black : .appPrimary, in: RoundedRectangle(cornerRadius: 8))
            
            
            VStack {
                Text(self.exercise.name)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text("\(self.exercise.sets) Sets")
                        .font(.system(size: 10, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.8))
                        .padding(5)
                        .background(.black.opacity(0.25), in: RoundedRectangle(cornerRadius: 3))
                        .overlay { RoundedRectangle(cornerRadius: 3).stroke(.white.opacity(0.15))}
                    
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 8, height: 8)
                        .foregroundStyle(.white.opacity(0.5))
                    
                    Text("\(self.exercise.reps) Reps")
                        .font(.system(size: 10, weight: .regular, design: .rounded))
                        .foregroundStyle(.white.opacity(0.8))
                        .padding(5)
                        .background(.black.opacity(0.25), in: RoundedRectangle(cornerRadius: 3))
                        .overlay { RoundedRectangle(cornerRadius: 3).stroke(.white.opacity(0.15))}
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 12.0))
            .background(self.wantDarkMode ? .appDark : .clear, in: RoundedRectangle(cornerRadius: 12))
        }
        .frame(maxWidth: .infinity)
    }
}
