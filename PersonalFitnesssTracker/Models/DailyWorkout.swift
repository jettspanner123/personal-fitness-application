import Foundation

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


enum DayName: String {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}

struct DailyWorkout: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var exercises: Dictionary<Exercise, Bool>
    var forDay: DayName
    var isRestDay: Bool?
}

struct Exercise: Identifiable, Hashable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var sets: Int
    var reps: Int
    var weight: Double
    var muscles: Array<Muscle>
    
    enum CodingKeys: String, CodingKey {
        case name, sets, reps, weight, muscles
    }
}

class Exercises {
    // MARK: Chest Exericses
    public static var inclineDumbbellPress = Exercise(name: "Incline Dumbbell Press", sets: 0, reps: 0, weight: 0, muscles: [.upperChest, .middleChest, .frontDelts, .shortHeadTriceps, .longHeadTriceps])
    public static var inclineBenchPress = Exercise(name: "Incline Bench Press", sets: 0, reps: 0, weight: 0, muscles: [.upperChest, .middleChest, .frontDelts, .shortHeadTriceps, .longHeadTriceps])
    public static var benchPress = Exercise(name: "Bench Press", sets: 0, reps: 0, weight: 0, muscles: [.upperChest, .middleChest, .lowerChest, .frontDelts, .shortHeadTriceps, .longHeadTriceps])
    public static var dumbbellPress = Exercise(name: "Dumbbell Press", sets: 0, reps: 0, weight: 0, muscles: [.upperChest, .middleChest, .frontDelts, .shortHeadTriceps, .longHeadTriceps])
    public static var declineBenchPress = Exercise(name: "Decline Bench Press", sets: 0, reps: 0, weight: 0, muscles: [.middleChest, .lowerChest, .frontDelts, .shortHeadTriceps, .longHeadTriceps])
    public static var declineDumbbellPress = Exercise(name: "Decline Dumbbell Press", sets: 0, reps: 0, weight: 0, muscles: [.middleChest, .lowerChest, .frontDelts, .shortHeadTriceps, .longHeadTriceps])
    public static var highCableCrossover = Exercise(name: "High Cable Crossover", sets: 0, reps: 0, weight: 0, muscles: [.lowerChest, .middleChest, .upperChest])
    public static var mediumCableCrossover = Exercise(name: "Medium Cable Crossover", sets: 0, reps: 0, weight: 0, muscles: [.middleChest])
    public static var lowerCableCrossover = Exercise(name: "Lower Cable Crossover", sets: 0, reps: 0, weight: 0, muscles: [.upperChest, .middleChest])
    public static var machineChestPress = Exercise(name: "Machine Chest Press", sets: 0, reps: 0, weight: 0, muscles: [.upperChest, .middleChest, .lowerChest, .frontDelts, .shortHeadTriceps, .longHeadTriceps])
    
