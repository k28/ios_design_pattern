//
//  Task.swift
//  MVPSample
//
//  Created by K.Hatano on 2020/12/19.
//

import Foundation

/// タスク1つを表す
struct Task : Equatable {
    var title: String = ""
    var deadline: Date = Date()
    
    static func make(_ title: String, _ deadLine: Date) -> Task {
        var task = Task()
        task.title = title
        task.deadline = deadLine
        return task
    }
    
}
