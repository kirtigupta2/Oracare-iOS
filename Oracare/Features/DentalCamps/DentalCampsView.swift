import SwiftUI

struct DentalCampsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                OraScreenTitle(
                    title: "Dental Camps",
                    subtitle: "Free dental check-up camps near you in Pimpri."
                )

                VStack(spacing: 12) {
                    ForEach(DentalCamp.samples) { camp in
                        CampRow(camp: camp)
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            .padding(.bottom, 24)
        }
        .background(Color.oraBackground)
        // The large title lives in the content (as designed); the bar only shows the back button.
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct CampRow: View {
    let camp: DentalCamp

    var body: some View {
        HStack(spacing: 16) {
            OraBadgeTile(top: camp.badgeMonth, bottom: camp.badgeDay)

            VStack(alignment: .leading, spacing: 8) {
                Text(camp.venue)
                    .oraFont(.heading)
                    .foregroundStyle(.oraTextPrimary)
                Text(camp.kind)
                    .oraFont(.subhead)
                    .foregroundStyle(.oraTextSecondary)
                Button {
                    // TODO: register for this camp
                } label: {
                    Text("Register").oraPill(.tonal)
                }
                .buttonStyle(.oraPress)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .oraCard()
    }
}

#Preview {
    NavigationStack {
        DentalCampsView()
    }
}
