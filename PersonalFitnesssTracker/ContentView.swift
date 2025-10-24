//
//  ContentView.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 07/10/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    
    var body: some View {
        NavigationStack {
            self.NavigationBar()
        }
    }
    
    @ViewBuilder
    func NavigationBar() -> some View {
        TabView {
            Tab.init("Workout", systemImage: "dumbbell.fill") {
                WorkoutScreen()
            }
            Tab.init("Diet", systemImage: "fork.knife") {
                DietScreen()
            }
            Tab.init("Statistics", systemImage: "graph.2d") {
                StatsScreen()
            }
            
            Tab.init("Add", systemImage: "plus", role: .search) {
                AddScreen()
            }
        }
        .tabBarMinimizeBehavior(.onScrollDown)
        .tint(.appPrimary)
        
    }
}
