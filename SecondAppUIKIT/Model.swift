//
//  Model.swift
//  SecondAppUIKIT
//
//  Created by Данил on 16.01.2022.
//

struct Model {
    
    var task: String = ""
    var completed: Bool = false
    
    static func getData() -> [Model] {
        return [
            Model(task: "Walk"),
            Model(task: "Read"),
            Model(task: "Clean"),
            Model(task: "Cook"),
            Model(task: "Study")
        ]
    }
    
}
