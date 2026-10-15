import SwiftUI

struct HomeView: View {
    @Environment(AppModel.self) private var model

    var body: some View {
        @Bindable var model = model

        NavigationStack(path: $model.homePath) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    greeting
                    scoreCard
                    tipCard
                    quickActions
                    doctorCard
                    nextVisitCard
                    dentalCampCard
                }
                .padding(.horizontal, 24)
                .padding(.top, 4)
                .padding(.bottom, 24)
            }
            .background(Color.oraBackground)
            .safeAreaInset(edge: .top, spacing: 0) {
                OraTabHeader(title: "Oracare")
            }
            // The tab root draws its own header; the title is what pushed screens show on their back button.
            .navigationTitle("Home")
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(for: HomeRoute.self) { route in
                switch route {
                case .dentalCamps: DentalCampsView()
                case .changeDoctor: ChangeDoctorView()
                }
            }
        }
    }

    // MARK: Greeting

    private var greeting: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Good Morning, \(model.userName)")
                .oraFont(.title)
                .foregroundStyle(.oraTextPrimary)
                .accessibilityAddTraits(.isHeader)
            Text("Welcome back!")
                .oraFont(.body)
                .foregroundStyle(.oraTextSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: Oral Health Score

    private var scoreCard: some View {
        Button {
            model.selectedTab = .report
        } label: {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("Oral Health Score")
                        .oraFont(.heading)
                        .foregroundStyle(.oraTextPrimary)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer(minLength: 12)
                    OraChip(text: "+4% since last scan", icon: .trendingUp)
                }

                HStack(spacing: 16) {
                    OraScoreGauge(score: 78)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Excellent progress this week")
                            .oraFont(.bodyMedium)
                            .foregroundStyle(.oraTextPrimary)
                        Text("Your oral health is trending up. Keep your routine consistent to maintain this momentum.")
                            .oraFont(.body)
                            .foregroundStyle(.oraTextSecondary)
                    }
                    .multilineTextAlignment(.leading)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .oraCard()
        }
        .buttonStyle(.oraPress)
    }

    // MARK: Tip of the Day

    private var tipCard: some View {
        HStack(spacing: 16) {
            OraAsset.tip.icon(size: 48)
            VStack(alignment: .leading, spacing: 8) {
                Text("Tip of the Day")
                    .oraFont(.heading)
                    .foregroundStyle(.oraTextPrimary)
                Text("Complete your Dental Routines daily and earn Health Points to redeem at your Dentist Appointments.")
                    .oraFont(.body)
                    .foregroundStyle(.oraTextSecondary)
                Button {
                    // TODO: open tip details
                } label: {
                    Text("Know More")
                        .oraFont(.bodyMedium)
                        .foregroundStyle(.oraPrimary)
                }
                .buttonStyle(.oraPress)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .oraCard()
    }

    // MARK: Quick Actions

    private var quickActions: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Quick Actions")
                .oraFont(.heading)
                .foregroundStyle(.oraTextPrimary)
                .accessibilityAddTraits(.isHeader)

            LazyVGrid(
                columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible())],
                spacing: 16
            ) {
                quickAction("Link Kiosk", icon: .quickLinkKiosk) {
                    // TODO: link a kiosk
                }
                quickAction("Book Appointment", icon: .quickBookAppointment) {
                    // TODO: book an appointment
                }
                quickAction("Talk to Dentist", icon: .quickTalkDentist) {
                    // TODO: talk to dentist
                }
                quickAction("Start a Routine", icon: .quickStartRoutine) {
                    model.selectedTab = .routine
                }
            }
        }
    }

    private func quickAction(_ title: String, icon: OraAsset, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 8) {
                icon.icon(size: 48)
                Text(title)
                    .oraFont(.bodyMedium)
                    .foregroundStyle(.oraTextPrimary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, minHeight: 105.6)
            .oraCard()
        }
        .buttonStyle(.oraPress)
    }

    // MARK: Your Doctor

    private var doctorCard: some View {
        let doctor = model.currentDoctor

        return HStack(spacing: 16) {
            OraTile {
                OraAsset.userRound.icon(size: 24)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Your Doctor")
                    .oraFont(.heading)
                    .foregroundStyle(.oraTextPrimary)
                Text(doctor.homeSummary)
                    .oraFont(.subhead)
                    .foregroundStyle(.oraTextSecondary)
                Text(doctor.homeClinicLine)
                    .oraFont(.subhead)
                    .foregroundStyle(.oraTextSecondary)
                Button {
                    model.homePath.append(.changeDoctor)
                } label: {
                    Text("Change Doctor").oraPill(.filled)
                }
                .buttonStyle(.oraPress)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .oraCard()
    }

    // MARK: Next Dentist Visit

    private var nextVisitCard: some View {
        HStack(spacing: 16) {
            OraAsset.nextVisit.icon(size: 48)
            VStack(alignment: .leading, spacing: 8) {
                Text("Next Dentist Visit")
                    .oraFont(.heading)
                    .foregroundStyle(.oraTextPrimary)
                Text("Dr. Sarah Malik • Oct 15, 2024 • 10:30 AM")
                    .oraFont(.subhead)
                    .foregroundStyle(.oraTextSecondary)
                Text("Shree Dental Clinic")
                    .oraFont(.subhead)
                    .foregroundStyle(.oraTextSecondary)
                Button {
                    // TODO: reschedule appointment
                } label: {
                    Text("Reschedule").oraPill(.filled)
                }
                .buttonStyle(.oraPress)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .oraCard()
    }

    // MARK: Dental Camp Nearby

    private var dentalCampCard: some View {
        let camp = DentalCamp.nearest

        return Button {
            model.homePath.append(.dentalCamps)
        } label: {
            HStack(spacing: 16) {
                OraAsset.dentalCamp.icon(size: 48)
                VStack(alignment: .leading, spacing: 8) {
                    Text("Dental Camp Nearby")
                        .oraFont(.heading)
                        .foregroundStyle(.oraTextPrimary)
                    Text([camp.kind, camp.longDate].compactMap { $0 }.joined(separator: " • "))
                        .oraFont(.subhead)
                        .foregroundStyle(.oraTextSecondary)
                    Text(camp.venue)
                        .oraFont(.subhead)
                        .foregroundStyle(.oraTextSecondary)
                    Text("Register").oraPill(.filled)
                }
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .oraCard()
        }
        .buttonStyle(.oraPress)
    }
}

#Preview {
    HomeView()
        .environment(AppModel())
}
