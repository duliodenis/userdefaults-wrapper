//
//  SettingsManager.swift
//  UserDefaultWrapper
//
//  Created by Dulio Denis on 6/29/24.
//

import Foundation

class SettingsManager: ObservableObject {
    @UserDefault("username", defaultValue: "Guest")
    var username: String {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault("isSubscribed", defaultValue: false)
    var isSubscribed: Bool {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault("launchCount", defaultValue: 0)
    var launchCount: Int {
        willSet {
            objectWillChange.send()
        }
    }
    
    func resetAll() {
        $username.reset()
        $isSubscribed.reset()
        $launchCount.reset()
        
        // Notify UI to update
        username = "Guest"
        isSubscribed = false
        launchCount = 0
    }
}
