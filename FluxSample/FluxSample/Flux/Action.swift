//
//  Action.swift
//  FluxSample
//
//  Created by K.Hatano on 2020/12/31.
//

import Foundation

enum Action {
    
    case addTask(Task)
    case removeTask(Task)
    
    /// インジケータを出す
    case showIndicator(String?)
    case closeIndicator
}
