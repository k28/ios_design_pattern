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
    
    init(useCase: TaskListUseCaseProtocol) {
        self.useCase = useCase
        self.useCase.output = self
    }

    func startFetch() {
        useCase.startFetch()
    }

}

extension TaskListPresenter: TaskListUseCaseOutput {
    
    func taskListDidUpdate(_ taskList: [Task]) {
        let taskDataList = taskList.map { TaskData(title: $0.title, deadline: $0.deadline) }
        output?.update(taskDataList)
    }
    
    func taskListDidError(_ error: Error) {
        //TODO: TaskDataの取得エラー処理
    }
    
}
