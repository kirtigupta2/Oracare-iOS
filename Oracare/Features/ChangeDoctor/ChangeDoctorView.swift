import SwiftUI

struct ChangeDoctorView: View {
    @Environment(AppModel.self) private var model
    @State private var selectedID: Doctor.ID?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                OraScreenTitle(
                    title: "Change Doctor",
                    subtitle: "Dentists near Pimpri with open appointments. Your full history moves to your new doctor."
                )

                VStack(alignment: .leading, spacing: 12) {
                    currentDoctorCard

                    Text("Nearby dentists")
                        .oraFont(.subheadMedium)
                        .foregroundStyle(.oraTextSecondary)

                    ForEach(model.nearbyDoctors) { doctor in
                        nearbyDoctorRow(doctor)
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            .padding(.bottom, 24)
        }
        .background(Color.oraBackground)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            confirmBar
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if selectedID == nil {
                selectedID = model.nearbyDoctors.first?.id
            }
        }
    }

    // MARK: Pieces

    private var currentDoctorCard: some View {
        doctorRow(
            name: model.currentDoctor.name,
            detail: model.currentDoctor.currentDoctorLine,
            isSelected: false
        )
    }

    private func nearbyDoctorRow(_ doctor: Doctor) -> some View {
        let isSelected = selectedID == doctor.id

        return Button {
            selectedID = doctor.id
        } label: {
            doctorRow(name: doctor.name, detail: doctor.nearbyLine, isSelected: isSelected)
        }
        .buttonStyle(.oraPress)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    private func doctorRow(name: String, detail: String, isSelected: Bool) -> some View {
        HStack(spacing: 16) {
            OraTile(border: Color.oraOnPrimaryContainer) {
                OraAsset.userRoundDoctor.icon(size: 24)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .oraFont(.heading)
                    .foregroundStyle(.oraTextPrimary)
                Text(detail)
                    .oraFont(.subhead)
                    .foregroundStyle(.oraTextSecondary)
            }
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .oraCard(
            fill: isSelected ? .oraPrimaryContainer : .oraWhite,
            border: isSelected ? .oraPrimary : .oraBorder
        )
    }

    private var confirmBar: some View {
        OraActionButton(title: "Confirm Change", icon: .check) {
            if let selectedID {
                model.changeDoctor(to: selectedID)
            }
        }
        .disabled(selectedID == nil)
        .frame(maxWidth: 310)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(Color.oraWhite)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(Color.oraBorder)
                .frame(height: 1)
        }
    }
}

#Preview {
    NavigationStack {
        ChangeDoctorView()
    }
    .environment(AppModel())
}
