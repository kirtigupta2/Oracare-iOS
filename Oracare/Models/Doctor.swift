import Foundation

struct Doctor: Identifiable, Hashable {
    let id: String
    let name: String
    var qualification: String? = nil
    let clinic: String
    let distanceKm: Double
    let languages: [String]
    var fee: Int? = nil
    var nextSlot: String? = nil

    private var distanceText: String { String(format: "%.1f km", distanceKm) }
    private var languagesText: String { languages.joined(separator: ", ") }

    /// "Dr. Sarah Malik • BDS • 2.1 km away"
    var homeSummary: String {
        [name, qualification, "\(distanceText) away"]
            .compactMap { $0 }
            .joined(separator: " • ")
    }

    /// "Shree Dental Clinic • Speaks Marathi, Hindi, English"
    var homeClinicLine: String {
        "\(clinic) • Speaks \(languagesText)"
    }

    /// "Current doctor • Shree Dental Clinic"
    var currentDoctorLine: String {
        "Current doctor • \(clinic)"
    }

    /// "1.4 km • Marathi, Hindi • ₹400 • Next slot: Tomorrow 10:30 AM"
    var nearbyLine: String {
        [
            distanceText,
            languagesText,
            fee.map { "₹\($0)" },
            nextSlot.map { "Next slot: \($0)" },
        ]
        .compactMap { $0 }
        .joined(separator: " • ")
    }
}

extension Doctor {
    static let samples: [Doctor] = [
        Doctor(
            id: "sarah-malik",
            name: "Dr. Sarah Malik",
            qualification: "BDS",
            clinic: "Shree Dental Clinic",
            distanceKm: 2.1,
            languages: ["Marathi", "Hindi", "English"]
        ),
        Doctor(
            id: "anil-deshmukh",
            name: "Dr. Anil Deshmukh",
            clinic: "Deshmukh Dental Care",
            distanceKm: 1.4,
            languages: ["Marathi", "Hindi"],
            fee: 400,
            nextSlot: "Tomorrow 10:30 AM"
        ),
        Doctor(
            id: "meera-joshi",
            name: "Dr. Meera Joshi",
            clinic: "Joshi Dental Studio",
            distanceKm: 1.9,
            languages: ["Marathi", "English"],
            fee: 450,
            nextSlot: "Thu 4:00 PM"
        ),
        Doctor(
            id: "rahul-patil",
            name: "Dr. Rahul Patil",
            clinic: "Patil Dental Clinic",
            distanceKm: 2.6,
            languages: ["Hindi", "English"],
            fee: 350,
            nextSlot: "Fri 11:00 AM"
        ),
    ]
}
