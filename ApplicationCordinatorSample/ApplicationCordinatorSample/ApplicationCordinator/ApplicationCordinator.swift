//
//  ApplicationCordinator.swift
//  ApplicationCordinatorSample
//
//  Created by K.Hatano on 2021/01/05.
//

import UIKit

final class ApplicationCordinator: Cordinator {
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let taskListViewCordinator: TaskListViewCordinator
    
    init(window: UIWindow) {
        self.window = window
        
        navigationController = UINavigationController()
        taskListViewCordinator = TaskListViewCordinator(navigationController: navigationController)
    }
    
    func start() {
        window.rootViewController = navigationController
        taskListViewCordinator.start()
        window.makeKeyAndVisible()
    }
    
}
