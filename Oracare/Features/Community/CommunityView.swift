import SwiftUI

/// Placeholder for the Community tab; it has no screen in the current Figma flow.
struct CommunityView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                "Community",
                systemImage: "person.3",
                description: Text("Coming soon.")
            )
            .navigationTitle("Community")
        }
    }
}

#Preview {
    CommunityView()
}
