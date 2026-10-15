import SwiftUI

// Brand colors. Each one is a named color set in Assets.xcassets whose name
// matches the Figma variable (Text/Primary -> "TextPrimary", ...).
//
// Declared on `ShapeStyle where Self == Color` so they work both as
// `Color.oraPrimary` and as `.foregroundStyle(.oraPrimary)`.
extension ShapeStyle where Self == Color {
    static var oraPrimary: Color { Color("Primary") }                          // Primary/Primary  #00897B
    static var oraPrimaryDark: Color { Color("PrimaryDark") }                  // Primary/Primary Dark  #00796B
    static var oraPrimaryContainer: Color { Color("PrimaryContainer") }        // Primary/Container  #E0F2F1
    static var oraPrimaryContainerStrong: Color { Color("PrimaryContainerStrong") } // Primary/Container Strong  #CAE6DF
    static var oraOnPrimaryContainer: Color { Color("OnPrimaryContainer") }    // Primary/On Primary Container  #006B60

    static var oraTextPrimary: Color { Color("TextPrimary") }                  // Text/Primary  #1C2F3F
    static var oraTextSecondary: Color { Color("TextSecondary") }              // Text/Secondary  #4B645F

    static var oraBackground: Color { Color("SurfaceBackground") }             // Surface/Background  #F4F7F6
    static var oraBorder: Color { Color("BorderSubtle") }                      // Border/Subtle  #DCE4E2
    static var oraWhite: Color { Color("NeutralWhite") }                       // Neutral/White  #FFFFFF

    static var oraWarning: Color { Color("StatusWarning") }                    // Status/Warning  #F59E0B
    static var oraWarningContainer: Color { Color("StatusWarningContainer") }  // Status/Warning Container  #FEF3C7

    static var oraReportGood: Color { Color("ReportGood") }                    // Report/Good  #8BC63F
    static var oraReportFair: Color { Color("ReportFair") }                    // Report/Fair  #FFCA29
    static var oraReportPoor: Color { Color("ReportPoor") }                    // Report/Poor  #EE3923
}
