//
//  TaskListModel.swift
//  MVPSample
//
//  Created by K.Hatano on 2020/12/19.
//

import Foundation

protocol TaskListModelInput {
    func fetchTaskList(
        completion: @escaping(Result<[Task]>) -> ()
    )
}

class TaskListModel: TaskListModelInput {
    
    init() {
    }

    func fetchTaskList(completion: @escaping (Result<[Task]>) -> ()) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0, execute: {
            var taskList:[Task] = []
            taskList.append(Task(title: "By Apple", deadline: Date(timeIntervalSinceNow: 600)))
            taskList.append(Task(title: "By Orange", deadline: Date(timeIntervalSinceNow: 1000)))
            taskList.append(Task(title: "Read Book", deadline: Date(timeIntervalSinceNow: 1000)))
            completion(.success(taskList))
        })
        
    }
    
    
}
