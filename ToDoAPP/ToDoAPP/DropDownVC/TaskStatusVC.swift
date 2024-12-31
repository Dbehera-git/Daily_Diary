//
//  TaskStatusVC.swift
//  ToDoAPP
//
//  Created by Loyltwo3ks on 04/11/24.
//

import UIKit

protocol TaskStatusVCDelegate {
    func passStatus(status: String)
}



class TaskStatusVC: UIViewController {
    
    @IBOutlet weak var taskStatusTV: UITableView!
    @IBOutlet weak var taskStatusTVHeight: NSLayoutConstraint!
    var  taskStatusArray: [TaskStatusVCModel] = [
                                    TaskStatusVCModel(status: "Open"),
                                    TaskStatusVCModel(status: "InProgress"),
                                    TaskStatusVCModel(status: "Complete"),
                                    TaskStatusVCModel(status: "InHold")
                                    ]
    
    var delegate: TaskStatusVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.shadow_Configure()
        self.taskStatusTV.delegate = self
        self.taskStatusTV.dataSource = self
        self.taskStatusTV.register(UINib(nibName: "TaskTVCell", bundle: nil), forCellReuseIdentifier: "TaskTVCell")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
                if touch?.view == self.view{
                            dismiss(animated: true)
                }
    }
    
    private func shadow_Configure() {
        self.taskStatusTV.layer.shadowColor = UIColor.black.cgColor
        self.taskStatusTV.layer.shadowRadius = 1.0
        self.taskStatusTV.layer.shadowOffset = .zero
        self.taskStatusTV.layer.shadowOpacity = 0.2
    }


}
extension TaskStatusVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskStatusTVHeight.constant = CGFloat(taskStatusArray.count * 30)
        return taskStatusArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTVCell", for:indexPath) as? TaskTVCell
        guard let cell else {
            fatalError("No Data Found")
        }
        cell.taskDropDownLbl.text = taskStatusArray[indexPath.row].status
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskStatus = taskStatusArray[indexPath.row].status
        self.delegate?.passStatus(status: taskStatus)
        self.dismiss(animated: true)
    }

    
}
struct TaskStatusVCModel{
    let status: String
}
