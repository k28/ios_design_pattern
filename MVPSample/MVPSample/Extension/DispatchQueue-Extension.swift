//
//  DispatchQueue-Extension.swift
//  MVPSample
//
//  Created by kazuya on 2020/12/20.
//

import Foundation

extension DispatchQueue {
    
    static func mainSyncSafe(_ action:@escaping (() -> Void)) {
        if Thread.isMainThread {
            action()
        } else {
            DispatchQueue.main.async(execute: action)
        }
    }
    
}
