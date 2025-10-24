//
//  KeyboardOvserverDismiss.swift
//  PersonalFitnesssTracker
//
//  Created by Uddeshya Singh on 11/10/25.
//

import SwiftUI

@Observable
class KeyboardOvserver {
    var isVisible: Bool = false
    
    init() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
            withAnimation {
                self.isVisible = true
            }
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            withAnimation {
                self.isVisible = false
            }
        }
    }
}
