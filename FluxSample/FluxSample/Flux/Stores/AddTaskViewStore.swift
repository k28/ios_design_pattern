//
//  AddTaskViewStore.swift
//  FluxSample
//
//  Created by K.Hatano on 2021/01/01.
//

import Foundation

enum AddTaskViewStoreAction {
    case titleChanged(String)
    case deadLineChanged(Date)
    /// 追加ボタンが押された
    case onAddButton
}

/// Task追加画面のデータ
final class AddTaskViewStore: Store {
    
    var task: Task
    var actionCreator: ActionCreator
    
    /// タイトル
    var title: String {
        set { task.title = newValue }
        get { task.title }
        
    }
    /// 期限
    var deadLine: Date {
        set { task.deadline = newValue }
        get { task.deadline }
    }
    
    init(dispatcher: Dispatcher, task: Task, actionCrator: ActionCreator) {
        self.task = task
        self.actionCreator = actionCrator
        super.init(dispatcher: dispatcher)
    }
    
    /// 追加ボタンが有効か
    var isEnableAddButton: Bool {
        if title.isEmpty     { return false }
        if deadLine < Date() { return false }
        
        return true
    }
    
    var actionType: AddTaskViewStoreAction?
    
    override func onDispatch(_ action: Action) {
        switch action {
        case .addTaskViewAction(let type):
            onAction(type)
            break
        default:
            return
        }
        
        emitChange()
    }
    
    func onAction(_ type: AddTaskViewStoreAction) {
        self.actionType = type
        switch type {
        case .titleChanged(let val):
            self.title = val
            break
        case .deadLineChanged(let date):
            self.deadLine = date
            break
        case .onAddButton:
            // TaskをTaskListに追加する
            actionCreator.addTask(self.task)
            break
        }
    }
    
}
