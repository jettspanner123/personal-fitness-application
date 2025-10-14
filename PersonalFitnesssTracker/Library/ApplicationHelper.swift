import Foundation
import SwiftUI

class ApplicationHelper {
    public static let current = ApplicationHelper()
    
    public func dismissKeyboard() -> Void {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    public func jsonToExerciseArray(with json: String) -> Array<Exercise>? {
        if let data = json.data(using: .utf8) {
            do {
                let decoded = try JSONDecoder().decode([Exercise].self, from: data)
                return decoded
            } catch {
               return nil
            }
        }
        return nil
    }
    
    public func secondsToMinutes(with seconds: Int) -> String {
        if seconds < 60 {
            return "\(seconds) sec"
        } else {
            let minutes = Double(seconds) / 60.0
            // show 1 decimal if needed (e.g., 1.5 min)
            let formatted = String(format: minutes.truncatingRemainder(dividingBy: 1) == 0 ? "%.0f" : "%.1f", minutes)
            return "\(formatted) min"
        }
    }
    
    
}
