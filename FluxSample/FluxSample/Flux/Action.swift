//
//  Action.swift
//  FluxSample
//
//  Created by K.Hatano on 2020/12/31.
//

import Foundation

enum Action {
    
    case addTask(Task)
    case removeTask(Task)
    
    /// タスクの詳細を表示する(追加/編集時)
    case taskListViewRoute(TaskListViewRouteType)
    case addTaskViewAction(AddTaskViewStoreAction)
    
    /// インジケータを出す
    case showIndicator(String?)
    case closeIndicator
}
