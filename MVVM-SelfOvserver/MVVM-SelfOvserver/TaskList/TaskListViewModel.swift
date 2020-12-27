//
//  TaskListViewModel.swift
//  MVVM-SelfOvserver
//
//  Created by K.Hatano on 2020/12/27.
//

import Foundation

protocol TaskListViewInput: AnyObject {
    
    func addObserver(_ obj: TaskListViewOutput)
    func removeObserver(_ obj: TaskListViewOutput)
    
    /// Taskが選択された
    func onSelectList(_ task: Task)
    /// TaskListの更新を開始する
    func startSyncList()
    /// Taskの追加が選択された
    func onSelectAdd()
    
}

/// オブザーバに対する通知
protocol TaskListViewOutput: AnyObject {
    
    /// TaskListを更新する
    func updateList()
    
    /// TaskList追加画面を表示する
    func showAddTaskList()
    
}

final class TaskListViewModel: TaskListViewInput {
    var observers: [TaskListViewOutput] = []
        
    
    func addObserver(_ obj: TaskListViewOutput) {
        observers.append(obj)
    }
    
    func removeObserver(_ obj: TaskListViewOutput) {
        observers.removeAll { $0 === obj }
    }
        
    /// Taskが選択された
    func onSelectList(_ task: Task) {
    }
    
    func startSyncList() {
        app.taskList.fetchTaskList(completion: { [weak self] result in
            switch result {
            case .success( _):
                //TODO: 成功時の処理
                break
                
            case .failure(_):
                //TODO: エラー時の処理
                break
            }
        })
    }
    
    func onSelectAdd() {
        observers.forEach { $0.showAddTaskList() }
    }

}

