//
//  pandaSystemApp.swift
//  pandaSystem
//
//  Created by Yusuke Tomatsu on 2020/11/23.
//

import SwiftUI
import Firebase

@main
struct pandaSystemApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
           
           FirebaseApp.configure()
           return true
    }
}
