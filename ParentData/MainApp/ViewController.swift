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

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate { }

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

