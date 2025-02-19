//
//  ViewController.swift
//  ParentData
//
//  Created by Евгений Таракин on 18.02.2025.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - private property
    
    private var personData = Human(name: nil, age: nil)
    private var childrenData: [Human] = []
    
    private lazy var deleteAllButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 22
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.red.cgColor
        button.setTitleColor(.red, for: .normal)
        button.setTitle("Очистить", for: .normal)
        button.setImage(UIImage(), for: .normal)
        button.addTarget(self, action: #selector(tapDeleteAllButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
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
        registerForKeyboardNotifications()
    }
    
    // MARK: - deinit
    
    deinit {
        removeKeyboardNotifications()
    }

}

// MARK: - private func

private extension ViewController {
    func commonInit() {
        view.backgroundColor = .white
        
        view.addSubview(deleteAllButton)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            deleteAllButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            deleteAllButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            deleteAllButton.heightAnchor.constraint(equalToConstant: 44),
            deleteAllButton.widthAnchor.constraint(equalToConstant: 200),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: deleteAllButton.topAnchor, constant: -8),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - obj-c

@objc private extension ViewController {
    func showKeyboard(_ sender: Notification) {
        if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            var inset = tableView.contentInset
            inset.bottom = keyboardSize.height
            tableView.contentInset.bottom = inset.bottom - 72
        }
    }
    
    func hideKeyboard() {
        view.endEditing(true)
        tableView.contentInset = .zero
    }
    
    func addChildCell() {
        if childrenData.count != 5 {
            childrenData.append(Human(name: nil, age: nil))
            
            let lastIndexPath = IndexPath(row: childrenData.count - 1, section: 1)
            tableView.beginUpdates()
            tableView.insertRows(at: [lastIndexPath], with: .bottom)
            tableView.endUpdates()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                guard let self else { return }
                tableView.reloadSections([1], with: .none)
                tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
            }
        }
    }
    
    func tapDeleteAllButton() {
        let alert = UIAlertController(title: "Вы действительно хотите cбросить все данные?",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Сбросить данные",
                                      style: .destructive,
                                      handler: deleteAllData))
        alert.addAction(UIAlertAction(title: "Отмена",
                                      style: .cancel))
        
        present(alert, animated: true)
    }
    
    func deleteAllData(_ alert: UIAlertAction) {
        personData = Human(name: nil, age: nil)
        childrenData.removeAll()
        tableView.reloadData()
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
        headerButton.layer.cornerRadius = 22
        headerButton.layer.borderWidth = 2
        headerButton.layer.borderColor = UIColor.tintColor.cgColor
        headerButton.setTitleColor(.tintColor, for: .normal)
        headerButton.setTitle(" Добавить ребенка", for: .normal)
        headerButton.setImage(UIImage(systemName: "plus"), for: .normal)
        headerButton.addTarget(self, action: #selector(addChildCell), for: .touchUpInside)
        headerButton.isHidden = childrenData.count == 5 ? true : false
        
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
            stackView.topAnchor.constraint(equalTo: headerView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 44),
            
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
        if section == 0 {
            return 1
        }
        
        return childrenData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DataCell.reuseIdentifier, for: indexPath) as? DataCell
        else { return UITableViewCell() }
        
        var data = Human(name: nil, age: nil)
        if indexPath.section == 0 {
            data = personData
        } else {
            data = childrenData[indexPath.row]
        }
        
        let name = data.name ?? ""
        let age = data.age == nil ? "" : "\(data.age ?? 0)"
        
        if indexPath.section == 0 {
            cell.configurate(type: .person, index: indexPath.row, name: name, age: age)
        } else {
            cell.configurate(type: .child, index: indexPath.row, name: name, age: age)
        }
        cell.delegate = self
        
        return cell
    }
}

// MARK: - DataCellDelegate

extension ViewController: DataCellDelegate {
    func didSelectDeleteButton(for index: Int) {
        childrenData.remove(at: index)
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: index, section: 1)], with: .right)
        tableView.endUpdates()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self else { return }
            tableView.reloadSections([1], with: .none)
        }
    }
    
    func updateInfo(text: String, section: Int, index: Int, type: TypeTextField) {
        if section == 0 {
            switch type {
            case .name: personData.name = text
            case .age: personData.age = Int(text)
            }
        } else {
            switch type {
            case .name: childrenData[index].name = text
            case .age: childrenData[index].age = Int(text)
            }
        }
    }
}
