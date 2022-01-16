//
//  CustomTableViewCell.swift
//  SecondAppUIKIT
//
//  Created by Данил on 16.01.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    private let checkmarkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "√"
        label.font = UIFont(name: "Helvetica Neue Bold", size: 22)

        return label
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Example"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(checkmarkLabel)
        checkmarkLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10).isActive = true
        checkmarkLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(label)
        label.leadingAnchor.constraint(equalTo: checkmarkLabel.trailingAnchor, constant: 5).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20).isActive = true
    }
    
    func updateCell(model: Task) {
        label.text = model.task
        checkmarkLabel.alpha = (model.completed == true ? 1 : 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
