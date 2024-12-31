//
//  TaskPriorityVC.swift
//  ToDoAPP
//
//  Created by Loyltwo3ks on 04/11/24.
//

import UIKit
protocol TaskPriorityVCDelegate {
    func passPriority(priority: String)
}


class TaskPriorityVC: UIViewController {
    
    @IBOutlet weak var taskPriorityTV: UITableView!
    @IBOutlet weak var taskPriorityTVHeight: NSLayoutConstraint!
    var delegate: TaskPriorityVCDelegate?
    var taskPriorityArray: [TaskPriorityVCModel] = [
                                  TaskPriorityVCModel(priority: "Low"),
                                  TaskPriorityVCModel(priority: "Medium"),
                                  TaskPriorityVCModel(priority: "High"),
                                  TaskPriorityVCModel(priority: "Critical"),
                                  TaskPriorityVCModel(priority: "Urgent")
                                 ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.shadow_Configure()
        self.taskPriorityTV.delegate = self
        self.taskPriorityTV.dataSource = self
        self.taskPriorityTV.register(UINib(nibName: "TaskTVCell", bundle: nil), forCellReuseIdentifier: "TaskTVCell")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
                if touch?.view == self.view{
                            dismiss(animated: true)
                }
    }
    
    private func shadow_Configure() {
        self.taskPriorityTV.layer.shadowColor = UIColor.black.cgColor
        self.taskPriorityTV.layer.shadowRadius = 1.0
        self.taskPriorityTV.layer.shadowOffset = .zero
        self.taskPriorityTV.layer.shadowOpacity = 0.2
    }
    


}
extension TaskPriorityVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskPriorityTVHeight.constant = CGFloat(taskPriorityArray.count * 30)
        return taskPriorityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTVCell", for: indexPath) as? TaskTVCell
        guard let cell else {
            fatalError("No Data Found")
        }
        cell.taskDropDownLbl.text = taskPriorityArray[indexPath.row].priority
//        if cell.taskDropDownLbl.text == "Low" {
//            cell.taskDropDownLbl.textColor = #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1)
//        }else if cell.taskDropDownLbl.text == "Medium" {
//            cell.taskDropDownLbl.textColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
//        }else if cell.taskDropDownLbl.text == "High" {
//            cell.taskDropDownLbl.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
//        }else if cell.taskDropDownLbl.text == "Critical" {
//            cell.taskDropDownLbl.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
//        }else if cell.taskDropDownLbl.text == "Urgent" {
//            cell.taskDropDownLbl.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
//        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let priority = taskPriorityArray[indexPath.row].priority
        self.delegate?.passPriority(priority: priority)
        self.dismiss(animated: true)
    }

    
    
}

struct TaskPriorityVCModel {
    let priority: String
}
