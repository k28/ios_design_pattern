//
//  AddTaskModel.swift
//  MVPSample
//
//  Created by K.Hatano on 2020/12/24.
//

import Foundation

protocol AddTaskModelInput {

    /// Taskを永続化する
    func addTask(_ task: Task)
    
    /// 設定するタスク
    var task: Task { set get }
    
}

struct AddTaskModel: AddTaskModelInput {
    
    var task: Task
    
    func addTask(_ task: Task) {
        // TODO: TaskListに永続化します
    }

}
