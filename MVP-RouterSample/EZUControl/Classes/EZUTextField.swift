//
//  EZUTextField.swift
//  EZUControl
//
//  Created by K.Hatano on 2020/12/25.
//

import UIKit

open class EZUTextField: UITextField {
    
    /// 値が変更された時にCallされる
    open var onChangeValue: ((_ text: inout String) -> Void) = { _ in }
    /// 編集が完了した時にCallされる
    open var onEditingDidFinish: ((_ text: String) -> Void) = { _ in }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.addTarget(self, action: #selector(editingChanged), for: UIControl.Event.editingChanged)
        self.addTarget(self, action: #selector(editingChanged), for: UIControl.Event.editingDidEnd)
    }
    
    @objc private func editingChanged() {
        var text = self.text ?? ""
        onChangeValue(&text)
        self.text = text
    }
    
    @objc private func editingDidEnd() {
        onEditingDidFinish(self.text ?? "")
    }
    
}

