import Foundation

struct User {
    var id: String = UUID().uuidString
    var username: String
    var email: String
    var password: String
    var weight: Double
    var height: Double
}
