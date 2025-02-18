//
//  TextField.swift
//  ParentData
//
//  Created by Евгений Таракин on 18.02.2025.
//

import UIKit

// MARK: - TextFieldDelegate

protocol TextFieldDelegate: AnyObject {
    func textFieldDidChange(type: TypeTextField, text: String)
}

// MARK: - TypeTextField

enum TypeTextField {
    case name
    case age
    
    var title: String {
        switch self {
        case .name: return "Имя"
        case .age: return "Возраст"
        }
    }
}

final class TextField: UIView {
    
    // MARK: - property
    
    weak var delegate: TextFieldDelegate?
    
    private var type: TypeTextField = .name
    
    // MARK: - private property
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, textField])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.addToolBarWithDoneButton()
        textField.returnKeyType = .done
        textField.attributedPlaceholder = NSAttributedString(string: "Не указано",
                                                             attributes: [.foregroundColor: UIColor.lightGray])
        textField.delegate = self
        
        return textField
    }()

    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}


// MARK: - func

extension TextField {
    func configurate(type: TypeTextField) {
        self.type = type
        titleLabel.text = type.title
        if type == .age {
            textField.keyboardType = .numberPad
        }
    }
    
    func setValue(_ value: String) {
        textField.text = value
    }
}

// MARK: - private func

private extension TextField {
    func commonInit() {
        layer.cornerRadius = 6
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
}

// MARK: - UITextFieldDelegate

extension TextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var text = (textField.text ?? "") + string
        if string.isEmpty {
            text.removeLast()
        }
        delegate?.textFieldDidChange(type: type, text: text)
        
        return true
    }
}
