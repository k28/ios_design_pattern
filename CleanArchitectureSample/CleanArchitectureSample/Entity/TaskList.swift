//
//  TaskList.swift
//  CleanArchitectureSample
//
//  Created by K.Hatano on 2021/01/02.
//

import Foundation

/// TaskListを管理する
struct TaskList {
    
    var taskList: [Task]
    
    init(_ list: [Task]) {
        self.taskList = list
    }
    
    mutating func addTask(_ task: Task) {
        taskList.append(task)
    }
    
}
