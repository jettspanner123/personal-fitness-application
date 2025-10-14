import Foundation
import HealthKit
import SwiftUI


@Observable
class ApplicationHealthKitManager {
    
    public static let current = ApplicationHealthKitManager()
    let healthStore = HKHealthStore()
    
    var stepsType: HKQuantityType {
        return HKQuantityType(.stepCount)
    }
    
    var showError: Bool = false
    var errorMessage: String = ""
    var errorDescription: String = ""
    
    func toggleError(withHeading: String, andMessage: String) -> Void {
        self.errorMessage = withHeading
        self.errorDescription = andMessage
        
        withAnimation {
            self.showError = true
        }
    }
    
    init() {
        let healthStoreTypes: Set<HKObjectType> = [self.stepsType]
        
        Task {
            do {
                try await self.healthStore.requestAuthorization(toShare: [], read: healthStoreTypes)
            } catch {
                print("Error")
            }
        }
    }
    
    public func getSteps() async throws -> Double {
            
       
        return try await withCheckedThrowingContinuation { continuation in
            let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: .now)
                
                let query = HKStatisticsQuery(
                    quantityType: self.stepsType,
                    quantitySamplePredicate: predicate,
                    options: .cumulativeSum
                ) { _, result, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                        return
                    }
                    
                    guard let quantity = result?.sumQuantity() else {
                        continuation.resume(returning: 0)
                        return
                    }
                    
                    let stepCount = quantity.doubleValue(for: HKUnit.count())
                    continuation.resume(returning: stepCount)
                }
                
                self.healthStore.execute(query)
            }
        
        
    }
    
    
}
