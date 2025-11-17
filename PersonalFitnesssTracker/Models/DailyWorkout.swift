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

class Exercises {
    
    // MARK: Chest Exercises
    public static var inclineDumbbellPress = Exercise(name: "Incline Dumbbell Press", reps: [8,10,12], weight: [], muscles: [.upperChest, .middleChest, .frontDelts, .shortHeadTriceps, .longHeadTriceps])
    public static var inclineBenchPress = Exercise(name: "Incline Bench Press", reps: [8,10,12], weight: [], muscles: [.upperChest, .middleChest, .frontDelts, .shortHeadTriceps, .longHeadTriceps])
    public static var benchPress = Exercise(name: "Bench Press", reps: [8,10,12], weight: [], muscles: [.upperChest, .middleChest, .lowerChest, .frontDelts, .shortHeadTriceps, .longHeadTriceps])
    public static var dumbbellPress = Exercise(name: "Dumbbell Press", reps: [8,10,12], weight: [], muscles: [.upperChest, .middleChest, .frontDelts, .shortHeadTriceps, .longHeadTriceps])
    public static var declineBenchPress = Exercise(name: "Decline Bench Press", reps: [8,10,12], weight: [], muscles: [.middleChest, .lowerChest, .frontDelts, .shortHeadTriceps, .longHeadTriceps])
    public static var declineDumbbellPress = Exercise(name: "Decline Dumbbell Press", reps: [8,10,12], weight: [], muscles: [.middleChest, .lowerChest, .frontDelts, .shortHeadTriceps, .longHeadTriceps])
    public static var highCableCrossover = Exercise(name: "High Cable Crossover", reps: [8,10,12], weight: [], muscles: [.lowerChest, .middleChest, .upperChest])
    public static var mediumCableCrossover = Exercise(name: "Medium Cable Crossover", reps: [8,10,12], weight: [], muscles: [.middleChest])
    public static var lowerCableCrossover = Exercise(name: "Lower Cable Crossover", reps: [8,10,12], weight: [], muscles: [.upperChest, .middleChest])
    public static var machineChestPress = Exercise(name: "Machine Chest Press", reps: [8,10,12], weight: [], muscles: [.upperChest, .middleChest, .lowerChest, .frontDelts, .shortHeadTriceps, .longHeadTriceps])

    // MARK: Shoulder Exercises
    public static var dumbbellShoulderPress = Exercise(name: "Dumbbell Shoulder Press", reps: [8,10,12], weight: [], muscles: [.frontDelts, .lateralDelts, .shortHeadTriceps, .longHeadTriceps, .upperTraps])
    public static var barbellShoulderPress = Exercise(name: "Barbell Shoulder Press", reps: [8,10,12], weight: [], muscles: [.frontDelts, .lateralDelts, .shortHeadTriceps, .longHeadTriceps, .upperTraps])
    public static var lateralRaises = Exercise(name: "Lateral Raises", reps: [8,10,12], weight: [], muscles: [.lateralDelts])
    public static var frontRaises = Exercise(name: "Front Raises", reps: [8,10,12], weight: [], muscles: [.frontDelts])
    public static var uprightRows = Exercise(name: "Upright Rows", reps: [8,10,12], weight: [], muscles: [.lateralDelts, .frontDelts, .upperTraps])
    public static var facePulls = Exercise(name: "Face Pulls", reps: [8,10,12], weight: [], muscles: [.rearDelts, .middleBack, .upperTraps])
    public static var reversePecDec = Exercise(name: "Reverse Pec Dec", reps: [8,10,12], weight: [], muscles: [.rearDelts, .middleBack])
    public static var reverseCableFlys = Exercise(name: "Reverse Cable Flys", reps: [8,10,12], weight: [], muscles: [.rearDelts, .middleBack])
    public static var cableLateralRaises = Exercise(name: "Cable Lateral Raises", reps: [8,10,12], weight: [], muscles: [.rearDelts, .middleBack])

    // MARK: Leg Exercises
    public static var squats = Exercise(name: "Squats", reps: [8,10,12], weight: [], muscles: [.quads, .glutes, .hamstrings, .lowerBack])
    public static var lunges = Exercise(name: "Lunges", reps: [8,10,12], weight: [], muscles: [.quads, .glutes, .hamstrings])
    public static var walkingLunges = Exercise(name: "Walking Lunges", reps: [8,10,12], weight: [], muscles: [.quads, .glutes, .hamstrings])
    public static var bulgarianSplitSquats = Exercise(name: "Bulgarian Split Squats", reps: [8,10,12], weight: [], muscles: [.quads, .glutes, .hamstrings])
    public static var gobletSquats = Exercise(name: "Goblet Squats", reps: [8,10,12], weight: [], muscles: [.quads, .glutes, .hamstrings])
    public static var legExtensions = Exercise(name: "Leg Extensions", reps: [8,10,12], weight: [], muscles: [.quads])
    public static var legCurls = Exercise(name: "Leg Curls", reps: [8,10,12], weight: [], muscles: [.hamstrings])
    public static var calfRaises = Exercise(name: "Calf Raises", reps: [8,10,12], weight: [], muscles: [.calves])
    public static var seatedCalfRaises = Exercise(name: "Seated Calf Raises", reps: [8,10,12], weight: [], muscles: [.calves])
    public static var nordicCurls = Exercise(name: "Nordic Curls", reps: [8,10,12], weight: [], muscles: [.hamstrings])
    public static var legPress = Exercise(name: "Leg Press", reps: [8,10,12], weight: [], muscles: [.quads, .glutes, .hamstrings])
    public static var hackSquats = Exercise(name: "Hack Squats", reps: [8,10,12], weight: [], muscles: [.quads, .glutes])
    public static var stiffLegDeadlifts = Exercise(name: "Stiff Leg Deadlifts", reps: [8,10,12], weight: [], muscles: [.quads, .glutes])

