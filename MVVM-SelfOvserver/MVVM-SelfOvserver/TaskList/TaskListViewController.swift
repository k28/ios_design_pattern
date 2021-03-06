//
//  TaskListViewController.swift
//  MVVM-SelfOvserver
//
//  Created by K.Hatano on 2020/12/27.
//

import UIKit

class TaskListViewController: UIViewController {
    
    @IBOutlet weak var tableView_: UITableView!
    
    // 追加ボタン
    var addButton = UIBarButtonItem()
    
    let CellIdentifier = "Cell"
    
    var taskListViewModel: TaskListViewModel!
    func inject(_ vm: TaskListViewModel) {
        taskListViewModel = vm
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onSelectAddButton(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        setup()
    }
    
    @objc func onSelectAddButton(_ sender: UIBarButtonItem) {
        taskListViewModel.onSelectAdd()
    }
    
    fileprivate func setup() {
        tableView_.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        tableView_.delegate = self
        tableView_.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        app.taskList.addObserver(self)
        taskListViewModel.addObserver(self)

        if app.taskList.numberOfTask() == 0 {
            // リストを更新する
            taskListViewModel.startSyncList()
        } else {
            tableView_.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        app.taskList.removeObserver(self)
        taskListViewModel.removeObserver(self)
    }
    
}

extension TaskListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return app.taskList.numberOfTask()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier) else {
            assertionFailure("Cellが取得できませんでした")
            return UITableViewCell()
        }
        
        if let info = app.taskList.task(at: indexPath.row) {
            cell.textLabel?.text = info.title
        }
        
        return cell
    }
    
}

extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let task = app.taskList.task(at: indexPath.row) {
            taskListViewModel.onSelectList(task)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TaskListViewController: TaskListObserver {
    
    func onStartTaskListUpdate() {
        // ダイアログを出す
        Action.showDialog(view: self.navigationController?.view ?? UIView(), "リスト取得中")
    }
    
    func onTaskListUpdateDidFinish() {
        // ダイアログを消す
        Action.closeDialog(view: self.navigationController?.view ?? UIView())
    }
    
    func onTaskListUpdate() {
        tableView_.reloadData()
    }
    
}

extension TaskListViewController: TaskListViewOutput {

    func updateList() {
        tableView_.reloadData()
    }
    
    func showAddTaskList() {
        //TODO: 画面遷移
        NSLog("TaskList追加画面に遷移")
    }
    
}
