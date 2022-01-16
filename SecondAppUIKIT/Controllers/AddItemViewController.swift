//
//  AddItemViewController.swift
//  SecondAppUIKIT
//
//  Created by Данил on 16.01.2022.
//

import UIKit

protocol AddItemViewControllerDelegate: AnyObject {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: Model)
    func addItemViewController(_ controller: AddItemViewController, didFinishEdditing item: Model)
}

class AddItemViewController: UIViewController {

    var itemToEdit: Model?
    weak var delegate: AddItemViewControllerDelegate?
    
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
            textField.text = item.task
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
        
        if let _ = itemToEdit {
            let newItem = Model(task: textField.text ?? "", completed: itemToEdit?.completed ?? false)
            delegate?.addItemViewController(self, didFinishEdditing: newItem)
            return
        }
        
        print("Text field text is \(textField.text ?? "")")
        let model = Model(task: textField.text ?? "", completed: false)
        delegate?.addItemViewController(self, didFinishAdding: model)
        
        
        
    }
    
    @objc private func cancelAction() {
        delegate?.addItemViewControllerDidCancel(self)
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
// Вызывается для включаения и отключения кнопки готово, в зависимости от наполнения  textField
extension AddItemViewController: UITextFieldDelegate {
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
