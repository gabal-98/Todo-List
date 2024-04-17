//
//  EntryViewController.swift
//  Project 1 ( Todo List )
//
//  Created by robusta on 17/04/2024.
//

import UIKit

class EntryViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    var delegate: EntryViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(saveTask))
    }
    
    @objc func saveTask(){
        guard let text = textField.text else { return }
        navigationController?.popViewController(animated: true)
        delegate?.didFinishAddingTask(controller: self, task: text)
    }
}

extension EntryViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
}

protocol EntryViewControllerDelegate {
    func didFinishAddingTask(controller: UIViewController , task:String)
}
