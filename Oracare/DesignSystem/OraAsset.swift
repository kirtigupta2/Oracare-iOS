import SwiftUI

/// Images exported from the Figma file ("Oracare — Interface for Mobile").
/// Raw values are the imageset names in Assets.xcassets/Icons.
enum OraAsset: String {
    // Header + shared
    case chat = "icon-chat"
    case userRoundHeader = "icon-user-round-header"
    case userRound = "icon-user-round"
    case userRoundDoctor = "icon-user-round-doctor"
    case trendingUp = "icon-trending-up"
    case chevronRight = "icon-chevron-right"
    case check = "icon-check"

    // Home
    case tip = "icon-tip"
    case quickLinkKiosk = "icon-quick-link-kiosk"
    case quickBookAppointment = "icon-quick-book-appointment"
    case quickTalkDentist = "icon-quick-talk-dentist"
    case quickStartRoutine = "icon-quick-start-routine"
    case nextVisit = "icon-next-visit"
    case dentalCamp = "icon-dental-camp"

    // Routine
    case clock = "icon-clock"
    case advice = "icon-advice"
    case play = "icon-play"

    // Report
    case toothMap = "tooth-map"
    case note = "icon-note"
    case email = "icon-email"
    case download = "icon-download"

    // Tab bar (template images, tinted by the system)
    case tabHome = "tab-home"
    case tabHomeSelected = "tab-home-selected"
    case tabRoutine = "tab-routine"
    case tabRoutineSelected = "tab-routine-selected"
    case tabReport = "tab-report"
    case tabReportSelected = "tab-report-selected"
    case tabCommunity = "tab-community"

    var image: Image { Image(rawValue) }

    /// A fixed-size, decorative icon.
    func icon(size: CGFloat) -> some View {
        image
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .accessibilityHidden(true)
    }
}
