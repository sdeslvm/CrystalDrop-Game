import Foundation
import SwiftUI

struct CrystalDropDropInitialView: View {
    @StateObject private var gemThemeEngine = CrystalDropCrystalThemeEngine.shared
    @StateObject private var dropAudioManager = CrystalDropDropAudioManager.shared
    @StateObject private var vibrationManager = CrystalDropVibrationManager.shared
    
    private var gemDropGameEndpoint: URL { URL(string: "https://crystaldropgame.com/start")! }

    var body: some View {
        ZStack {
            // Static gem background
            Color.gemDropTheme(hex: "#335D8D")
                .ignoresSafeArea()
            
            CrystalDropDropLoadingScreen()
        }
        .onAppear {
            vibrationManager.gemSuccess()
        }
    }
}

#Preview {
    CrystalDropDropInitialView()
}
