//
//  TaskListViewStore.swift
//  FluxSample
//
//  Created by K.Hatano on 2021/01/01.
//

import Foundation

/// TaskListViewの画面遷移パターン
enum TaskListViewRouteType {
    /// 新規タスク
    case newTask
    /// タスク詳細を表示
    case taskDetail(Task)
}

/// TaskList画面のデータストア
final class TaskListViewStore: Store {
    
    /// 画面遷移する時に使うベースのTask
    private(set) var routeType: TaskListViewRouteType?
    
    override func onDispatch(_ action: Action) {
        switch action {
        case .taskListViewRoute(let type):
            self.routeType = type
        default:
            return
        }
        
        emitChange()
    }
    
}
