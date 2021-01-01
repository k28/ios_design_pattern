//
//  AddTaskViewController.swift
//  FluxSample
//
//  Created by K.Hatano on 2020/12/31.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var titleTextField_: UITextField!
    @IBOutlet weak var deadlineDatePicker_: UIDatePicker!
    
    var addButton = UIBarButtonItem()
    
    var actionCreator: ActionCreator!
    var taskListStore: TaskListStore!
    var addTaskViewStore: AddTaskViewStore!
    
    lazy var addTaskViewStoreSubscription = {
        return addTaskViewStore.addListener { [weak self] in
            self?.updateView()
        }
    }()
    
    deinit {
        addTaskViewStore.removeListener(addTaskViewStoreSubscription)
    }

    func inject(addTaskViewStore: AddTaskViewStore, taskListStore: TaskListStore, actionCreator: ActionCreator) {
        self.addTaskViewStore = addTaskViewStore
        self.taskListStore = taskListStore
        self.actionCreator = actionCreator
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        updateView()
    }
    
    private func setup() {
        /// 追加ボタンをNavigationBarに追加
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddButton(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        titleTextField_.addTarget(self, action: #selector(onTitleDidChange(_:)), for: UIControl.Event.editingChanged)
        deadlineDatePicker_.addTarget(self, action: #selector(onDeadlineChange(_:)), for: UIControl.Event.valueChanged)
        
        // AddTaskViewの購読を開始
        _ = addTaskViewStoreSubscription
    }
    
    private func updateView() {
        titleTextField_.text = addTaskViewStore.title
        deadlineDatePicker_.date = addTaskViewStore.deadLine
        addButton.isEnabled = addTaskViewStore.isEnableAddButton
    }
    
}


extension AddTaskViewController {
    
    /// 追加ボタンが押された
    @objc func onAddButton(_ sender: UIBarButtonItem) {
        actionCreator.addTaskViewAction(.onAddButton)
    }
    
    /// タイトルが変更された
    @objc func onTitleDidChange(_ sender: UITextField) {
        actionCreator.addTaskViewAction(.titleChanged(sender.text ?? ""))
    }
    
    /// 期限が変更された
    @objc func onDeadlineChange(_ sender: UIDatePicker) {
        actionCreator.addTaskViewAction(.deadLineChanged(sender.date))
    }
    
}
