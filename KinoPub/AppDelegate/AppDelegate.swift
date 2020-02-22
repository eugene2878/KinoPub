//
//  AppDelegate.swift
//  KinoPub
//
//  Created by Maksim Kolesnik on 13/02/2020.
//  Copyright © 2020 Maksim Kolesnik. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let token = AccessToken(accessToken: "6rp9ukuu8yk81ec7xfdrjk4mzumwzsuj", refreshToken: "6rp9ukuu8yk81ec7xfdrjk4mzumwzsuj", expressIn: 0)
        ServiceLocator.shared.keyChainStorage.setObject(token, for: .token)
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        //        var token = ServiceLocator.shared.keyChainStorage.object(for: .token) as AccessToken?
        //        token?.accessToken = "6rp9ukuu8yk81ec7xfdrjk4mzumwzsuj"
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

