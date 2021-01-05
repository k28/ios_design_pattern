//
//  TaskListRouter.swift
//  MVP-RouterSample
//
//  Created by K.Hatano on 2021/01/06.
//

import UIKit

protocol TaskListRouterProtocol: AnyObject {
    func transitionToTaskDetail(_ task: Task)
    func transitionToAddNewTask()
}

final class TaskListRouter: TaskListRouterProtocol {
    
    private(set) weak var view: TaskListPresenterOutput!
        
    init(_ view: TaskListPresenterOutput) {
        self.view = view
    }
    
    func transitionToTaskDetail(_ task: Task) {
        guard let addTaskVC = UIStoryboard(name: "AddTask", bundle: nil).instantiateInitialViewController() as? AddTaskViewController else {
            NSLog("Faild to initialize AddTaskViewController")
            return
        }

        // PresenterのセットアップとViewControllerにPresenterを設定
        let model = AddTaskModel(task: task)
        let presenter = AddTaskPresenter(view: addTaskVC, model: model)
        addTaskVC.inject(presenter)
        
        view.pushViewController(addTaskVC, animated: true)
    }
    
    func transitionToAddNewTask() {
        guard let addTaskVC = UIStoryboard(name: "AddTask", bundle: nil).instantiateInitialViewController() as? AddTaskViewController else {
            NSLog("Faild to initialize AddTaskViewController")
            return
        }

        // PresenterのセットアップとViewControllerにPresenterを設定
        let model = AddTaskModel(task: Task())
        let presenter = AddTaskPresenter(view: addTaskVC, model: model)
        addTaskVC.inject(presenter)
        
        view.pushViewController(addTaskVC, animated: true)
    }
}
