// HKActivitySummaryExtensions.swift - Copyright 2020 SwifterSwift

#if canImport(HealthKit)
import HealthKit

// MARK: - Properties

@available(watchOS 2.2, *)
public extension HKActivitySummary {
    /// SS: Check if stand goal is met
    var isStandGoalMet: Bool { appleStandHoursGoal.compare(appleStandHours) != .orderedDescending }

    /// SS: Check if exercise time goal is met
    var isExerciseTimeGoalMet: Bool { appleExerciseTimeGoal.compare(appleExerciseTime) != .orderedDescending }

    /// SS: Check if active energy goal is met
    var isEnergyBurnedGoalMet: Bool { activeEnergyBurnedGoal.compare(activeEnergyBurned) != .orderedDescending }
}

#endif
