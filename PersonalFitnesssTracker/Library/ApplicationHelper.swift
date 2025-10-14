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
    
    
}
