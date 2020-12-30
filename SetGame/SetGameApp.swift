import SwiftUI

@main
struct SetGameApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: SetGameViewModel())
        }
    }
}
