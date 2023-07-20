//
//  ContentView.swift
//  BiometricAuth
//
//  Created by Fahim Rahman on 2023-07-20.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    
    @State private var isUnlocked = false
    @State private var lockUnlockStatus = "Locked. Tap to Authenticate"
    
    var body: some View {
        VStack {
            self.isUnlocked ? Text(lockUnlockStatus) : Text(lockUnlockStatus)
        }
        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height, alignment: .center)
        .padding()
        .onTapGesture { self.authenticate() }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "We need to check if it's you") { success, _ in
                if success {
                    self.lockUnlockStatus = "Successfully Authenticated"
                    self.isUnlocked = true
                } else {
                    self.lockUnlockStatus = "Failed to Authenticate"
                    self.isUnlocked = false
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
