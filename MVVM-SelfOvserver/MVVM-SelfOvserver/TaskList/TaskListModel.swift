//
//  TaskListModel.swift
//  MVVM-SelfOvserver
//
//  Created by K.Hatano on 2020/12/27.
//

import Foundation

/// Viewにオブザーバ同期で伝えるアクション
protocol TaskListObserver: AnyObject {
    /// TaskListが更新された時に通知されます
    func onTaskListUpdate()
    
    /// TaskListの更新を開始するときに通知されます
    func onStartTaskListUpdate()
    
    /// TaskListの更新処理が終了した時に通知されます
    func onTaskListUpdateDidFinish()
}

/// Modelの操作メソッド
protocol TaskListModelInput {
    
    func fetchTaskList(
        completion: @escaping(Result<[Task]>) -> ()
    )
    
}

protocol TaskListModelOutput {
    func numberOfTask() -> Int
    func task(at index: Int) -> Task?
    
    func addObserver(_ obj: TaskListObserver)
    func removeObserver(_ obj: TaskListObserver)
}

class TaskListModel: TaskListModelInput {
    
    var taskList: [Task] = []
    var observers: [TaskListObserver] = []
    
    init() {
    }

    func fetchTaskList(completion: @escaping (Result<[Task]>) -> ()) {
        
        DispatchQueue.mainSyncSafe {
            self.observers.forEach { $0.onStartTaskListUpdate() }
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0, execute: {
            self.taskList.append(Task(title: "By Apple", deadline: Date(timeIntervalSinceNow: 600)))
            self.taskList.append(Task(title: "By Orange", deadline: Date(timeIntervalSinceNow: 1000)))
            self.taskList.append(Task(title: "Read Book", deadline: Date(timeIntervalSinceNow: 1000)))
            completion(.success(self.taskList))
            self.observers.forEach { $0.onTaskListUpdate() }
            self.observers.forEach { $0.onTaskListUpdateDidFinish() }
        })
        
    }
}

extension TaskListModel: TaskListModelOutput {
    
    func addObserver(_ obj: TaskListObserver) {
        observers.append(obj)
    }
    
    func removeObserver(_ obj: TaskListObserver) {
        observers.removeAll { $0 === obj }
    }
    
    func numberOfTask() -> Int {
        return taskList.count
    }
    
    func task(at index: Int) -> Task? {
        guard taskList.count > index else { return nil }
        return taskList[index]
    }
    
}
