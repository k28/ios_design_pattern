//
//  AppDelegate.swift
//  FluxSample
//
//  Created by K.Hatano on 2020/12/29.
//

import UIKit
import MBProgressHUD

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var commonActionStore: CommonActionStore?
    private lazy var commonActionStoreSubscription: Subscription? = {
        return commonActionStore?.addListener { [weak self] in
            switch self?.commonActionStore?.taskType {
            case .showDialog(let title):
                if let view = app.window.rootViewController?.view {
                    let hud = MBProgressHUD.showAdded(to: view, animated: true)
                    hud.label.text = title
                }
                break
            case .closeDialog:
                MBProgressHUD.forView(app.window.rootViewController?.view ?? UIView())?.hide(animated: true)
                break
            case .none:
                break
            }
        }
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        commonActionStore = CommonActionStore(dispatcher: .shared)
        _ = commonActionStoreSubscription

        if #available(iOS 13.0, *) {
            // SenceDelegateで行う
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            app.window = window
            AppDelegate.setupWindow(window)
        }

        return true
    }
    
    class func setupWindow(_ window: UIWindow?) {
        guard let window = window else { return }
        
        let taskListViewController = UIStoryboard(name: "TaskList", bundle: nil).instantiateInitialViewController() as! TaskListViewController
        taskListViewController.inject(taskListViewStore: .init(dispatcher: .shared), taskListStore: .shared, actionCreator: .init())
        let navigationController = UINavigationController(rootViewController: taskListViewController)
                
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
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

