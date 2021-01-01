//
//  ActionCreator.swift
//  FluxSample
//
//  Created by K.Hatano on 2020/12/31.
//

import Foundation

final class ActionCreator {
    private let dispatcher: Dispatcher

    init(dispatcher: Dispatcher = .shared) {
        self.dispatcher = dispatcher
    }
    
    func loadTaskList() {
        DispatchQueue.mainSyncSafe { [dispatcher] in
            dispatcher.dispatch(.commonAction(.showDialog("データ取得中...")))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [dispatcher] in
            dispatcher.dispatch(.addTask(Task.make("fiest",  Date(timeIntervalSinceNow: 300))))
            dispatcher.dispatch(.addTask(Task.make("second", Date(timeIntervalSinceNow: 600))))
            dispatcher.dispatch(.addTask(Task.make("therd",  Date(timeIntervalSinceNow: 900))))

            dispatcher.dispatch(.commonAction(.closeDialog))
        })
    }
    
    func addTask(_ task: Task) {
        dispatcher.dispatch(.addTask(task))
    }
    
    func taskListViewRoute(_ type: TaskListViewRouteType) {
        dispatcher.dispatch(.taskListViewRoute(type))
    }
    
    func addTaskViewAction(_ actionType: AddTaskViewStoreAction) {
        dispatcher.dispatch(.addTaskViewAction(actionType))
    }
}
