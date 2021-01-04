//
//  TaskListUseCase.swift
//  CleanArchitectureSample
//
//  Created by K.Hatano on 2021/01/02.
//

import Foundation

typealias Subscription = NSObjectProtocol

protocol TaskListUseCaseProtocol: AnyObject {
    
    /// outputは後からセットする
    var output: TaskListUseCaseOutput! { set get }
    var taskList: TaskList! { get }
    
    /// タスクリストの取得を開始する
    func startFetch()
    
    /// タスクを追加する
    func addTask(task: Task)
    
    /// リスナを登録する
    func addListener(callback: @escaping () -> Void) -> Subscription
    /// リスナの登録を解除する
    func removeListener(_ subscription: Subscription)
    
}

protocol TaskListUseCaseOutput {
    
    /// TaskListが更新された時にCallされる
    func taskListDidUpdate(_ taskList: TaskList)
    
    /// TaskListの更新でエラーが起きた時にCallされる
    func taskListDidError(_ error: Error)
}

/// TaskListのUseCase
final class TaskListUseCase: TaskListUseCaseProtocol {
    private enum NotificationName {
        static let storeChanged = Notification.Name("store-changed")
    }

    var output: TaskListUseCaseOutput!
    var gateway: TaskListGateway!
    var taskList: TaskList!
    private let notificationCenter = NotificationCenter()
        
    /// TaskListの取得を開始する
    func startFetch() {
        
        gateway.fetch { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let taskList):
                // TaskListに追加する
                taskList.forEach { self.taskList.addTask($0) }
                self.output.taskListDidUpdate(self.taskList)
                break
            case .failure(let error):
                self.output.taskListDidError(error)
                break
            }
        }
        
    }

    func addTask(task: Task) {
        taskList.addTask(task)
        emmitChange()
    }

    func addListener(callback: @escaping () -> Void) -> Subscription {
        
        let using: (Notification) -> () = { notification in
            if notification.name == NotificationName.storeChanged {
                callback()
            }
        }
        
        return notificationCenter.addObserver(forName: NotificationName.storeChanged,
                                              object: nil,
                                              queue: nil,
                                              using: using)
    }
    
    func removeListener(_ subscription: Subscription) {
        notificationCenter.removeObserver(subscription)
    }
    
    private func emmitChange() {
        notificationCenter.post(name: NotificationName.storeChanged, object: nil)
    }

}
