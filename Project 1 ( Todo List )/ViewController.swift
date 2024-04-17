//
//  ViewController.swift
//  Project 1 ( Todo List )
//
//  Created by robusta on 17/04/2024.
//

import UIKit

class ViewController: UIViewController {
        
    var tasks = [String]()
    let defaults = UserDefaults.standard

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        self.title = "Tasks"
        loadTasks()
    }

    @IBAction func sddButtonTapped(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Entry") as? EntryViewController
        vc?.delegate = self
        vc?.title = "New Task"
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func saveTasks(){
        defaults.set(tasks, forKey: "tasksArray")
    }
    
    func loadTasks(){
        if let savedTasks = defaults.object(forKey: "tasksArray") as? [String] {
            for task in savedTasks {
                tasks.append(task)
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedTask = tasks[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "Task") as? TaskViewController
        vc?.delegate = self
        vc?.selectedTask = selectedTask
        navigationController?.pushViewController(vc!, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
}
extension ViewController: EntryViewControllerDelegate {
    func didFinishAddingTask(controller: UIViewController, task: String) {
        tasks.append(task)
        tableView.reloadData()
        saveTasks()
    }
}

extension ViewController: TaskViewControllerDelegate {
    func didFinishDeletingTask(controller: UIViewController, taskName: String) {
        let index = tasks.firstIndex(of: taskName)
        tasks.remove(at: index!)
        tableView.reloadData()
    }
}
