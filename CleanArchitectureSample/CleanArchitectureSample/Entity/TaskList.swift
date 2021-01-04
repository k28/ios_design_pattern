//
//  TaskList.swift
//  CleanArchitectureSample
//
//  Created by K.Hatano on 2021/01/02.
//

import Foundation

/// TaskListを管理する
class TaskList {
    
    var taskList: [Task]
    
    init(_ list: [Task]) {
        self.taskList = list
    }
    
    func addTask(_ task: Task) {
        taskList.append(task)
    }
    
}
