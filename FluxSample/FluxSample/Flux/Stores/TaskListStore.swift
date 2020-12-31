//
//  TaskListStore.swift
//  FluxSample
//
//  Created by K.Hatano on 2020/12/31.
//

import Foundation

final class TaskListStore: Store {
    
    static let shared = TaskListStore(dispatcher: .shared)
    
    private(set) var taskList: [Task] = []
    
    override func onDispatch(_ action: Action) {
        switch action {
        case .addTask(let task):
            taskList.append(task)
        case .removeTask(let task):
            taskList.removeAll { $0 == task }
        default:
            return
        }
        emitChange()
    }
    
}
