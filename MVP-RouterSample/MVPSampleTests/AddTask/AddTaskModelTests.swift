//
//  AddTaskModelTests.swift
//  MVPSampleTests
//
//  Created by K.Hatano on 2020/12/25.
//

import XCTest
@testable import MVPSample

class AddTaskModelTests: XCTestCase {
    
    func makeTestModel() -> AddTaskModelInput {
        let task = Task()
        return AddTaskModel(task: task)
    }
    
    func test_AddTask() {
        let taskModel = makeTestModel()
        
        var newTask = Task()
        newTask.title = "test"
        newTask.deadline = Date()
        taskModel.addTask(newTask)
        
        // TODO 追加されたかテストする
        // XCTAssertTrue(<#T##expression: Bool##Bool#>, <#T##message: String##String#>)
    }
    
}