    // MARK: Back Exercises
    public static var deadlift = Exercise(name: "Deadlift", reps: [8,10,12], weight: [], muscles: [.lowerBack, .glutes, .hamstrings, .quads, .lats])
    public static var latPulldown = Exercise(name: "Lat Pulldown", reps: [8,10,12], weight: [], muscles: [.lats, .middleBack, .shortHeadBiceps, .longHeadBiceps])
    public static var seatedCableRow = Exercise(name: "Seated Cable Row", reps: [8,10,12], weight: [], muscles: [.middleBack, .lats, .shortHeadBiceps, .longHeadBiceps])
    public static var barbellRow = Exercise(name: "Barbell Row", reps: [8,10,12], weight: [], muscles: [.middleBack, .lats, .lowerBack, .shortHeadBiceps, .longHeadBiceps])
    public static var singleArmDumbbellRow = Exercise(name: "Single-Arm Dumbbell Row", reps: [8,10,12], weight: [], muscles: [.middleBack, .lats, .shortHeadBiceps, .longHeadBiceps])
    public static var tBarRow = Exercise(name: "T-Bar Row", reps: [8,10,12], weight: [], muscles: [.middleBack, .lats, .shortHeadBiceps, .longHeadBiceps])
    public static var chestSupportedRow = Exercise(name: "Chest Supported Row", reps: [8,10,12], weight: [], muscles: [.middleBack, .lats, .rearDelts, .shortHeadBiceps, .longHeadBiceps])
    public static var cablePullover = Exercise(name: "Cable Pullover", reps: [8,10,12], weight: [], muscles: [.lats, .middleBack])

    // MARK: Arm Exercises
    public static var dumbbellCurls = Exercise(name: "Dumbbell Curls", reps: [8,10,12], weight: [], muscles: [.shortHeadBiceps, .longHeadBiceps, .brachioradialis])
    public static var barbellCurls = Exercise(name: "Barbell Curls", reps: [8,10,12], weight: [], muscles: [.shortHeadBiceps, .longHeadBiceps, .brachioradialis])
    public static var inclineBicepCurls = Exercise(name: "Incline Bicep Curls", reps: [8,10,12], weight: [], muscles: [.shortHeadBiceps, .longHeadBiceps])
    public static var hammerCurls = Exercise(name: "Hammer Curls", reps: [8,10,12], weight: [], muscles: [.brachioradialis, .shortHeadBiceps, .longHeadBiceps])
    public static var ropeHammerCurls = Exercise(name: "Rope Hammer Curls", reps: [8,10,12], weight: [], muscles: [.brachioradialis, .shortHeadBiceps, .longHeadBiceps])
    public static var cableBicepCurls = Exercise(name: "Cable Bicep Curls", reps: [8,10,12], weight: [], muscles: [.shortHeadBiceps, .longHeadBiceps, .brachioradialis])
    public static var concentrationCurls = Exercise(name: "Concentration Curls", reps: [8,10,12], weight: [], muscles: [.shortHeadBiceps, .longHeadBiceps])

    public static var tricepExtensions = Exercise(name: "Tricep Extensions", reps: [8,10,12], weight: [], muscles: [.longHeadTriceps, .shortHeadTriceps, .medialHeadTriceps])
    public static var overheadTricepExtensions = Exercise(name: "Overhead Tricep Extensions", reps: [8,10,12], weight: [], muscles: [.longHeadTriceps, .shortHeadTriceps, .medialHeadTriceps])
    public static var skullCrushers = Exercise(name: "Skull Crushers", reps: [8,10,12], weight: [], muscles: [.longHeadTriceps, .shortHeadTriceps, .medialHeadTriceps])
    public static var dumbbellTricepExtensions = Exercise(name: "Dumbbell Tricep Extensions", reps: [8,10,12], weight: [], muscles: [.longHeadTriceps, .shortHeadTriceps])
    public static var closeGripTricepBenchPress = Exercise(name: "Close Grip Tricep Bench Press", reps: [8,10,12], weight: [], muscles: [.middleChest, .shortHeadTriceps, .longHeadTriceps, .medialHeadTriceps])

    public static var forearmExtensors = Exercise(name: "Forearm Extensors", reps: [8,10,12], weight: [], muscles: [.middleChest, .foreArmExtensors])
    public static var forearmContractors = Exercise(name: "Forearm Contractors", reps: [8,10,12], weight: [], muscles: [.middleChest, .foreArmContractors])

    // MARK: Abs Exercises
    public static var legRaises = Exercise(name: "Leg Raises", reps: [8,10,12], weight: [], muscles: [.lowerAbs, .upperAbs])
    public static var cableCrunches = Exercise(name: "Cable Crunches", reps: [8,10,12], weight: [], muscles: [.upperAbs, .lowerAbs])
    public static var declineCrunches = Exercise(name: "Decline Crunches", reps: [8,10,12], weight: [], muscles: [.upperAbs, .lowerAbs])
    public static var planks = Exercise(name: "Planks", reps: [8,10,12], weight: [], muscles: [.upperAbs, .lowerAbs, .obliques])
    public static var absRollout = Exercise(name: "Abs Rollout", reps: [8,10,12], weight: [], muscles: [.upperAbs, .lowerAbs, .obliques])

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