    // MARK: Shoulder Exercises
    public static var dumbbellShoulderPress = Exercise(name: "Dumbbell Shoulder Press", sets: 0, reps: 0, weight: 0, muscles: [.frontDelts, .lateralDelts, .shortHeadTriceps, .longHeadTriceps, .upperTraps])
    public static var barbellShoulderPress = Exercise(name: "Barbell Shoulder Press", sets: 0, reps: 0, weight: 0, muscles: [.frontDelts, .lateralDelts, .shortHeadTriceps, .longHeadTriceps, .upperTraps])
    public static var lateralRaises = Exercise(name: "Lateral Raises", sets: 0, reps: 0, weight: 0, muscles: [.lateralDelts])
    public static var frontRaises = Exercise(name: "Front Raises", sets: 0, reps: 0, weight: 0, muscles: [.frontDelts])
    public static var uprightRows = Exercise(name: "Upright Rows", sets: 0, reps: 0, weight: 0, muscles: [.lateralDelts, .frontDelts, .upperTraps])
    public static var facePulls = Exercise(name: "Face Pulls", sets: 0, reps: 0, weight: 0, muscles: [.rearDelts, .middleBack, .upperTraps])
    public static var reversePecDec = Exercise(name: "Reverse Pec Dec", sets: 0, reps: 0, weight: 0, muscles: [.rearDelts, .middleBack])
    public static var reverseCableFlys = Exercise(name: "Reverse Cable Flys", sets: 0, reps: 0, weight: 0, muscles: [.rearDelts, .middleBack])
    public static var cableLateralRaises = Exercise(name: "Cable Lateral Raises", sets: 0, reps: 0, weight: 0, muscles: [.rearDelts, .middleBack])
    
    
    // MARK: Leg Exercises
    public static var squats = Exercise(name: "Squats", sets: 0, reps: 0, weight: 0, muscles: [.quads, .glutes, .hamstrings, .lowerBack])
    public static var lunges = Exercise(name: "Lunges", sets: 0, reps: 0, weight: 0, muscles: [.quads, .glutes, .hamstrings])
    public static var walkingLunges = Exercise(name: "Walking Lunges", sets: 0, reps: 0, weight: 0, muscles: [.quads, .glutes, .hamstrings])
    public static var bulgarianSplitSquats = Exercise(name: "Bulgarian Split Squats", sets: 0, reps: 0, weight: 0, muscles: [.quads, .glutes, .hamstrings])
    public static var gobletSquats = Exercise(name: "Goblet Squats", sets: 0, reps: 0, weight: 0, muscles: [.quads, .glutes, .hamstrings])
    public static var legExtensions = Exercise(name: "Leg Extensions", sets: 0, reps: 0, weight: 0, muscles: [.quads])
    public static var legCurls = Exercise(name: "Leg Curls", sets: 0, reps: 0, weight: 0, muscles: [.hamstrings])
    public static var calfRaises = Exercise(name: "Calf Raises", sets: 0, reps: 0, weight: 0, muscles: [.calves])
    public static var seatedCalfRaises = Exercise(name: "Seated Calf Raises", sets: 0, reps: 0, weight: 0, muscles: [.calves])
    public static var nordicCurls = Exercise(name: "Nordic Curls", sets: 0, reps: 0, weight: 0, muscles: [.hamstrings])
    public static var legPress = Exercise(name: "Leg Press", sets: 0, reps: 0, weight: 0, muscles: [.quads, .glutes, .hamstrings])
    public static var hackSquats = Exercise(name: "Hack Squats", sets: 0, reps: 0, weight: 0, muscles: [.quads, .glutes])
    public static var stiffLegDeadlifts = Exercise(name: "Stiff Leg Deadlifts", sets: 0, reps: 0, weight: 0, muscles: [.quads, .glutes])
    
    // MARK: Back Exercises
    public static var deadlift = Exercise(name: "Deadlift", sets: 0, reps: 0, weight: 0, muscles: [.lowerBack, .glutes, .hamstrings, .quads, .lats])
    public static var latPulldown = Exercise(name: "Lat Pulldown", sets: 0, reps: 0, weight: 0, muscles: [.lats, .middleBack, .shortHeadBiceps, .longHeadBiceps])
    public static var seatedCableRow = Exercise(name: "Seated Cable Row", sets: 0, reps: 0, weight: 0, muscles: [.middleBack, .lats, .shortHeadBiceps, .longHeadBiceps])
    public static var barbellRow = Exercise(name: "Barbell Row", sets: 0, reps: 0, weight: 0, muscles: [.middleBack, .lats, .lowerBack, .shortHeadBiceps, .longHeadBiceps])
    public static var singleArmDumbbellRow = Exercise(name: "Single-Arm Dumbbell Row", sets: 0, reps: 0, weight: 0, muscles: [.middleBack, .lats, .shortHeadBiceps, .longHeadBiceps])
    public static var tBarRow = Exercise(name: "T-Bar Row", sets: 0, reps: 0, weight: 0, muscles: [.middleBack, .lats, .shortHeadBiceps, .longHeadBiceps])
    public static var chestSupportedRow = Exercise(name: "Chest Supported Row", sets: 0, reps: 0, weight: 0, muscles: [.middleBack, .lats, .rearDelts, .shortHeadBiceps, .longHeadBiceps])
    public static var cablePullover = Exercise(name: "Cable Pullover", sets: 0, reps: 0, weight: 0, muscles: [.lats, .middleBack])
    
