//
//  TaskListViewController.swift
//  MVPSample
//
//  Created by K.Hatano on 2020/12/19.
//

import UIKit

class TaskListViewController: UIViewController {

    @IBOutlet weak var tableView_: UITableView!
    
    var addButton = UIBarButtonItem()
    
    let CellIdentifier = "Cell"
    
    private var presenter: TaskListPresenter!
    func inject(_ presenter: TaskListPresenter) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    func setup() {
        tableView_.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        tableView_.dataSource = self
        tableView_.delegate = self
        
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddButton(_:)))
        self.navigationItem.rightBarButtonItems = [addButton]
        
        presenter.onSetupDidFinish()
    }
    
    @objc func onAddButton(_ sender: UIBarButtonItem) {
        presenter.onSelectAddNewTask()
    }
    
}

extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfTask
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier) else {
            return UITableViewCell()
        }
        
        if let info = presenter.task(forRow: indexPath.row) {
            cell.textLabel?.text = info.title
        }
        
        return cell
    }
}

extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
}

extension TaskListViewController: TaskListPresenterOutput {
    
    func updateTasks(_ tasks: [Task]) {
        tableView_.reloadData()
    }
    
    func showDialog(_ message: String) {
        Action.showDialog(view: self.navigationController?.view ?? UIView(), message)
    }
    
    func closeDialog() {
        Action.closeDialog(view: self.navigationController?.view ?? UIView())
    }
    
}

