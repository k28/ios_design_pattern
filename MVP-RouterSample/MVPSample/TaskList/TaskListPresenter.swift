//
//  TaskListPresenter.swift
//  MVPSample
//
//  Created by K.Hatano on 2020/12/19.
//

import Foundation

/// TaskListの入力
protocol TaskListPresenterInput {
    var numberOfTask: Int { get }
    func task(forRow row: Int) -> Task?
    func didSelectRow(at indexPath: IndexPath)
    func onSelectAddNewTask()
    func onSetupDidFinish()
}

/// TaskListの変更通知
protocol TaskListPresenterOutput: Transitioner {    /* Presenterの出力用のプロトコルをTransitionerに準拠させる */
    func updateTasks(_ tasks: [Task])
    
    // ダイアログを出す, 消す, エラー表示する
    func showDialog(_ message: String)
    func closeDialog()
}

//protocol TaskListViewProtocol: Transitioner {}

final class TaskListPresenter: TaskListPresenterInput {
    
    private(set) var taskList: [Task] = []
    
    private weak var view: TaskListPresenterOutput!
    private var model: TaskListModelInput
    private var router: TaskListRouterProtocol

    init(view: TaskListPresenterOutput, model: TaskListModelInput, router: TaskListRouterProtocol) {
        self.view = view
        self.model = model
        self.router = router
    }
    
    var numberOfTask: Int {
        return taskList.count
    }
    
    func task(forRow row: Int) -> Task? {
        guard taskList.count > row else { return nil }
        return taskList[row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard let task = task(forRow: indexPath.row) else { return }
        
        router.transitionToTaskDetail(task)
    }
    
    func onSelectAddNewTask() {
        router.transitionToAddNewTask()
    }
    
    func onSetupDidFinish() {
        // 表示するデータを取得してViewを更新します
        
        // ダイアログを出す
        view.showDialog("データ取得中...")
        
        model.fetchTaskList(completion: { [weak self] result in
            
            // ダイアログを消す
            self?.view.closeDialog()
            
            switch result {
            case .success(let taskList):
                self?.taskList = taskList
                DispatchQueue.main.async {
                    self?.view.updateTasks(taskList)
                }
            case .failure(_):
                // TODO: エラー時の動作
                break
            }
        })
    }
}
