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
        
    }
}
