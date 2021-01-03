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
    
    private(set) var useCase: TaskListUseCase!
    private(set) var addTaskUseCase: AddTaskUseCase!
    
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
        let presenter = AddTaskPresenter(addTaskUseCase)
        vc.presenter = presenter
        presenter.output = vc
    }
    
    private func buildLayer() {
        
        // Gateway
        let taskListGateway = TaskListGateway()
        
        // Use Case
        useCase = TaskListUseCase()
        addTaskUseCase = AddTaskUseCase()
        
        // Use Caseとバインド
        useCase.gateway = taskListGateway
        addTaskUseCase.gateway = taskListGateway
        
        // Framework & Drivers
        // 今回のサンプルではGatewayが時間さで取得しているので不要
        
        // Presenterの作成, バインドはViewControllerを作成する時に行う
        
    }
    
}
