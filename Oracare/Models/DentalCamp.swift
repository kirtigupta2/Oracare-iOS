import Foundation

struct DentalCamp: Identifiable, Hashable {
    let id: String
    /// Text shown on the date badge, exactly as designed ("OCT", "Nov", …).
    let badgeMonth: String
    let badgeDay: String
    let venue: String
    let kind: String
    /// Long form used on the Home "Dental Camp Nearby" card.
    var longDate: String? = nil
}

extension DentalCamp {
    static let samples: [DentalCamp] = [
        DentalCamp(
            id: "rk-dental-clinic",
            badgeMonth: "OCT",
            badgeDay: "24",
            venue: "RK Dental Clinic",
            kind: "Free Dental Checkup Camp",
            longDate: "Oct 24, 2026"
        ),
        DentalCamp(
            id: "thane-health-center",
            badgeMonth: "Nov",
            badgeDay: "08",
            venue: "Thane Health Center",
            kind: "Free Dental Checkup Camp"
        ),
        DentalCamp(
            id: "andheri-community-hall",
            badgeMonth: "Nov",
            badgeDay: "15",
            venue: "Andheri Community Hall",
            kind: "Oral Cancer Screening Camp"
        ),
        DentalCamp(
            id: "dadar-smile-clinic",
            badgeMonth: "Nov",
            badgeDay: "22",
            venue: "Dadar Smile Clinic",
            kind: "Senior Citizen Dental Camp"
        ),
    ]

    static var nearest: DentalCamp { samples[0] }
}
