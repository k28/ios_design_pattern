//
//  CommonTaskStore.swift
//  FluxSample
//
//  Created by K.Hatano on 2021/01/01.
//

import Foundation

enum CommonActionType {
    case showDialog(String?)
    case closeDialog
}

/// 共通動作のタスク
final class CommonActionStore: Store {
    
    private(set) var taskType: CommonActionType?
    
    override func onDispatch(_ action: Action) {
        switch action {
        case .commonAction(let type):
            self.taskType = type
            break
        default:
            return
        }
        
        emitChange()
    }
}
