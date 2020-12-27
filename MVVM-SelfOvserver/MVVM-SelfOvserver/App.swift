//
//  App.swift
//  MVVM-SelfOvserver
//
//  Created by K.Hatano on 2020/12/27.
//

import Foundation

/// アプリで共通して使用する処理, データを保持する
final class App {
    
    init() {
    }

    /// Applicationが起動してからの初期化処理
    func initialize() {
    }
    
    let taskList = TaskListModel()
    
}
