//
//  ContentView.swift
//  UserDefaultWrapper
//
//  Created by Dulio Denis on 6/24/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var settings = SettingsManager()
    
    var body: some View {
        Form {
            Section(header: Text("User Information")) {
                TextField("Username", text: Binding(
                    get: { self.settings.username },
                    set: { self.settings.username = $0 }
                ))
                Toggle("Subscribed", isOn: Binding(
                    get: { self.settings.isSubscribed },
                    set: { self.settings.isSubscribed = $0 }
                ))
            }
            
            Section(header: Text("App Information")) {
                Text("Launch Count: \(settings.launchCount)")
                Button("Increment Launch Count") {
                    settings.launchCount += 1
                }
            }
            
            Section {
                Button("Reset All") {
                    settings.resetAll()
                }
            }
        }
        .navigationTitle("UserDefault Demo")
    }
}


#Preview {
    ContentView()
}
