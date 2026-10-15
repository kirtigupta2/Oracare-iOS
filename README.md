# Oracare iOS

SwiftUI implementation of the Oracare mobile flow from Figma
([Oracare — Interface for Mobile](https://www.figma.com/design/5nXv7wLJ0kaUqbMaIUDJ2O/Oracare--Interface-for-Mobile?node-id=697-9394)).
Designed for **iPhone 16 Pro** (402 × 874 pt).

## Run it

1. Open `Oracare.xcodeproj` in **Xcode 16 or later**.
2. Pick the **iPhone 16 Pro** simulator and press **Run**.

Requires iOS 18+ (uses `@Observable` and the iOS 18 `Tab` API). No third-party dependencies.

## The flow

| Screen | Figma frame | File |
| --- | --- | --- |
| Home | iOS — Homepage | `Features/Home/HomeView.swift` |
| Dental Camps | iOS — Dental Camps | `Features/DentalCamps/DentalCampsView.swift` |
| Change Doctor | iOS — Change Doctor | `Features/ChangeDoctor/ChangeDoctorView.swift` |
| Routine (Morning / Evening) | iOS — Routine Overview, Routine Overview- Evening | `Features/Routine/RoutineView.swift` |
| Report | iOS — Oral Report | `Features/Report/ReportView.swift` |
| Community | _not in the flow yet_ | `Features/Community/CommunityView.swift` (placeholder) |

Navigation:

- `TabView` with Home · Routine · Report · Community (`Navigation/RootTabView.swift`).
- Home owns a `NavigationStack`: the **Dental Camp Nearby** card pushes Dental Camps and **Change Doctor** pushes Change Doctor.
- **Oral Health Score** jumps to the Report tab; **Start a Routine** jumps to the Routine tab.
- **Confirm Change** makes the selected dentist the current doctor and returns Home, where the **Your Doctor** card updates.
- Shared state lives in `AppModel` (`Navigation/AppModel.swift`).

## Project layout

```
Oracare/
  OracareApp.swift
  Navigation/     AppModel, RootTabView
  DesignSystem/   Colors, Typography, Components, OraAsset
  Models/         Doctor, DentalCamp, Routine
  Features/       one folder per screen
  Assets.xcassets Colors/ + Icons/ exported from Figma
```

### Design system

- **Colors** are named color sets whose names match the Figma variables (`TextPrimary`, `PrimaryContainer`, `ReportGood`, …), exposed as `.oraPrimary`, `.oraTextSecondary`, etc. `AccentColor` is Primary Dark (`#00796B`), so system controls (tab selection, back button) pick it up.
- **Typography** is SF Pro via `.oraFont(_:)`; sizes come from Figma and scale with Dynamic Type.
- **Components**: `oraCard()`, `OraPill`, `OraActionButton`, `OraBadgeTile`, `OraChip`, `OraScoreGauge` (drawn natively), `OraTabHeader`.
- **Icons / images** are the Figma exports, referenced through the `OraAsset` enum. Tab icons are template images so the system tints them.

## Not wired up yet

These have no destination in the current Figma flow and are marked `// TODO` in code:
Care Hub and profile buttons, Know More, Link Kiosk, Book Appointment, Talk to Dentist, Reschedule, camp Register buttons, step detail rows, Begin Routine, Email Report, Download PDF.
