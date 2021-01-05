//
//  TaskListViewController.swift
//  ApplicationCordinatorSample
//
//  Created by K.Hatano on 2021/01/05.
//

import UIKit

protocol TaskListViewControllerDelegate: AnyObject {
    /// 追加ボタンが押された
    func taskListViewControllerDidSelectAdd()
    
    /// Cellの項目が選択された
    func taskListViewControllerDidSelectItem(_ task: Task)
}

class TaskListViewController: UIViewController {

    @IBOutlet weak var tableView_: UITableView!
    weak var delegate: TaskListViewControllerDelegate?
    
    private let CellIdentifier = "CellIdentifier"
    var taskList: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskList.append(Task(title: "AAAA", deadline: Date(timeIntervalSinceNow: 300)))
        taskList.append(Task(title: "BBBB", deadline: Date(timeIntervalSinceNow: 600)))
        taskList.append(Task(title: "CCCC", deadline: Date(timeIntervalSinceNow: 900)))
        
        setup()
    }
    
    private func setup() {
        tableView_.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        tableView_.delegate = self
        tableView_.dataSource = self
        tableView_.reloadData()
    }
}

extension TaskListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = taskList[indexPath.row]
        delegate?.taskListViewControllerDidSelectItem(task)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension TaskListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView_.dequeueReusableCell(withIdentifier: CellIdentifier) else {
            return UITableViewCell()
        }
        
        let task = taskList[indexPath.row]
        cell.textLabel?.text = task.title
        return cell
    }
    
}
