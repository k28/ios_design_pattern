//
//  AddTaskUseCase.swift
//  CleanArchitectureSample
//
//  Created by K.Hatano on 2021/01/03.
//

import Foundation

protocol AddTaskUseCaseProtocol: AnyObject {
    
    func addTask(_ newTask: Task)
    
    var output: AddTaskUseCaseOutput! { get set }
    
}

protocol  AddTaskUseCaseOutput {
    
    /// Taskが追加されたらCallされる
    func taskDidAdd()
    
    /// Taskの追加でエラーが起きた時にCallされる
    func addTaskDidError(_ error: Error)
    
}

final class AddTaskUseCase: AddTaskUseCaseProtocol {
    
    var output: AddTaskUseCaseOutput!
    var gateway: TaskListGateway!
    
    func addTask(_ newTask: Task) {
        gateway.addTask(newTask: newTask) { [weak self] result in
            switch result {
            case .success(_):
                self?.output.taskDidAdd()
                break
            case .failure(let error):
                self?.output.addTaskDidError(error)
                break
            }
        }
    }
    
}

