import Foundation
import SwiftUI

@Observable
class ApplicationBottomModal {
    
    var isVisible: Bool = false
    var message: String = ""
    var secondaryMessage: String = ""
    var primaryButtonText: String = ""
    var secondaryButtonText: String = ""
    var primaryAction: () -> Void = {}
    var secondaryAction: () -> Void = {}
    
    public static let current = ApplicationBottomModal()

    func showBottomModal(message: String, secondaryMessage: String, primaryButtonText: String, secondaryButtonText: String ,primaryAction: @escaping () -> Void, secondaryAction: @escaping () -> Void) -> Void {
        if self.isVisible { return }
        
        self.message = message
        self.secondaryMessage = message
        self.primaryButtonText = primaryButtonText
        self.secondaryButtonText = secondaryButtonText
        self.primaryAction = primaryAction
        self.secondaryMessage = secondaryMessage
        self.secondaryAction = secondaryAction
        
        
        withAnimation {
            self.isVisible = true
        }
    }
    
    func hideBottomModal() -> Void {
        withAnimation {
            self.isVisible = false
        }
    }
}
