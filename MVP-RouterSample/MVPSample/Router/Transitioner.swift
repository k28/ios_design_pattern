//
//  Transitioner.swift
//  MVP-RouterSample
//
//  Created by K.Hatano on 2021/01/06.
//

import UIKit

protocol Transitioner where Self: UIViewController {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func popViewController(animated: Bool)
    func popToRootViewController(animated: Bool)
    func popToViewController(_ viewController: UIViewController, animated: Bool)
    func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    func dismiss(animated: Bool)
}

extension Transitioner {
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        guard let nc = self.navigationController else { return }
        nc.pushViewController(viewController, animated: animated)
    }
    
    func popViewController(animated: Bool) {
        guard let nc = self.navigationController else { return }
        nc.popViewController(animated: animated)
    }
    
    func popToRootViewController(animated: Bool) {
        guard let nc = self.navigationController else { return }
        nc.popToRootViewController(animated: animated)
    }
    
    func popToViewController(_ viewController: UIViewController, animated: Bool) {
        guard let nc = self.navigationController else { return }
        nc.popToViewController(viewController, animated: animated)
    }
    
    func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        self.present(viewController, animated: animated, completion: completion)
    }
    
    func dismiss(animated: Bool) {
        self.dismiss(animated: animated)
    }
}
