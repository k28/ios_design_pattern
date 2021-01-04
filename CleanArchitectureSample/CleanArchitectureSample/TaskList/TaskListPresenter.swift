//
//  TaskListPresenter.swift
//  CleanArchitectureSample
//
//  Created by K.Hatano on 2021/01/02.
//

import Foundation

protocol TaskListPresenterProtocol: AnyObject {
    /// TaskListを取得する
    func startFetch()
    
    func onViewDidAppear()
}

protocol TaskListPresenterOutput {

    /// 表示用のデータが更新されたことを外側に通知
    func update(_ taskList: [TaskData])
    
}

struct TaskData {
    let title: String
    let deadline: Date
}

/// 画面の入力を受け取る
final class TaskListPresenter: TaskListPresenterProtocol {
    private weak var useCase: TaskListUseCaseProtocol!
    var output: TaskListPresenterOutput?
    
    private lazy var subscription: Subscription = {
        return useCase.addListener { [weak self] in
            self?.notifyUpdate()
        }
    }()
    
    init(useCase: TaskListUseCaseProtocol) {
        self.useCase = useCase
        self.useCase.output = self
        _ = subscription
    }
    
    deinit {
        useCase.removeListener(subscription)
    }

    func startFetch() {
        useCase.startFetch()
    }

    func onViewDidAppear() {
    }
    
    private func notifyUpdate() {
        let taskDataList = useCase.taskList.taskList.map { TaskData(title: $0.title, deadline: $0.deadline) }
        output?.update(taskDataList)
    }
}

extension TaskListPresenter: TaskListUseCaseOutput {
    
    func taskListDidUpdate(_ taskList: TaskList) {
        notifyUpdate()
    }
    
    func taskListDidError(_ error: Error) {
        //TODO: TaskDataの取得エラー処理
    }
    
}
