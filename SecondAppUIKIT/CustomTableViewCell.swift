//
//  CustomTableViewCell.swift
//  SecondAppUIKIT
//
//  Created by Данил on 16.01.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    private let label: UILabel = {
        let label = UILabel()
        label.text = "Example"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        accessoryType = .checkmark
        addSubview(label)
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20).isActive = true
    }
    
    func setLabelText(text: String) {
        label.text = text 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggleAccesoryType() {
        accessoryType = (accessoryType == .checkmark ? .none: .checkmark)
    }

}
