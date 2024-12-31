//
//  TODOListFilterVC.swift
//  ToDoAPP
//
//  Created by Loyltwo3ks on 05/11/24.
//

import UIKit
import CoreData
import Toast_Swift

protocol TODOListFilterVCDelegate {
    func passFilterData(task: String,date: String,status: String)
}

class TODOListFilterVC: UIViewController {
    
    @IBOutlet weak var toDoListTaskTF: UITextField!
    @IBOutlet weak var toDoListTaskStatusTF: UITextField!
    @IBOutlet weak var toDoListTaskDateTF: UITextField!
    @IBOutlet weak var toDoListTaskFilterView: UIView!
    var delegate: TODOListFilterVCDelegate?
    
    var todoListStatus: String?
    var todoListDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.shadow_Configure()
        //self.filterData_Configure()
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
                if touch?.view == self.view{
                            dismiss(animated: true)
                }
    }
    
    @IBAction func didTapToDoListTaskStatusBtn(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "TaskStatusVC") as? TaskStatusVC {
            vc.delegate = self
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func didTapToDoListTaskDateBtn(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DatePickerVC") as? DatePickerVC {
            vc.delegate = self
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }

    }
    
    @IBAction func didTapToDoListTaskFilterBtn(_ sender: UIButton) {
        if self.toDoListTaskTF.text == "" {
            self.view.makeToast("Please Enter Task.",duration: 3.0,position: .bottom)
        }else if self.toDoListTaskDateTF.text == "" {
            self.view.makeToast("Please Select Date.",duration: 3.0,position: .bottom)
        }else if self.toDoListTaskStatusTF.text == "" {
            self.view.makeToast("Please Select Status.",duration: 3.0,position: .bottom)
        }else {
            self.delegate?.passFilterData(task: self.toDoListTaskTF.text ?? "", date: self.toDoListTaskDateTF.text ?? "", status: self.toDoListTaskStatusTF.text ?? "")
            self.dismiss(animated: true)
        }
    }
}

extension TODOListFilterVC: TaskStatusVCDelegate,DatePickerVCDelegate {
    func passDate(date: String) {
        self.toDoListTaskDateTF.text = date
    }
    
    func passStatus(status: String) {
        self.toDoListTaskStatusTF.text = status
    }
}

extension TODOListFilterVC {
    private func shadow_Configure() {
        self.toDoListTaskFilterView.layer.shadowColor = UIColor.black.cgColor
        self.toDoListTaskFilterView.layer.shadowRadius = 1.0
        self.toDoListTaskFilterView.layer.shadowOffset = .zero
        self.toDoListTaskFilterView.layer.shadowOpacity = 0.2
    }
    
    private func filterData_Configure() {
        if let status = todoListStatus {
            self.toDoListTaskStatusTF.text = status
        }
        if let date = todoListDate {
            self.toDoListTaskDateTF.text = date
        }
    }
}
