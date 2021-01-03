//
//  TaskListUseCase.swift
//  CleanArchitectureSample
//
//  Created by K.Hatano on 2021/01/02.
//

import Foundation

protocol TaskListUseCaseProtocol: AnyObject {
    
    /// outputは後からセットする
    var output: TaskListUseCaseOutput! { set get }
    
    /// タスクリストの取得を開始する
    func startFetch()
    
}

protocol TaskListUseCaseOutput {
    
    /// TaskListが更新された時にCallされる
    func taskListDidUpdate(_ taskList: [Task])
    
    /// TaskListの更新でエラーが起きた時にCallされる
    func taskListDidError(_ error: Error)
}

/// TaskListのUseCase
final class TaskListUseCase: TaskListUseCaseProtocol {

    var output: TaskListUseCaseOutput!
    var gateway: TaskListGateway!
        
    /// TaskListの取得を開始する
    func startFetch() {
        
        gateway.fetch { [weak self] result in
            switch result {
            case .success(let taskList):
                self?.output.taskListDidUpdate(taskList)
                break
            case .failure(let error):
                self?.output.taskListDidError(error)
                break
            }
        }
        
    }

}
