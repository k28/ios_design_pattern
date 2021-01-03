//
//  AddTaskViewController.swift
//  CleanArchitectureSample
//
//  Created by K.Hatano on 2021/01/03.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var title_: UITextField!
    @IBOutlet weak var deadline_: UIDatePicker!
    var addButton = UIBarButtonItem()
    
    var presenter: AddTaskPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        presenter.onViewDidLoad()
    }
    
    private func setup() {
        
        title_.addTarget(self, action: #selector(onTitleDidChange(_:)), for: UIControl.Event.editingChanged)
        deadline_.addTarget(self, action: #selector(onDeadlineChange(_:)), for: UIControl.Event.valueChanged)
        
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddButton(_:)))
        self.navigationItem.rightBarButtonItem = addButton
    }

}

extension AddTaskViewController {
    
    @objc func onAddButton(_ sender: UIBarButtonItem) {
        presenter.onAddTaskButton()
    }
    
    @objc func onTitleDidChange(_ sender: UITextField) {
        presenter.onTitleChanged(title_.text ?? "")
    }
    
    @objc func onDeadlineChange(_ sender: UIDatePicker) {
        presenter.onDeadlineChanged(deadline_.date)
    }
    
}

extension AddTaskViewController: AddTaskPresenterOutput {
        
    func update(_ data: AddTaskViewData) {
        title_.text = data.title
        deadline_.date = data.deadLine
        addButton.isEnabled = data.isEnableAddButton
    }
}
