//
//  AddChecklistViewController.swift
//  SecondAppUIKIT
//
//  Created by Данил on 16.01.2022.
//

import UIKit

protocol AddChecklistViewControllerDelegate: AnyObject {
    func addChecklistViewControllerDidCancel(_ controller: AddChecklistViewController)
    func addChecklistViewController(_ controller: AddChecklistViewController, didFinishAdding item: Checklist)
    func addChecklistViewController(_ controller: AddChecklistViewController, didFinishEdditing item: Checklist)
}

class AddChecklistViewController: UIViewController {

    var itemToEdit : Checklist?
    weak var delegate: AddChecklistViewControllerDelegate?
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .lightGray
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 60)) // Для отступа текста
        tf.leftViewMode = .always
        tf.placeholder = "Add a task"
        tf.layer.cornerRadius = 10
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupUI()
        if let item = itemToEdit {
            navigationItem.title = "Edit item"
            textField.text = item.title
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    private func setupNavigation() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Add item"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc private func doneAction() {
        if let itemToEdit = itemToEdit {
            itemToEdit.title = textField.text ?? ""
            delegate?.addChecklistViewController(self, didFinishEdditing: itemToEdit)
            return
        }
        
        print("Text field text is \(textField.text ?? "")")
        let model = Checklist(tasks: [], title: textField.text ?? "")
        delegate?.addChecklistViewController(self, didFinishAdding: model)
        
        
        
    }
    
    @objc private func cancelAction() {
        delegate?.addChecklistViewControllerDidCancel(self)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            textField.heightAnchor.constraint(equalToConstant: 60)
        ])
        textField.delegate = self
    }
    // Вызывается при нажатии на экран вне клавиатуры
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

extension AddChecklistViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
          let stringRange = Range(range, in: oldText)!
          let newText = oldText.replacingCharacters(
            in: stringRange,
            with: string)
          if newText.isEmpty {
              navigationItem.rightBarButtonItem?.isEnabled = false
          } else {
              navigationItem.rightBarButtonItem?.isEnabled = true
          }
        return true
    }
    // Вызывается при нажатии на Done на клавиатуре
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
}
