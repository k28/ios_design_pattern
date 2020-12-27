//
//  TaskListViewModel.swift
//  MVVM-SelfOvserver
//
//  Created by K.Hatano on 2020/12/27.
//

import Foundation

protocol TaskListViewInput {
    
    func onSelectList(_ task: Task)
    func startSyncList()
    
}

protocol TaskListViewOutput: AnyObject {
    
    /// TaskListを更新する
    func updateList()
    
}

final class TaskListViewModel: TaskListViewInput {
        
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

}

