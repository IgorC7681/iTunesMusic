//
//  AppDelegate.swift
//  iTunesMusic
//
//  Created by TaiYi Chien on 2022/11/18.
//

import UIKit
import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        return true
    }


}

