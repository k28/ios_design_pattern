//
//  AddTaskPresenter.swift
//  MVPSample
//
//  Created by K.Hatano on 2020/12/22.
//

import Foundation

// AddTaskの入力
protocol AddTaskPresenterInput {
    /// Viewが表示された
    func onViewDidLoad()
    /// 追加ボタンが押された
    func onSelectAddTask()
    /// タスクタイトルが変更された(入力チェック)
    func taskTitleShouldChange(_ text: inout String)
    /// タスクタイトルが変更された
    func taskTitleDidChange(_ text: String)
    /// 期限が変更された
    func dedlineDidChange(_ deadline: Date)
}

// AddTaskの変更通知
protocol AddTaskPresenterOutput: AnyObject {
    
    /// 追加ボタンの有効, 無効を切り替える
    func updateAddButton(_ enable: Bool)
    
    /// Taskの表示を更新する
    func updateTask(_ task: Task)
    
    // ダイアログを出す, 消す, エラー表示する
    func showDialog(_ message: String)
    func closeDialog()
}

final class AddTaskPresenter : AddTaskPresenterInput {
    
    private weak var view: AddTaskPresenterOutput!
    var model: AddTaskModelInput
    
    init(view: AddTaskPresenterOutput, model: AddTaskModelInput) {
        self.view = view
        self.model = model
    }
    
    func onViewDidLoad() {
        view.updateAddButton(false)
        view.updateTask(model.task)
    }
    
    func onSelectAddTask() {
        // TODO: TaskListに追加する
        model.addTask(model.task)
    }
    
    func taskTitleShouldChange(_ text: inout String) {
    }

    func taskTitleDidChange(_ text: String) {
        model.task.title = text
        view.updateTask(model.task)
        view.updateAddButton(isAddButtonEnable())
    }
    
    func dedlineDidChange(_ deadline: Date) {
        model.task.deadline = deadline
        view.updateTask(model.task)
        view.updateAddButton(isAddButtonEnable())
    }
    
}

extension AddTaskPresenter {
    func isAddButtonEnable() -> Bool {
        if model.task.title.isEmpty     { return false }
        if model.task.deadline < Date() { return false }
        
        return true
    }
}
