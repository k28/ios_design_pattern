//
//  TaskListViewController.swift
//  CleanArchitectureSample
//
//  Created by K.Hatano on 2021/01/02.
//

import UIKit

class TaskListViewController: UIViewController {
    
    @IBOutlet weak var tableView_: UITableView!
    var addButton = UIBarButtonItem()
    
    let CellIdentifier = "CellIdentifier"
    var taskList: [TaskData] = []
    
    private weak var presenter: TaskListPresenterProtocol!
    func injdect(_ presenter: TaskListPresenterProtocol) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        // TaskListの取得を開始
        presenter.startFetch()
    }
    
    private func setup() {
        tableView_.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        tableView_.dataSource = self
        
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onSelectAddButton(_:)))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
}

extension TaskListViewController {
    
    @objc func onSelectAddButton(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard(name: "AddTask", bundle: nil).instantiateInitialViewController() as! AddTaskViewController
        App.shared.configure(with: vc)  // 依存関係を構築
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension TaskListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier) else {
            return UITableViewCell()
        }
        
        let task = taskList[indexPath.row]
        cell.textLabel?.text = task.title
        
        return cell
    }
    
    
}

extension TaskListViewController: TaskListPresenterOutput {
    func update(_ taskList: [TaskData]) {
        self.taskList = taskList
        tableView_.reloadData()
    }
}
