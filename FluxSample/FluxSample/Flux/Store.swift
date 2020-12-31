//
//  Store.swift
//  FluxSample
//
//  Created by K.Hatano on 2020/12/31.
//

import Foundation

typealias Subscription = NSObjectProtocol

/// Storeのベースクラス
class Store {
    private enum NotificationName {
        static let storeChanged = Notification.Name("store-changed")
    }
    
    private lazy var dispatchToken: DispatchToken = {
        return dispatcher.register(callback: { [weak self] action in
            self?.onDispatch(action)
        })
    }()
    
    private let dispatcher: Dispatcher
    private let notificationCenter: NotificationCenter
    
    deinit {
        dispatcher.unregister(dispatchToken)
    }
    
    init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
        self.notificationCenter = NotificationCenter()
        _ = dispatchToken
    }
    
    /// Actionを処理する
    /// - note: 必ずサブクラスでオーバーライドする
    func onDispatch(_ action: Action) {
        fatalError("Must Override")
    }
    
    /// Storeの変更を通知する
    final func emitChange() {
        notificationCenter.post(name: NotificationName.storeChanged, object: nil)
    }
    
    /// Storeに対して変更監視の登録を行う (callbackが実行される)
    /// - note: Subscriptionは変更監視の解除を行う際に使う
    final func addListener(callback: @escaping () -> ()) -> Subscription {
        let using: (Notification) -> () = { notification in
            if notification.name == NotificationName.storeChanged {
                callback()
            }
        }
        
        return notificationCenter.addObserver(forName: NotificationName.storeChanged,
                                              object: nil,
                                              queue: nil,
                                              using: using)
    }
    
    /// 変更監視を停止する
    /// - note: addListenerで取得したSubscriptionを渡す
    final func removeListener(_ subscription: Subscription) {
        notificationCenter.removeObserver(subscription)
    }
}
