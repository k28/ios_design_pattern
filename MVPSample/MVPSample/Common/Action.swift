//
//  Action.swift
//  MVPSample
//
//  Created by K.Hatano on 2020/12/20.
//

import Foundation
import MBProgressHUD

struct Action {}

extension Action {
    
    static func showDialog(view: UIView, _ message: String) {
        DispatchQueue.mainSyncSafe {
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.label.text = message
        }
    }
    
    static func closeDialog(view: UIView) {
        DispatchQueue.mainSyncSafe {
            MBProgressHUD.forView(view)?.hide(animated: true)
        }
    }
    
}
