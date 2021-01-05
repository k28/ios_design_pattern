//
//  TaskDetailViewController.swift
//  ApplicationCordinatorSample
//
//  Created by K.Hatano on 2021/01/05.
//

import UIKit

protocol TaskDetailViewControllerDelegate {
}

class TaskDetailViewController: UIViewController {
    
    @IBOutlet weak var title_: UITextField!
    @IBOutlet weak var deadline_: UIDatePicker!
    
    var task: Task!
    func inject(task: Task) {
        self.task = task
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title_.text = task.title
        deadline_.date = task.deadline
    }
    

}
