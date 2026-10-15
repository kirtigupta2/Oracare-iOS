import SwiftUI

struct RoutineView: View {
    @State private var session: RoutineSession = .morning

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    OraScreenTitle(
                        title: "Daily Routine",
                        subtitle: "Follow the clinical sequence recommended for you, for a healthier smile.",
                        style: .title
                    )
                    .padding(.top, 4)

                    Picker("Routine time", selection: $session) {
                        ForEach(RoutineSession.allCases) { option in
                            Text(option.title).tag(option)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(maxWidth: 332)

                    guidedStepsCard
                    beginRoutineCard
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
            .background(Color.oraBackground)
            .safeAreaInset(edge: .top, spacing: 0) {
                OraTabHeader(title: "Routine")
            }
            .navigationTitle("Routine")
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    // MARK: Guided steps

    private var guidedStepsCard: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Guided Steps")
                    .oraFont(.heading)
                    .foregroundStyle(.oraTextPrimary)
                Spacer()
                HStack(spacing: 4) {
                    OraAsset.clock.icon(size: 20)
                    Text("\(session.totalMinutes) Minutes")
                }
                .oraPill(.container)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("\(session.totalMinutes) minutes")
            }
            .frame(minHeight: 32)

            VStack(spacing: 16) {
                ForEach(session.steps) { step in
                    StepCard(step: step)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .oraCard()
    }

    // MARK: Begin

    private var beginRoutineCard: some View {
        VStack(spacing: 12) {
            Text("Completing this routine will earn you 50\nHealth Points!")
                .oraFont(.body)
                .foregroundStyle(.oraTextSecondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)

            OraActionButton(title: "Begin Routine", icon: .play) {
                // TODO: start the guided routine (no screen designed in this flow yet)
            }
        }
        .oraCard()
    }
}

private struct StepCard: View {
    let step: RoutineStep

    var body: some View {
        Button {
            // TODO: open step detail (no screen designed in this flow yet)
        } label: {
            VStack(alignment: .leading, spacing: 12) {
                if step.hasDentistAdvice {
                    HStack(spacing: 4) {
                        OraAsset.advice.icon(size: 20)
                        Text("Dentist’s Advice")
                    }
                    .oraPill(.container)
                }

                HStack(spacing: 16) {
                    OraBadgeTile(top: "Step", bottom: "\(step.number)")

                    VStack(alignment: .leading, spacing: 8) {
                        Text(step.title)
                            .oraFont(.heading)
                            .foregroundStyle(.oraTextPrimary)
                        Text(step.duration)
                            .oraFont(.subhead)
                            .foregroundStyle(.oraTextSecondary)
                    }
                    .multilineTextAlignment(.leading)

                    Spacer(minLength: 0)

                    OraAsset.chevronRight.icon(size: 18)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .oraCard()
        }
        .buttonStyle(.oraPress)
    }
}

#Preview {
    RoutineView()
        .environment(AppModel())
}
