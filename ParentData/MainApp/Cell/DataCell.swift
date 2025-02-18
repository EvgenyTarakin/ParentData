//
//  DataCell.swift
//  ParentData
//
//  Created by Евгений Таракин on 18.02.2025.
//

import UIKit

// MARK: - TypeCell

enum TypeCell {
    case person
    case child
}

final class DataCell: UITableViewCell {
    
    // MARK: - property
    
    static let reuseIdentifier = String(describing: DataCell.self)
    
    // MARK: - private property
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textFieldStackView, deleteBackView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, ageTextField])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 12
        
        return stackView
    }()
    
    private lazy var nameTextField: TextField = {
        let textField = TextField()
        textField.configurate(type: .name)
        
        return textField
    }()
    
    private lazy var ageTextField: TextField = {
        let textField = TextField()
        textField.configurate(type: .age)
        
        return textField
    }()
    
    private lazy var deleteBackView: UIView = {
        let backView = UIView()
        backView.backgroundColor = .white
        
        backView.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: backView.topAnchor),
            deleteButton.leftAnchor.constraint(equalTo: backView.leftAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 62)
        ])
        
        return backView
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить", for: .normal)
        button.setTitleColor(.tintColor, for: .normal)
        button.setImage(UIImage(), for: .normal)
        button.addTarget(self, action: #selector(deleteCell), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        deleteBackView.isHidden = false
    }

}

// MARK: - func

extension DataCell {
    func configurate(type: TypeCell) {
        if type == .person {
            deleteBackView.isHidden = true
        }
    }
}

// MARK: - private func

private extension DataCell {
    func commonInit() {
        selectionStyle = .none
        backgroundColor = .white
        
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            mainStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            mainStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
    }
}

// MARK: - obj-c

@objc private extension DataCell {
    func deleteCell() {
        
    }
}
