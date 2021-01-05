//
//  AppDelegate.swift
//  ApplicationCordinatorSample
//
//  Created by K.Hatano on 2021/01/05.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var appCordinator: ApplicationCordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {


        if #available(iOS 13.0, *) {
            // SenceDelegateで行う
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            AppDelegate.setupWindow(window)
        }

        return true
    }

    class func setupWindow(_ window: UIWindow?) {
        guard let window = window else { return }

        app.initialize(window: window)
        app.appCordinator.start()
     }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
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

let app = App()

