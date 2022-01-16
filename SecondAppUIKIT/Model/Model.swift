//
//  Model.swift
//  SecondAppUIKIT
//
//  Created by Данил on 16.01.2022.
//

class Task: Codable {
    var task: String = ""
    var completed: Bool = false
    
    init(task: String, completed: Bool) {
        self.completed = completed
        self.task = task
    }
}


class Checklist: Codable {
    var tasks = [Task]()
    var title: String = ""
    static func getData() -> [Checklist] {
        return [
            Checklist(tasks: [
                Task(task: "Walk", completed: true),
                Task(task: "Read", completed: false)
            ], title: "First"),
            Checklist(tasks: [
                Task(task: "Clean", completed: false),
                Task(task: "Cook",  completed: true)
            ], title: "Second"),
            Checklist(tasks: [
                Task(task: "Study", completed: false)
            ], title: "Third")
        ]
    }
    
    init(tasks: [Task], title: String) {
        self.tasks = tasks
        self.title = title
    }
    
}
