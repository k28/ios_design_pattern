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
    
    private func buildLayer() {
        
        // Gateway
        let taskListGateway = TaskListGateway()
        
        // Use Case
        useCase = TaskListUseCase(gateway: taskListGateway)
        
        // Use Caseとバインド(今回はTaskListの初期化時に設定しているので不要)
        
        // Framework & Drivers
        // 今回のサンプルではGatewayが時間さで取得しているので不要
        
        // Presenterの作成, バインドはViewControllerを作成する時に行う
        
    }
    
}
