//
//  App.swift
//  ApplicationCordinatorSample
//
//  Created by K.Hatano on 2021/01/05.
//

import UIKit

class App {
    
    private(set) var appCordinator: ApplicationCordinator!
    
    func initialize(window: UIWindow) {
        appCordinator = ApplicationCordinator(window: window)
    }
    
    
}
