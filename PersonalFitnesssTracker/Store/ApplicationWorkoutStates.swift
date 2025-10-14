import Foundation
import Observation
import SwiftUI



@Observable
class ApplicationWorkoutStates {
    var weeklySplit: Array<DailyWorkout> = [
        .init(name: "Chest Workout", exercises: [
            Exercises.inclineDumbbellPress: false,
            Exercises.benchPress: false,
            Exercises.highCableCrossover: false,
            Exercises.mediumCableCrossover: false,
            Exercises.overheadTricepExtensions: false,
            Exercises.tricepExtensions: false
        ] , forDay: .monday),
        .init(name: "Back Workout", exercises: [
            Exercises.deadlift: false,
            Exercises.barbellRow: false,
            Exercises.latPulldown: false,
            Exercises.seatedCableRow: false,
            Exercises.cablePullover: false,
            Exercises.dumbbellCurls: false,
            Exercises.barbellCurls: false,
        ], forDay: .tuesday),
        .init(name: "Shoulder Workout", exercises: [
            Exercises.dumbbellShoulderPress: false,
            Exercises.lateralRaises: false,
            Exercises.facePulls: false,
            Exercises.uprightRows: false,
            Exercises.reverseCableFlys: false
        ], forDay: .wednesday),
        .init(name: "Leg Workout", exercises: [
            Exercises.squats: false,
            Exercises.bulgarianSplitSquats: false,
            Exercises.legExtensions: false,
            Exercises.stiffLegDeadlifts: false,
            Exercises.legCurls: false,
            Exercises.calfRaises: false
        ], forDay: .thursday),
        .init(name: "Arm Day", exercises: [
            Exercises.barbellCurls: false,
            Exercises.overheadTricepExtensions: false,
            Exercises.hammerCurls: false,
            Exercises.skullCrushers: false,
            Exercises.inclineBicepCurls: false,
            Exercises.tricepExtensions: false,
            Exercises.forearmExtensors: false,
            Exercises.forearmContractors: false
        ], forDay: .friday),
        .init(name: "Full Body", exercises: [
            Exercises.inclineDumbbellPress: false,
            Exercises.barbellRow: false,
            Exercises.seatedCableRow: false,
            Exercises.inclineBenchPress: false,
            Exercises.cablePullover: false,
            Exercises.lateralRaises: false,
            Exercises.facePulls: false
        ], forDay: .saturday),
        .init(name: "Rest Day", exercises: [:], forDay: .sunday, isRestDay: true)
    ]
    
    var currentDayAlternateExercises: Array<Exercise> = []
    
    
}
