import Foundation
import GoogleGenerativeAI

let systemPrompt: String = """
        YOUR_ROLE:
            Your name is Vanshika, an intelligent AI system designed to help the user with workouts, diets and exercises...you are the best fitness coach.
            You interact with users naturally and clearly, while managing the following goals:
    
        YOUR_GOALS:
          - Understand user queries and produce structured JSON output for programmatic handling.
            
        OUTPUT_RULES:
          - Return only raw valid JSON.
          - Do not wrap it in markdown.
          - Do not add backticks.
          - Do not add explanations.
          - Output ONLY the JSON array/object.”
    
    
        struct Exercise: Identifiable, Hashable, Codable {
            var id: String = UUID().uuidString
            var name: String
            var reps: Array<Int>
            var sets: Int {
                reps.count
            }
            var weight: Array<Double>
            var muscles: Array<Muscle>
            
            enum CodingKeys: String, CodingKey {
                case name, reps, weight, muscles
            }
        }
    
        enum Muscle: String, CaseIterable, Codable {
            case upperChest = "Upper Chest"
            case middleChest = "Middle Chest"
            case lowerChest = "Lower Chest"
            case longHeadTriceps = "Long Head Triceps"
            case shortHeadTriceps = "Short Head Triceps"
            case medialHeadTriceps = "Medial Head Triceps"
            case frontDelts = "Front Delts"
            case lateralDelts = "Lateral Delts"
            case rearDelts = "Rear Delts"
            case upperTraps = "Upper Traps"
            case lowerTraps = "Lower Traps"
            case lats = "Lats"
            case middleBack = "Middle Back"
            case lowerBack = "Lower Back"
            case longHeadBiceps = "Long Head Biceps"
            case shortHeadBiceps = "Short Head Biceps"
            case brachioradialis = "Brachioradialis"
            case foreArmExtensors = "Forearm Extensors"
            case foreArmContractors = "Forearm Contractors"
            case quads = "Quads"
            case hamstrings = "Hamstrings"
            case calves = "Calves"
            case glutes = "Glutes"
            case upperAbs = "Upper Abs"
            case lowerAbs = "Lower Abs"
            case obliques = "Obliques"
            
            static let chestMuscles: [Muscle] = [.upperChest, .middleChest, .lowerChest]
            
            static let armMuscles: Array<Muscle> = [.longHeadBiceps, .longHeadTriceps, .shortHeadBiceps, .shortHeadTriceps, .medialHeadTriceps, .foreArmExtensors, .foreArmContractors]
            
            static let shoulderMuscles: [Muscle] = [.frontDelts, .lateralDelts, .rearDelts, .upperTraps, .lowerTraps]
            
            static let backMuscles: [Muscle] = [.lats, .middleBack, .lowerBack]
            
            static let legMuscles: [Muscle] = [.quads, .hamstrings, .calves, .glutes]
            
            static let absMuscles: [Muscle] = [.upperAbs, .lowerAbs, .obliques]
        }
    
        

    """


class ApplicationAI {
    public static let current = ApplicationAI()
    
    
    
    
    let model: GenerativeModel = .init(
        name: "gemini-2.5-flash",
        apiKey: "AIzaSyD6mn-X8729E2PeDIFZtYRkqqDer_37MCs",
        systemInstruction: systemPrompt
    )
    
    private init() {
        
    }
    
    public func testFunction() async throws -> String {
        
        let prompt: String = "Generate me a chest, triceps workout."
        var response: String = ""
        do {
            let res = try await self.model.generateContent(prompt)
            response = res.text ?? "ERROR: -1"
        } catch {
            response = "SOMETHING WENT WRONG!"
        }
        return response
    }
    
    public func generateWorkout(for muscleGroups: Array<Muscle>, withExerciseCount: Int = 4, withSets: Int = 0, withReps: Int = 0, andPresets: Array<String> = []) async throws -> Array<Exercise>? {
        
        
        let prompt: String = """
            Generate me workout with the following configurations.
            
            TOTAL_EXERCISES:
              - These muscles should be targetted through the workout: \(muscleGroups.map { $0.rawValue }.joined(separator: ","))
              - There should only be \(withExerciseCount) in the entire workout.
              - Each exericse should have \(withSets) sets and \(withReps) reps.
              - These are some extra presets: \(andPresets.joined(separator: ","))
        """
        do {
            let res = try await self.model.generateContent(prompt)
            if let rawJSON = res.text {
                print("RawJSON: ", rawJSON)
                print("JSON DATA: ", Data(rawJSON.utf8))
                let workout = try JSONDecoder().decode([Exercise].self, from: Data(rawJSON.utf8))
                print("Workout: ", workout)
                return workout
            }
        } catch {
            return nil
        }
        
        return nil
    }
}
