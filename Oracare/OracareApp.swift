import SwiftUI

@main
struct OracareApp: App {
    @State private var model = AppModel()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environment(model)
                // The design is light-only for now.
                .preferredColorScheme(.light)
        }
    }
}
