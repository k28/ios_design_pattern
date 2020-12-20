//
//  TaskListPresenterTests.swift
//  MVPSampleTests
//
//  Created by kazuya on 2020/12/20.
//

import XCTest
@testable import MVPSample

class TaskListPresenterTests: XCTestCase {
    
    class TaskListModelMock: TaskListModelInput {
        
        var fetchResult: Result<[Task]> = .success([])
        
        func fetchTaskList(completion: @escaping (Result<[Task]>) -> ()) {
            onFetchTaskList()
            completion(fetchResult)
        }
        
        var onFetchTaskList: (() -> Void) = { }
    }
    
    class TaskListViewMock: TaskListPresenterOutput {
        func updateTasks(_ tasks: [Task]) {
            onUpdateTasks()
        }
        
        func transitionToTaskDetail(_ task: Task) {
            onTransitionToTaskDetail()
        }
        
        func transitionToAddNewTask() {
            onTransitionToAddNewTask()
        }
        
        func showDialog(_ message: String) {
            onShowDialog()
        }
        
        func closeDialog() {
            onCloseDialog()
        }
        
        var onUpdateTasks: (() -> Void) = { }
        var onTransitionToTaskDetail: (() -> Void) = { }
        var onTransitionToAddNewTask: (() -> Void) = { }
        var onShowDialog: (() -> Void) = { }
        var onCloseDialog: (() -> Void) = { }
    }
    
    let view = TaskListViewMock()
    let model = TaskListModelMock()
    static var callIndex = 0
    
    override func setUp() {
        TaskListPresenterTests.callIndex = 0
    }
    
    func makeTestPresenter() -> TaskListPresenter {
        let presenter = TaskListPresenter(view: self.view, model: self.model)
        return presenter
    }
    
    func test_OnSetupDidFinish() {
        let presenter = makeTestPresenter()
        
        var index = 0
        
        XCTContext.runActivity(named: "SetupDidFinish") { _ in
            XCTContext.runActivity(named: "成功パターン") { _ in
                // ダイアログを出す
                view.onShowDialog = {
                    XCTAssertEqual(0, index)
                    index += 1
                }
                // model.fetchTaskListをcall
                model.onFetchTaskList = {
                    XCTAssertEqual(1, index)
                    index += 1
                }
                // ダイアログを消す
                view.onCloseDialog = {
                    XCTAssertEqual(2, index)
                    index += 1
                }
                // view.updateTaskをcall
                view.onUpdateTasks = {
                    XCTAssertEqual(3, index)
                    index += 1
                }
                
                presenter.onSetupDidFinish()
            }
        }
    }
    
    func test_numberOfTask() {
        
        let testList:[(Result<[Task]>, Int)] = [
            (.success([Task(title: "A", deadline: Date()), Task(title: "B", deadline: Date())]), 2),
            (.success([]), 0),
            (.failure(ResultError.FetchError("test", -1)), 0)
        ]
        
        for test in testList {
            let presenter = makeTestPresenter()
            model.fetchResult = test.0
            presenter.onSetupDidFinish()
            XCTAssertEqual(test.1, presenter.numberOfTask)
        }
    }
    
    func test_taskForRow() {
        
        let taskA = Task(title: "A", deadline: Date())
        let taskB = Task(title: "B", deadline: Date())
        let testList:[(Result<[Task]>, Int, Task?)] = [
            (.success([taskA, taskB]), 0, taskA),
            (.success([taskA, taskB]), 1, taskB),
            (.success([taskA, taskB]), 2, nil),
            (.success([]), 0, nil),
            (.failure(ResultError.FetchError("test", -1)), 0, nil)
        ]
        
        for test in testList {
            let presenter = makeTestPresenter()
            model.fetchResult = test.0
            presenter.onSetupDidFinish()
            XCTAssertEqual(test.2, presenter.task(forRow: test.1))
        }
    }

}
