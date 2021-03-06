//
//  TaskListViewCordinator.swift
//  ApplicationCordinatorSample
//
//  Created by K.Hatano on 2021/01/05.
//

import UIKit

final class TaskListViewCordinator: Cordinator {

    private let navigationController: UINavigationController
    private var viewController: TaskListViewController?
    private var taskDetailCordinator: TaskDetailViewCordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = UIStoryboard(name: "TaskList", bundle: nil).instantiateInitialViewController() as! TaskListViewController
        vc.delegate = self
        navigationController.pushViewController(vc, animated: true)
        
        self.viewController = vc
    }
    
}

extension TaskListViewCordinator: TaskListViewControllerDelegate {
    
    func taskListViewControllerDidSelectAdd() {
        //TODO: 追加画面に遷移
    }
    
    func taskListViewControllerDidSelectItem(_ task: Task) {
        let taskDetailCordinator = TaskDetailViewCordinator(navigationController: navigationController, task: task)
        taskDetailCordinator.start()
        self.taskDetailCordinator = taskDetailCordinator
    }
    
    
}
