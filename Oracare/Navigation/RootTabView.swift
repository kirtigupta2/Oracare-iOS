import SwiftUI

struct RootTabView: View {
    @Environment(AppModel.self) private var model

    var body: some View {
        @Bindable var model = model

        TabView(selection: $model.selectedTab) {
            Tab(value: AppTab.home) {
                HomeView()
            } label: {
                tabLabel(.home)
            }

            Tab(value: AppTab.routine) {
                RoutineView()
            } label: {
                tabLabel(.routine)
            }

            Tab(value: AppTab.report) {
                ReportView()
            } label: {
                tabLabel(.report)
            }

            Tab(value: AppTab.community) {
                CommunityView()
            } label: {
                tabLabel(.community)
            }
        }
    }

    private func tabLabel(_ tab: AppTab) -> some View {
        Label {
            Text(tab.title)
        } icon: {
            tab.icon(selected: model.selectedTab == tab).image
        }
    }
}

#Preview {
    RootTabView()
        .environment(AppModel())
}
