//
//  TaskViewController.swift
//  Project 1 ( Todo List )
//
//  Created by robusta on 17/04/2024.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet var taskLabel: UILabel!
    var delegate: TaskViewControllerDelegate?
    var selectedTask = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskLabel.text = selectedTask
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
    }
    
    @objc func deleteTask(){
        self.delegate?.didFinishDeletingTask(controller: self, taskName: selectedTask)
        navigationController?.popViewController(animated: true)
    }
}

protocol TaskViewControllerDelegate {
    func didFinishDeletingTask(controller: UIViewController , taskName: String)
}
