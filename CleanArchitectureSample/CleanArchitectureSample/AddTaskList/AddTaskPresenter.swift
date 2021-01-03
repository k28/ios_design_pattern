//
//  AddTaskPresenter.swift
//  CleanArchitectureSample
//
//  Created by K.Hatano on 2021/01/03.
//

import Foundation

protocol AddTaskPresenterProtocol {

    func onViewDidLoad()
    func onAddTaskButton()
    func onTitleChanged(_ title: String)
    func onDeadlineChanged(_ deadline: Date)

}

protocol AddTaskPresenterOutput {
    
    func update(_ data: AddTaskViewData)
}

struct AddTaskViewData {
    var isEnableAddButton: Bool
    var title: String
    var deadLine: Date
}

final class AddTaskPresenter {
    
    private weak var useCase: AddTaskUseCaseProtocol?
    var output: AddTaskPresenterOutput!
    
    var task: Task = Task()
    
    init(_ useCase: AddTaskUseCaseProtocol) {
        self.useCase = useCase
        useCase.output = self
    }
    
    fileprivate func updateView() {
        
        let isEnableAddButton = (!task.title.isEmpty && task.deadline > Date())
        
        let addTaskViewData = AddTaskViewData(isEnableAddButton: isEnableAddButton,
                                              title: task.title,
                                              deadLine: task.deadline)
        output.update(addTaskViewData)
    }
             
}

extension AddTaskPresenter: AddTaskPresenterProtocol {
    func onViewDidLoad() {
        updateView()
    }
    
    func onAddTaskButton() {
        useCase?.addTask(task)
    }

    func onTitleChanged(_ title: String) {
        task.title = title
        updateView()
    }
    
    func onDeadlineChanged(_ deadline: Date) {
        task.deadline = deadline
        updateView()
    }
    
}

extension AddTaskPresenter: AddTaskUseCaseOutput {
    
    func taskDidAdd() {
    }
    
    func addTaskDidError(_ error: Error) {
    }
    
    
}
