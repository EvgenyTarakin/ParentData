//
//  UITextField + Extension.swift
//  ParentData
//
//  Created by Евгений Таракин on 18.02.2025.
//

import UIKit

extension UITextField {
    
    // MARK: - func
    
    func addToolBarWithDoneButton() {
        let toolbar = UIToolbar()
        toolbar.backgroundColor = .white
        toolbar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                          target: nil,
                                          action: nil)
        let doneButton = UIBarButtonItem(title: "Готово",
                                         style: .done,
                                         target: self,
                                         action: #selector(doneButtonAction))
        toolbar.setItems([spaceButton, doneButton], animated: false)
        autocorrectionType = .no
        spellCheckingType = .no
        inputAccessoryView = toolbar
    }
    
    // MARK: - obj-c
    
    @objc private func doneButtonAction() {
        resignFirstResponder()
    }
}
