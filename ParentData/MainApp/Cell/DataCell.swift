//
//  DataCell.swift
//  ParentData
//
//  Created by Евгений Таракин on 18.02.2025.
//

import UIKit

final class DataCell: UITableViewCell {
    
    // MARK: - property
    
    static let reuseIdentifier = String(describing: DataCell.self)
    
    // MARK: - private property
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, ageTextField])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
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

    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - private func

private extension DataCell {
    func commonInit() {
        selectionStyle = .none
        backgroundColor = .white
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
    }
}
