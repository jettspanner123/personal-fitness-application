//
//  DismissKeyboardToolBarItem.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 21/10/25.
//

import SwiftUI

struct DismissKeyboardToolBarItem: View {
    var body: some View {
        Button(action: { ApplicationHelper.current.dismissKeyboard() }) {
            Image(systemName: "keyboard.chevron.compact.down.fill")
                .scaleEffect(0.85)
        }
    }
}
