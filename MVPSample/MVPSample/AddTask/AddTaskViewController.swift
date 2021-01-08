//
//  AddTaskViewController.swift
//  MVPSample
//
//  Created by K.Hatano on 2020/12/22.
//

import UIKit
import ESUControl

class AddTaskViewController: UIViewController {

    @IBOutlet weak var titleTextField_: ESUTextField!
    @IBOutlet weak var deadLineDatePicker_: UIDatePicker!
    
    var addButton: UIBarButtonItem = UIBarButtonItem()
    
    private var presender: AddTaskPresenterInput!
    func inject(_ presender: AddTaskPresenterInput) {
        self.presender = presender
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onSelectAddTask))
        self.navigationItem.rightBarButtonItem = addButton
        
        // コントロールの値変更のアクションを設定する
        titleTextField_.onEditingChanged = { [weak self] text in
            self?.presender.taskTitleDidChange(text)
        }
        deadLineDatePicker_.addTarget(self, action: #selector(deadlineDidChange(_:)), for: UIControl.Event.valueChanged)
        
        presender.onViewDidLoad()
    }
    
    @objc func onSelectAddTask() {
        presender.onSelectAddTask()
    }
    
    @objc func titleFiedlDidChange(_ textField: UITextField) {
        let text = textField.text ?? ""
        presender.taskTitleDidChange(text)
    }
    
    @objc func deadlineDidChange(_ picker: UIDatePicker) {
        presender.dedlineDidChange(picker.date)
    }
    
}

extension AddTaskViewController: AddTaskPresenterOutput {
    func updateAddButton(_ enable: Bool) {
        addButton.isEnabled = enable
    }
    
    func updateTask(_ task: Task) {
        titleTextField_.text = task.title
        deadLineDatePicker_.date = task.deadline
    }
    
    func showDialog(_ message: String) {
    }
    
    func closeDialog() {
    }
}

