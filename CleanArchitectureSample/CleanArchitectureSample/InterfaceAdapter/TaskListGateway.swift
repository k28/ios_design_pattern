//
//  TaskListGateway.swift
//  CleanArchitectureSample
//
//  Created by K.Hatano on 2021/01/02.
//

import Foundation

/// TaskList取得時のエラー
enum TaskListGatewayError: Error {
    case notExist
}

/// TaskListを取得するプロトコル
protocol TaskListGatewayProtocol {
    
    /// TaskListの取得を開始する
    /// - Parameter completion: 処理終了時にCallされる
    func fetch(completion: @escaping (Result<[Task], TaskListGatewayError>) -> Void)
}

/// TaskList
final class TaskListGateway: TaskListGatewayProtocol {
    
    func fetch(completion: @escaping (Result<[Task], TaskListGatewayError>) -> Void) {
        
        // 本当はFrameworsやDeiver経由で取得する
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            var taskList: [Task] = []
            taskList.append(Task.make("first", Date()))
            taskList.append(Task.make("second", Date()))
            taskList.append(Task.make("therd", Date()))
            completion(.success(taskList))
        }
    }
    
}
