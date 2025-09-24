//
//  ContentView.swift
//  RoushetaRagameya
//
//  Created by HealthFlow Team on 2025-01-24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var localizationManager: LocalizationManager
    @State private var showSplash = true
    
    var body: some View {
        Group {
            if showSplash {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                showSplash = false
                            }
                        }
                    }
            } else if appState.isLoggedIn {
                MainTabView()
                    .transition(.opacity)
            } else {
                AuthenticationView()
                    .transition(.slide)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: showSplash)
        .animation(.easeInOut(duration: 0.3), value: appState.isLoggedIn)
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
        .environmentObject(LocalizationManager.shared)
}
