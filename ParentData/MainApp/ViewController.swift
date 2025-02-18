//
//  ViewController.swift
//  ParentData
//
//  Created by Евгений Таракин on 18.02.2025.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - private property
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderTopPadding = 0
        tableView.register(DataCell.self, forCellReuseIdentifier: DataCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // MARK: - ViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }

}

// MARK: - private func

private extension ViewController {
    func commonInit() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}

// MARK: - obj-c

@objc private extension ViewController {
    func addChildCell() {
        
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        
        let headerButton = UIButton()
        headerButton.layer.cornerRadius = 24
        headerButton.layer.borderWidth = 2
        headerButton.layer.borderColor = UIColor.tintColor.cgColor
        headerButton.setTitleColor(.tintColor, for: .normal)
        headerButton.setTitle(" Добавить ребенка", for: .normal)
        headerButton.setImage(UIImage(systemName: "plus"), for: .normal)
        headerButton.addTarget(self, action: #selector(addChildCell), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, headerButton])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        if section == 0 {
            titleLabel.text = "Персональные данные"
            headerButton.isHidden = true
        } else {
            titleLabel.text = "Дети (макс. 5)"
        }
        
        headerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 4),
            stackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -4),
            stackView.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 48),
            
            headerButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        return headerView
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DataCell.reuseIdentifier, for: indexPath) as? DataCell
        else { return UITableViewCell() }
        
        return cell
    }
}

