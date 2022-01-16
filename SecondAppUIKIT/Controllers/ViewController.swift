//
//  ViewController.swift
//  SecondAppUIKIT
//
//  Created by Данил on 16.01.2022.
//

import UIKit

class ViewController: UIViewController {

    var data : Checklist?
    var editIndex = -1
    
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        setupNavigation()
        view.backgroundColor = .white
        super.viewDidLoad()
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cellID")
        
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
//        loadData()
    }
    //MARK: LOAD Data
//    private func loadData() {
//        DataManager.downloadData { [unowned self] data in
//            self.data = data
//        }
//    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "To Do list"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
    }
    
    @objc private func addAction() {
        let vc = AddItemViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.tasks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        cell.accessoryType = .detailDisclosureButton
//        cell.updateCell(model: data[indexPath.row])
        cell.updateCell(model: data?.tasks[indexPath.row] ?? Task(task: "", completed: false))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell else {return}
        data?.tasks[indexPath.row].completed = (data?.tasks[indexPath.row].completed == true ? false : true)
        cell.updateCell(model: data?.tasks[indexPath.row] ?? Task(task: "", completed: false))
        tableView.deselectRow(at: indexPath, animated: true)
//        DataManager.writeData(data: data)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        data.remove(at: indexPath.row)
        data?.tasks.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
//        DataManager.writeData(data: data)
    }
    // Метод работает про нажатии на accesory button
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        editIndex = indexPath.row
        let vc = AddItemViewController()
        vc.itemToEdit = data?.tasks[editIndex]
//        vc.itemToEdit = data[editIndex]
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: AddItemViewControllerDelegate {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        print("cancel")
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: Task) {
        navigationController?.popViewController(animated: true)
        
//        data.append(item)
        data?.tasks.append(item)
        tableView.reloadData()
//        DataManager.writeData(data: data)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishEdditing item: Task) {
        navigationController?.popViewController(animated: true)
//        data[editIndex] = item
        data?.tasks[editIndex] = item
        tableView.reloadData()
//        DataManager.writeData(data: data)
    }
    
    
    
}
