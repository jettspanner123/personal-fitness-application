//
//  Todo.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 23/10/25.
//

import Foundation

struct Todo: Equatable {
    var id: String = UUID().uuidString
    var title: String
    var description: String
    var date: Date
    var isCompleted: Bool
}
