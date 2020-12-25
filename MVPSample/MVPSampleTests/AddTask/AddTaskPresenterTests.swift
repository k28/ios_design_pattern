//
//  AddTaskPresenterTests.swift
//  MVPSampleTests
//
//  Created by K.Hatano on 2020/12/25.
//

import XCTest
@testable import MVPSample

class AddTaskPresenterTests: XCTestCase {
    
    class AddTaskModelInputMock: AddTaskModelInput {
        
        init() {
            self.task = Task()
        }
        
        func addTask(_ task: Task) {
        }
        
        var task: Task
    }
    
    class AddTaskPresenterOutputMock : AddTaskPresenterOutput {
        
        var onUpdateAddButton:((_ enable: Bool) -> Void) = { _ in }
        var onUpdateTask: ((_ task: Task) -> Void) = { _ in }
        
        func updateAddButton(_ enable: Bool) {
            onUpdateAddButton(enable)
        }
        
        func updateTask(_ task: Task) {
            onUpdateTask(task)
        }
        
        func showDialog(_ message: String) {
        }
        
        func closeDialog() {
        }
    }
    
    var viewMock = AddTaskPresenterOutputMock()
    var modelMock = AddTaskModelInputMock()
    
    override func setUp() {
        // Mockの初期化
        viewMock = AddTaskPresenterOutputMock()
        modelMock = AddTaskModelInputMock()
    }
    
    func makeTestPresenter() -> AddTaskPresenter {
        return AddTaskPresenter(view: viewMock, model: modelMock)
    }
    
    func test_onViewDidLoad() {
        
        var index = 0
        // updateAddButtonをfalseでcallする
        viewMock.onUpdateAddButton = { enable in
            XCTAssertEqual(false, enable)
            index += 1
        }
        // updateTaskをCallする
        viewMock.onUpdateTask = { task in
            XCTAssertEqual(self.modelMock.task, task)
            index += 1
        }
        
        let presenter = makeTestPresenter()
        presenter.onViewDidLoad()

        // メソッドが2回Callされるはず
        XCTAssertEqual(2, index)
    }
    
    func test_SelectAddTask() {
        // modelのaddTaskをCallするはず
        // TODO: テスト
    }
    


}
