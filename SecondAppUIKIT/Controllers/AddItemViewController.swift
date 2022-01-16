//
//  AddItemViewController.swift
//  SecondAppUIKIT
//
//  Created by Данил on 16.01.2022.
//

import UIKit

class AddItemViewController: UIViewController {

    override func viewDidLoad() {
        print("here")
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
    }
    private func setupNavigation() {
        navigationItem.title = "Add item"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
    }
    
    @objc private func doneAction() {
        print("save")
    }
    
    @objc private func cancelAction() {
        print("cancel")
        navigationController?.popViewController(animated: true)
    }
    
}
