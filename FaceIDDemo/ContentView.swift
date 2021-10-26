//
//  ContentView.swift
//  FaceIDDemo
//
//  Created by Nicholas Verrico on 10/16/21.
//

import SwiftUI


import LocalAuthentication


// This view can be the first view and it does not need to contain any content, the background can simpley be black. Additional views can be presented from here and this can serve as the single biometric authenication and returning user authentication handling file for any size app.

struct ContentView: View {
    // Authenitcation State
    @State private var appState: AppState = .notLaunched
    
    enum AppState {
        case unlocked
        case locked
        case unableToUseBiometrics
        case notLaunched
    }
    
    var body: some View {
        // Demo text to show when state changes
        VStack {
            
            switch self.appState {
            case .unlocked:
                Text("Unlocked")
            case .locked:
                Text("Locked")
            case .unableToUseBiometrics:
                Text("Failed to access biometrics")
            case .notLaunched:
                Text("Welcome please login")
            }
          
        }
        // Used on first launch, will not retrigger when resuming from background
        .onAppear(perform: authenticate)
        
        // When the user opens the app again (soft launch)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)){_ in
            authenticate()
        }
        
        // If user dismisses app and then quickly reopens the background event will not be completed. It will keep the user authenticated. This requires est. 1.5 secs (iPhone 12 Physical device tested)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)){_ in
            self.appState = .unlocked
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // This will display on the first use of faceID OR TouchID
            let reason = "We use your  is a secure way to login"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {success, authError in
                DispatchQueue.main.async {
                    if success {
                        self.appState = .unlocked
                    } else {
                        self.appState = .unableToUseBiometrics
                    }
                }
            }
            
        } else {
            self.appState = .unableToUseBiometrics
        }
    }

}


   
