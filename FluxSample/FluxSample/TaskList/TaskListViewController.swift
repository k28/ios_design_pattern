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
    
    var taskListStore: TaskListStore!
    var actionCreator: ActionCreator!
    private lazy var reloadSubscription: Subscription = {
        return taskListStore.addListener { [weak self] in
            DispatchQueue.main.async {
                self?.tableView_.reloadData()
            }
        }
    }()
    
    func inject(taskListStore: TaskListStore, actionCreator: ActionCreator) {
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
        
        _ = reloadSubscription
        actionCreator.loadTaskList()
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
    
}
