//
//  App.swift
//  CleanArchitectureSample
//
//  Created by K.Hatano on 2021/01/02.
//

import UIKit

class App {
    
    static let shared = App()
    private init() {}
    
    private(set) var taskList: TaskList!
    private(set) var useCase: TaskListUseCase!
    
    func configure(with window: UIWindow) {
        buildLayer()
        
        let taskListViewController = UIStoryboard(name: "TaskList", bundle: nil).instantiateInitialViewController() as! TaskListViewController
        // PresenterをViewControllerに設定する
        let presenter = TaskListPresenter(useCase: self.useCase)
        presenter.output = taskListViewController
        taskListViewController.injdect(presenter)

        let navigationController = UINavigationController(rootViewController: taskListViewController)
        
        window.rootViewController = navigationController
    }
    
    func configure(with vc: AddTaskViewController) {
        let presenter = AddTaskPresenter(useCase)
        vc.presenter = presenter
        presenter.output = vc
    }
    
    private func buildLayer() {
        
        // Entities
        taskList = TaskList([])
        
        // Gateway
        let taskListGateway = TaskListGateway()
        
        // Use Case
        useCase = TaskListUseCase()
        
        // Use Caseとバインド
        useCase.gateway = taskListGateway
        useCase.taskList = taskList
        
        // Framework & Drivers
        // 今回のサンプルではGatewayが時間さで取得しているので不要
        
        // Presenterの作成, バインドはViewControllerを作成する時に行う
        
    }
    
}
