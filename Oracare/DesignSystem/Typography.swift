import SwiftUI

/// Text styles from the Oracare design (SF Pro). Sizes come from Figma, and each
/// style scales with Dynamic Type relative to the closest system text style.
enum OraTextStyle {
    case largeTitle     // 34 bold  – screen titles
    case title          // 28 bold  – section / tab-screen titles
    case scoreValue     // 28 medium – gauge value
    case heading        // 18 semibold – card titles
    case body           // 16 regular
    case bodyMedium     // 16 medium
    case subhead        // 14 regular
    case subheadMedium  // 14 medium
    case badgeLabel     // 11 bold  – "OCT", "Step"
    case badgeValue     // 18 bold  – "24", "1"

    fileprivate var spec: (size: CGFloat, weight: Font.Weight, relativeTo: Font.TextStyle) {
        switch self {
        case .largeTitle: return (34, .bold, .largeTitle)
        case .title: return (28, .bold, .title)
        case .scoreValue: return (28, .medium, .title)
        case .heading: return (18, .semibold, .headline)
        case .body: return (16, .regular, .body)
        case .bodyMedium: return (16, .medium, .body)
        case .subhead: return (14, .regular, .subheadline)
        case .subheadMedium: return (14, .medium, .subheadline)
        case .badgeLabel: return (11, .bold, .caption2)
        case .badgeValue: return (18, .bold, .headline)
        }
    }
}

private struct OraFontModifier: ViewModifier {
    @ScaledMetric private var size: CGFloat
    private let weight: Font.Weight

    init(style: OraTextStyle) {
        let spec = style.spec
        _size = ScaledMetric(wrappedValue: spec.size, relativeTo: spec.relativeTo)
        weight = spec.weight
    }

    func body(content: Content) -> some View {
        content.font(.system(size: size, weight: weight))
    }
}

extension View {
    func oraFont(_ style: OraTextStyle) -> some View {
        modifier(OraFontModifier(style: style))
    }
}
