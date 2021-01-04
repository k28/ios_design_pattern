//
//  AddTaskPresenter.swift
//  CleanArchitectureSample
//
//  Created by K.Hatano on 2021/01/03.
//

import Foundation

protocol AddTaskPresenterProtocol: AnyObject {

    func onViewDidAppear()
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
    
    private weak var useCase: TaskListUseCaseProtocol!
    var output: AddTaskPresenterOutput!
    var task: Task = Task()
    
    private lazy var subscription: Subscription = {
        return useCase.addListener {
            // TaskListが更新された時の動作(あれば)
        }
    }()
    
    init(_ useCase: TaskListUseCaseProtocol) {
        self.useCase = useCase
        _ = subscription
    }
    
    deinit {
        useCase.removeListener(subscription)
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
    
    func onViewDidAppear() {
        updateView()
    }
    
    func onAddTaskButton() {
        useCase.addTask(task: task)
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
