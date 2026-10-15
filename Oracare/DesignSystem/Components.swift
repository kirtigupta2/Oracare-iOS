import SwiftUI

// MARK: - Card

extension View {
    /// White rounded card with the subtle 0.8pt border used across the app.
    func oraCard(
        padding: CGFloat = 20,
        fill: Color = .oraWhite,
        border: Color = .oraBorder
    ) -> some View {
        self
            .padding(padding)
            .background(fill, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .strokeBorder(border, lineWidth: 0.8)
            }
    }
}

// MARK: - Press feedback for tappable cards / text buttons

struct OraPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}

extension ButtonStyle where Self == OraPressStyle {
    static var oraPress: OraPressStyle { OraPressStyle() }
}

// MARK: - 48pt rounded tiles

/// 48×48 rounded tile that frames an icon (doctor avatar, etc.).
struct OraTile<Content: View>: View {
    var fill: Color = .oraPrimaryContainer
    var border: Color? = nil
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .frame(width: 48, height: 48)
            .background(fill, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
            .overlay {
                if let border {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .strokeBorder(border, lineWidth: 1)
                }
            }
    }
}

/// Two-line text badge: "OCT / 24" on camps, "Step / 1" on routine steps.
struct OraBadgeTile: View {
    let top: String
    let bottom: String

    var body: some View {
        VStack(spacing: 2) {
            Text(top).oraFont(.badgeLabel)
            Text(bottom).oraFont(.badgeValue)
        }
        .foregroundStyle(.oraPrimary)
        .fixedSize()
        .frame(width: 48)
        .padding(.vertical, 10)
        .background(Color.oraPrimaryContainer, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(top) \(bottom)")
    }
}

// MARK: - Pills (extra-small buttons / chips)

enum OraPillKind {
    case filled      // solid teal, white label  – "Change Doctor", "Register" on Home
    case tonal       // soft teal                – "Register" on Dental Camps
    case container   // pale teal                – "8 Minutes", "Dentist’s Advice"
}

private struct OraPillModifier: ViewModifier {
    let kind: OraPillKind

    func body(content: Content) -> some View {
        content
            .oraFont(.subheadMedium)
            .foregroundStyle(foreground)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .frame(minWidth: 48)
            .background(background, in: Capsule())
    }

    private var foreground: Color {
        switch kind {
        case .filled: return .oraWhite
        case .tonal, .container: return .oraOnPrimaryContainer
        }
    }

    private var background: Color {
        switch kind {
        case .filled: return .oraPrimaryDark
        case .tonal: return .oraPrimaryContainerStrong
        case .container: return .oraPrimaryContainer
        }
    }
}

extension View {
    func oraPill(_ kind: OraPillKind) -> some View {
        modifier(OraPillModifier(kind: kind))
    }
}

/// Pale chip used for "+4% since last scan" and "32 Points Checked".
struct OraChip: View {
    let text: String
    var icon: OraAsset? = nil

    var body: some View {
        HStack(spacing: 6) {
            if let icon {
                icon.icon(size: 18)
            }
            Text(text)
                .oraFont(.subheadMedium)
                .foregroundStyle(.oraPrimary)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(Color.oraPrimaryContainer, in: Capsule())
    }
}

// MARK: - Full-width action buttons

/// Rounded-rectangle button with a leading icon.
/// `.filled` is the primary call to action; `.outlined` is the pale button with a teal outline.
struct OraActionButton: View {
    enum Kind { case filled, outlined }

    let title: String
    let icon: OraAsset
    var kind: Kind = .filled
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                icon.icon(size: 24)
                Text(title).oraFont(.bodyMedium)
            }
            .foregroundStyle(kind == .filled ? Color.oraWhite : Color.oraOnPrimaryContainer)
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, alignment: kind == .filled ? .center : .leading)
            .background(
                kind == .filled ? Color.oraPrimaryDark : Color.oraPrimaryContainer,
                in: RoundedRectangle(cornerRadius: 12, style: .continuous)
            )
            .overlay {
                if kind == .outlined {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .strokeBorder(Color.oraOnPrimaryContainer, lineWidth: 1)
                }
            }
        }
        .buttonStyle(.oraPress)
    }
}

// MARK: - Score gauge

/// Circular gauge showing "78 /100". Drawn natively so it follows the data.
struct OraScoreGauge: View {
    let score: Int
    var maximum: Int = 100

    private let lineWidth: CGFloat = 12

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.oraPrimaryContainer, lineWidth: lineWidth)
                .padding(lineWidth / 2)
            Circle()
                .trim(from: 0, to: CGFloat(score) / CGFloat(maximum))
                .stroke(Color.oraPrimary, lineWidth: lineWidth)
                .rotationEffect(.degrees(-90))
                .padding(lineWidth / 2)
            VStack(spacing: 0) {
                Text("\(score)")
                    .oraFont(.scoreValue)
                    .foregroundStyle(.oraTextPrimary)
                Text("/\(maximum)")
                    .oraFont(.subhead)
                    .foregroundStyle(.oraTextSecondary)
            }
        }
        .frame(width: 96, height: 96)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Oral health score")
        .accessibilityValue("\(score) out of \(maximum)")
    }
}

// MARK: - Headers

/// Title + subtitle block used under the nav bar.
struct OraScreenTitle: View {
    let title: String
    var subtitle: String? = nil
    var style: OraTextStyle = .largeTitle

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .oraFont(style)
                .foregroundStyle(.oraTextPrimary)
                .accessibilityAddTraits(.isHeader)
            if let subtitle {
                Text(subtitle)
                    .oraFont(.body)
                    .foregroundStyle(.oraTextSecondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

/// Pinned header for the four tab roots: large bold title + Care Hub and profile buttons.
struct OraTabHeader: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .oraFont(.largeTitle)
                .foregroundStyle(.oraTextPrimary)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack(spacing: 12) {
                headerButton(.chat, label: "Care Hub") {
                    // TODO: open Care Hub (not part of this flow)
                }
                headerButton(.userRoundHeader, label: "Profile") {
                    // TODO: open profile (not part of this flow)
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 10)
        .background(Color.oraBackground)
    }

    private func headerButton(_ asset: OraAsset, label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            asset.icon(size: 20)
                .frame(width: 36, height: 36)
                .background(Color.oraPrimaryContainer, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
        .buttonStyle(.oraPress)
        .accessibilityLabel(label)
    }
}