    // MARK: Arm Exercises
    public static var dumbbellCurls = Exercise(name: "Dumbbell Curls", sets: 0, reps: 0, weight: 0, muscles: [.shortHeadBiceps, .longHeadBiceps, .brachioradialis])
    public static var barbellCurls = Exercise(name: "Barbell Curls", sets: 0, reps: 0, weight: 0, muscles: [.shortHeadBiceps, .longHeadBiceps, .brachioradialis])
    public static var inclineBicepCurls = Exercise(name: "Incline Bicep Curls", sets: 0, reps: 0, weight: 0, muscles: [.shortHeadBiceps, .longHeadBiceps])
    public static var hammerCurls = Exercise(name: "Hammer Curls", sets: 0, reps: 0, weight: 0, muscles: [.brachioradialis, .shortHeadBiceps, .longHeadBiceps])
    public static var ropeHammerCurls = Exercise(name: "Rope Hammer Curls", sets: 0, reps: 0, weight: 0, muscles: [.brachioradialis, .shortHeadBiceps, .longHeadBiceps])
    public static var cableBicepCurls = Exercise(name: "Cable Bicep Curls", sets: 0, reps: 0, weight: 0, muscles: [.shortHeadBiceps, .longHeadBiceps, .brachioradialis])
    public static var concentrationCurls = Exercise(name: "Concentration Curls", sets: 0, reps: 0, weight: 0, muscles: [.shortHeadBiceps, .longHeadBiceps])
    
    public static var tricepExtensions = Exercise(name: "Tricep Extensions", sets: 0, reps: 0, weight: 0, muscles: [.longHeadTriceps, .shortHeadTriceps, .medialHeadTriceps])
    public static var overheadTricepExtensions = Exercise(name: "Overhead Tricep Extensions", sets: 0, reps: 0, weight: 0, muscles: [.longHeadTriceps, .shortHeadTriceps, .medialHeadTriceps])
    public static var skullCrushers = Exercise(name: "Skull Crushers", sets: 0, reps: 0, weight: 0, muscles: [.longHeadTriceps, .shortHeadTriceps, .medialHeadTriceps])
    public static var dumbbellTricepExtensions = Exercise(name: "Dumbbell Tricep Extensions", sets: 0, reps: 0, weight: 0, muscles: [.longHeadTriceps, .shortHeadTriceps])
    public static var closeGripTricepBenchPress = Exercise(name: "Close Grip Tricep Bench Press", sets: 0, reps: 0, weight: 0, muscles: [.middleChest, .shortHeadTriceps, .longHeadTriceps, .medialHeadTriceps])
    
    
    public static var forearmExtensors = Exercise(name: "Forearm Extensors", sets: 0, reps: 0, weight: 0, muscles: [.middleChest, .foreArmExtensors])
    public static var forearmContractors = Exercise(name: "Forearm Contractors", sets: 0, reps: 0, weight: 0, muscles: [.middleChest, .foreArmContractors])
    
    // MARK: Abs Exercises
    public static var legRaises = Exercise(name: "Leg Raises", sets: 0, reps: 0, weight: 0, muscles: [.lowerAbs, .upperAbs])
    public static var cableCrunches = Exercise(name: "Cable Crunches", sets: 0, reps: 0, weight: 0, muscles: [.upperAbs, .lowerAbs])
    public static var declineCrunches = Exercise(name: "Decline Crunches", sets: 0, reps: 0, weight: 0, muscles: [.upperAbs, .lowerAbs])
    public static var planks = Exercise(name: "Planks", sets: 0, reps: 0, weight: 0, muscles: [.upperAbs, .lowerAbs, .obliques])
    public static var absRollout = Exercise(name: "Abs Rollout", sets: 0, reps: 0, weight: 0, muscles: [.upperAbs, .lowerAbs, .obliques])
    
    static var all: [Exercise] {
        return [
            // Chest
            inclineDumbbellPress, inclineBenchPress, benchPress, dumbbellPress,
            declineBenchPress, declineDumbbellPress, highCableCrossover,
            mediumCableCrossover, lowerCableCrossover, machineChestPress,
            
            // Shoulders
            dumbbellShoulderPress, barbellShoulderPress, lateralRaises, frontRaises,
            uprightRows, facePulls, reversePecDec, reverseCableFlys, cableLateralRaises,
            
            // Legs
            squats, lunges, walkingLunges, bulgarianSplitSquats, gobletSquats,
            legExtensions, legCurls, calfRaises, seatedCalfRaises, nordicCurls,
            legPress, hackSquats, stiffLegDeadlifts,
            
            // Back
            deadlift, latPulldown, seatedCableRow, barbellRow, singleArmDumbbellRow,
            tBarRow, chestSupportedRow, cablePullover,
            
            // Arms
            dumbbellCurls, barbellCurls, inclineBicepCurls, hammerCurls,
            ropeHammerCurls, cableBicepCurls, concentrationCurls,
            tricepExtensions, overheadTricepExtensions, skullCrushers,
            dumbbellTricepExtensions, closeGripTricepBenchPress,
            forearmExtensors, forearmContractors,
            
            // Abs
            legRaises, cableCrunches, declineCrunches, planks, absRollout
        ]
    }
}



