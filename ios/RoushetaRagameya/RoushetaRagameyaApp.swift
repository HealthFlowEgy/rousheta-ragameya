//
//  RoushetaRagameyaApp.swift
//  RoushetaRagameya
//
//  Created by HealthFlow Team on 2025-01-24.
//

import SwiftUI
import Firebase
import UserNotifications

@main
struct RoushetaRagameyaApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var localizationManager = LocalizationManager.shared
    @StateObject private var networkManager = NetworkManager.shared
    
    init() {
        setupFirebase()
        setupNotifications()
        setupAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .environmentObject(localizationManager)
                .environmentObject(networkManager)
                .environment(\.layoutDirection, localizationManager.isRTL ? .rightToLeft : .leftToRight)
                .environment(\.locale, Locale(identifier: localizationManager.currentLanguage))
                .preferredColorScheme(appState.colorScheme)
                .onAppear {
                    appState.initialize()
                }
        }
    }
    
    private func setupFirebase() {
        guard let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") else {
            print("⚠️ GoogleService-Info.plist not found")
            return
        }
        
        guard let options = FirebaseOptions(contentsOfFile: path) else {
            print("⚠️ Failed to load Firebase options")
            return
        }
        
        FirebaseApp.configure(options: options)
    }
    
    private func setupNotifications() {
        UNUserNotificationCenter.current().delegate = NotificationDelegate.shared
        
        Task {
            await requestNotificationPermission()
        }
    }
    
    private func setupAppearance() {
        // Customize UIKit components that SwiftUI doesn't control
        UITabBar.appearance().backgroundColor = UIColor(Color.healthFlowLight)
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.healthFlowDark.opacity(0.6))
        UITabBar.appearance().tintColor = UIColor(Color.healthFlowPrimary)
        
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor(Color.healthFlowDark)
        ]
    }
    
    @MainActor
    private func requestNotificationPermission() async {
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .badge, .sound]
            )
            
            if granted {
                await UIApplication.shared.registerForRemoteNotifications()
                print("✅ Notification permission granted")
            } else {
                print("❌ Notification permission denied")
            }
        } catch {
            print("❌ Failed to request notification permission: \(error)")
        }
    }
}
