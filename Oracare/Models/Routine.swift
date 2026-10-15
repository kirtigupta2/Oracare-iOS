import Foundation

enum RoutineSession: String, CaseIterable, Identifiable {
    case morning
    case evening

    var id: String { rawValue }

    var title: String {
        switch self {
        case .morning: return "Morning"
        case .evening: return "Evening"
        }
    }

    var steps: [RoutineStep] { RoutineStep.guidedSteps }

    /// Shown on the "Guided Steps" pill.
    var totalMinutes: Int { 8 }
}

struct RoutineStep: Identifiable, Hashable {
    let number: Int
    let title: String
    let duration: String
    var hasDentistAdvice: Bool = false

    var id: Int { number }
}

extension RoutineStep {
    static let guidedSteps: [RoutineStep] = [
        RoutineStep(number: 1, title: "Rinse", duration: "30 Seconds"),
        RoutineStep(number: 2, title: "Brush Upper Teeth", duration: "2 Minutes"),
        RoutineStep(number: 3, title: "Brush Lower Teeth", duration: "2 Minutes"),
        RoutineStep(number: 4, title: "Tongue Cleaning", duration: "30 Seconds"),
        RoutineStep(number: 5, title: "Flossing", duration: "1 Minute", hasDentistAdvice: true),
        RoutineStep(number: 6, title: "Mouthwash", duration: "1 Minute"),
    ]
}
