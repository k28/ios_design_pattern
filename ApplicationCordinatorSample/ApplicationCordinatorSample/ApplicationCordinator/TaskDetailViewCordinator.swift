//
//  TaskDetailViewCordinator.swift
//  ApplicationCordinatorSample
//
//  Created by K.Hatano on 2021/01/05.
//

import UIKit

final class TaskDetailViewCordinator: Cordinator {
    
    let navigationController: UINavigationController
    var viewController: TaskDetailViewController?
    var task: Task
    
    init(navigationController: UINavigationController, task: Task) {
        self.navigationController = navigationController
        self.task = task
    }
    
    func start() {
        let vc = UIStoryboard(name: "TaskDetail", bundle: nil).instantiateInitialViewController() as! TaskDetailViewController
        vc.inject(task: task)
        navigationController.pushViewController(vc, animated: true)
        
        self.viewController = vc
    }
    
}
