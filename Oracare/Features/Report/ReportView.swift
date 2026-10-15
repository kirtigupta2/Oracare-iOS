import SwiftUI

struct ReportView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    scanHeader
                    toothMapCard
                    statCards
                    dentistNoteCard
                    shareCard
                }
                .padding(.horizontal, 24)
                .padding(.top, 4)
                .padding(.bottom, 24)
            }
            .background(Color.oraBackground)
            .safeAreaInset(edge: .top, spacing: 0) {
                OraTabHeader(title: "Report")
            }
            .navigationTitle("Report")
            .toolbar(.hidden, for: .navigationBar)
        }
    }

    // MARK: Latest scan

    private var scanHeader: some View {
        HStack(alignment: .top, spacing: 8) {
            VStack(alignment: .leading, spacing: 8) {
                OraScreenTitle(
                    title: "Latest Scan",
                    subtitle: "Your latest Oral Scan Summary",
                    style: .title
                )
                OraChip(text: "+4% since last scan", icon: .trendingUp)
            }
            OraScoreGauge(score: 78)
        }
    }

    // MARK: Interactive tooth map

    private var toothMapCard: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Interactive Tooth Map")
                    .oraFont(.heading)
                    .foregroundStyle(.oraTextPrimary)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer(minLength: 12)
                OraChip(text: "32 Points Checked")
            }

            VStack(spacing: 8) {
                Text("Upper Jaw")
                    .oraFont(.bodyMedium)
                    .foregroundStyle(.oraTextPrimary)

                // The exported PNG has its own "Upper/Lower Jaw" captions baked in; the design crops
                // them away (image is 100.32% × 109.73% of the frame, offset -0.34% / -5.21%) and
                // shows live text instead. The dashed jaw frames are part of the image.
                Color.clear
                    .aspectRatio(297.0 / 353.0, contentMode: .fit)
                    .frame(maxWidth: 297)
                    .overlay(alignment: .topLeading) {
                        GeometryReader { proxy in
                            OraAsset.toothMap.image
                                .resizable()
                                .frame(width: proxy.size.width * 1.0032, height: proxy.size.height * 1.0973)
                                .offset(x: -proxy.size.width * 0.0034, y: -proxy.size.height * 0.0521)
                        }
                    }
                    .clipped()
                    .accessibilityElement()
                    .accessibilityLabel("Tooth map of the upper and lower jaw. Green teeth are healthy, yellow need monitoring, red need action.")

                Text("Lower Jaw")
                    .oraFont(.bodyMedium)
                    .foregroundStyle(.oraTextPrimary)
            }

            HStack {
                legendItem("Healthy", color: .oraReportGood)
                Spacer()
                legendItem("Monitor", color: .oraReportFair)
                Spacer()
                legendItem("Action", color: .oraReportPoor)
            }
            .frame(maxWidth: 297)
            .padding(.top, 4)
        }
        .frame(maxWidth: .infinity)
        .oraCard()
    }

    private func legendItem(_ title: String, color: Color) -> some View {
        HStack(spacing: 6) {
            Circle()
                .fill(color)
                .frame(width: 10, height: 10)
            Text(title)
                .oraFont(.body)
                .foregroundStyle(.oraTextSecondary)
        }
    }

    // MARK: Gum health / plaque

    private var statCards: some View {
        HStack(spacing: 16) {
            statCard(
                value: "Good",
                label: "Gum Health",
                valueColor: .oraPrimaryDark,
                valueBackground: .oraPrimaryContainer
            )
            statCard(
                value: "Moderate",
                label: "Plaque Level",
                valueColor: .oraWarning,
                valueBackground: .oraWarningContainer
            )
        }
    }

    private func statCard(value: String, label: String, valueColor: Color, valueBackground: Color) -> some View {
        VStack(spacing: 8) {
            Text(value)
                .oraFont(.bodyMedium)
                .foregroundStyle(valueColor)
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
                .background(valueBackground, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
            Text(label)
                .oraFont(.bodyMedium)
                .foregroundStyle(.oraTextPrimary)
        }
        .frame(maxWidth: .infinity)
        .oraCard()
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(label)
        .accessibilityValue(value)
    }

    // MARK: Dentist's note

    private var dentistNoteCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 16) {
                Circle()
                    .fill(Color.oraPrimaryContainer)
                    .frame(width: 40, height: 40)
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: 0) {
                    Text("Dentist’s Note")
                        .oraFont(.heading)
                        .foregroundStyle(.oraTextPrimary)
                    Text("Dr. Sarah Malik • Today")
                        .oraFont(.subhead)
                        .foregroundStyle(.oraTextSecondary)
                }

                Spacer(minLength: 0)

                OraAsset.note.icon(size: 42)
            }

            Text("\"Great improvement on the upper left molars. Continue the focused brushing technique we discussed.\"")
                .oraFont(.body)
                .foregroundStyle(.oraTextPrimary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .oraCard()
    }

    // MARK: Share

    private var shareCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Share Report")
                .oraFont(.bodyMedium)
                .foregroundStyle(.oraTextPrimary)

            OraActionButton(title: "Email Report", icon: .email, kind: .outlined) {
                // TODO: email the report
            }
            OraActionButton(title: "Download PDF", icon: .download, kind: .outlined) {
                // TODO: download the report as PDF
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .oraCard()
    }
}

#Preview {
    ReportView()
        .environment(AppModel())
}
