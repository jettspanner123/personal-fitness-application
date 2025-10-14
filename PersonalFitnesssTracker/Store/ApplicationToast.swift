import Foundation
import SwiftUI


@Observable
class ApplicationToast {
    
    var showToast: Bool = false
    var message: String = ""
    var secondaryMessage: String? = nil
    
    public static let current = ApplicationToast()
    
    func showToast(message: String, secondaryMessage: String? = nil) -> Void {
        
        if self.showToast { return }
        
        self.message = message
        self.secondaryMessage = secondaryMessage
        
        withAnimation(.timingCurve(0.85, 0, 0.15, 1).delay(0.1)) {
            self.showToast = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            withAnimation(.timingCurve(0.85, 0, 0.15, 1).delay(0.1)){
                self.showToast = false
            }
        }
    }
}
