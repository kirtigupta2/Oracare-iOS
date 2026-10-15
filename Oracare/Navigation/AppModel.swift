import Observation
import SwiftUI

enum AppTab: Hashable {
    case home, routine, report, community

    func icon(selected: Bool) -> OraAsset {
        switch self {
        case .home: return selected ? .tabHomeSelected : .tabHome
        case .routine: return selected ? .tabRoutineSelected : .tabRoutine
        case .report: return selected ? .tabReportSelected : .tabReport
        case .community: return .tabCommunity
        }
    }

    var title: String {
        switch self {
        case .home: return "Home"
        case .routine: return "Routine"
        case .report: return "Report"
        case .community: return "Community"
        }
    }
}

/// Screens pushed from Home.
enum HomeRoute: Hashable {
    case dentalCamps
    case changeDoctor
}

/// Shared state for the whole flow: which tab is selected, the Home navigation
/// stack, and the patient's current doctor.
@Observable
final class AppModel {
    var selectedTab: AppTab = .home
    var homePath: [HomeRoute] = []

    var userName = "Rajan"

    private(set) var doctors: [Doctor] = Doctor.samples
    private(set) var currentDoctorID: Doctor.ID = Doctor.samples[0].id

    var currentDoctor: Doctor {
        doctors.first { $0.id == currentDoctorID } ?? doctors[0]
    }

    var nearbyDoctors: [Doctor] {
        doctors.filter { $0.id != currentDoctorID }
    }

    /// Makes `id` the current doctor and returns to Home.
    func changeDoctor(to id: Doctor.ID) {
        guard doctors.contains(where: { $0.id == id }) else { return }
        currentDoctorID = id
        homePath.removeAll()
    }
}
