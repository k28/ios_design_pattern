//
//  TaskListViewController.swift
//  FluxSample
//
//  Created by K.Hatano on 2020/12/29.
//

import UIKit

class TaskListViewController: UIViewController {
    
    let CellIdentifier = "CellIdentifier"
    
    @IBOutlet weak var tableView_: UITableView!
    
    var addButton = UIBarButtonItem()
    var taskListStore: TaskListStore!
    var taskListViewStore: TaskListViewStore!
    var actionCreator: ActionCreator!
    
    /// TaskListViewの画面遷移通知の購読
    private lazy var taskListViewStoreSubscription: Subscription = {
        return taskListViewStore.addListener { [weak self] in
            switch self?.taskListViewStore.routeType {
            case .newTask:
                // Task新規追加
                DispatchQueue.main.async {
                    self?.moveToAddTask(Task())
                }
                break
            case .taskDetail(let task):
                // Taskの詳細を表示
                DispatchQueue.main.async {
                    self?.moveToAddTask(task)
                }
                break
            default:
                return
            }
        }
    }()
    
    /// TaskListの変更通知を購読
    private lazy var reloadSubscription: Subscription = {
        return taskListStore.addListener { [weak self] in
            DispatchQueue.main.async {
                self?.tableView_.reloadData()
            }
        }
    }()
    
    deinit {
        taskListStore.removeListener(reloadSubscription)
        taskListViewStore.removeListener(taskListViewStoreSubscription)
    }
    
    func inject(taskListViewStore: TaskListViewStore, taskListStore: TaskListStore, actionCreator: ActionCreator) {
        self.taskListViewStore = taskListViewStore
        self.taskListStore = taskListStore
        self.actionCreator = actionCreator
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        tableView_.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        tableView_.dataSource = self
        tableView_.delegate = self
        
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        _ = taskListViewStoreSubscription
        _ = reloadSubscription

        actionCreator.loadTaskList()
    }
    
    // MARK: Action
    @objc func addTask(_ sender: UIBarButtonItem) {
        // AddTaskViewControllerを表示する
        actionCreator.taskListViewRoute(.newTask)
    }
    
    // 画面遷移
    private func moveToAddTask(_ task: Task) {
        let addTaskViewStore = AddTaskViewStore(dispatcher: .shared, task: task, actionCrator: actionCreator)
        let vc = UIStoryboard(name: "AddTask", bundle: nil).instantiateInitialViewController() as! AddTaskViewController
        vc.inject(addTaskViewStore: addTaskViewStore, taskListStore: taskListStore, actionCreator: actionCreator)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension TaskListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskListStore.taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier) else {
            return UITableViewCell()
        }
        
        let info = taskListStore.taskList[indexPath.row]
        cell.textLabel?.text = info.title
        return cell
    }
}

extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = taskListStore.taskList[indexPath.row]
        actionCreator.taskListViewRoute(.taskDetail(task))
    }
}
