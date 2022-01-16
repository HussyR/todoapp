//
//  AllListsViewController.swift
//  SecondAppUIKIT
//
//  Created by Данил on 16.01.2022.
//

import UIKit

class AllListsViewController: UIViewController {

    var data = [Checklist]()
    var editIndex = -1
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
        setupTable()
        loadData()
    }

    private func setupTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
    }
    
    private func setupNavigation() {
        navigationItem.title = "Checklists"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewList))
    }
    
    @objc private func addNewList() {
        let vc = AddChecklistViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Load data
    
    private func loadData() {
        DataManager.loadData { [unowned self] data in
            self.data = data
        }
    }
    
}

extension AllListsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .detailDisclosureButton
        cell.textLabel?.text = data[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        editIndex = indexPath.row
        let vc = AddChecklistViewController()
        vc.itemToEdit = data[editIndex]
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ViewController()
        vc.data = data[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
//        DataManager.writeData(data: data)
    }
    
}

extension AllListsViewController: AddChecklistViewControllerDelegate {
    func addChecklistViewControllerDidCancel(_ controller: AddChecklistViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addChecklistViewController(_ controller: AddChecklistViewController, didFinishAdding item: Checklist) {
        navigationController?.popViewController(animated: true)
        data.append(item)
        tableView.reloadData()
    }
    
    func addChecklistViewController(_ controller: AddChecklistViewController, didFinishEdditing item: Checklist) {
        navigationController?.popViewController(animated: true)
        data[editIndex] = item
        tableView.reloadData()
    }
    
    
}
