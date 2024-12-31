//
//  TODOListUpdateVC.swift
//  ToDoAPP
//
//  Created by Loyltwo3ks on 05/11/24.
//

import UIKit
import CoreData
import Toast_Swift

class TODOListUpdateVC: UIViewController {
    
    @IBOutlet weak var toDoTaskLbl: UILabel!
    @IBOutlet weak var toDoTaskTF: UITextField!
    @IBOutlet weak var toDoDateTF: UITextField!
    @IBOutlet weak var toDoStatusTF: UITextField!
    @IBOutlet weak var toDoPriorityTF: UITextField!
    @IBOutlet weak var toDoDescriptionTxtView: UITextView!
    @IBOutlet weak var toDoRemarkLbl: UILabel!
    @IBOutlet weak var toDoRemarkTxtView: UITextView!
    @IBOutlet weak var toDoTaskUpdateBtn: UIButton!
    
    var passData: ToDoList?
    var storageContainer = ToDoListStorage()
    var retrieveTODOListTask: ToDoListVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.toDoDescriptionTxtView.delegate = self
        self.toDoList_Update_Configure()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateTODOTaskData()
        self.toDoList_RemarkTextView_Configure()
       // self.toDoList_PriorityTextColor_Configure()
    }

    @IBAction func didTapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func didTapTODODateBtn(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DatePickerVC") as? DatePickerVC {
            vc.delegate = self
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func didTapTODOStatusBtn(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "TaskStatusVC") as? TaskStatusVC {
            vc.delegate = self
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
        
    }
    
    @IBAction func didTapTODOPriorityBtn(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "TaskPriorityVC") as? TaskPriorityVC {
            vc.delegate = self
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func didTapTODOTaskUpdateBtn(_ sender: UIButton) {
        if self.toDoTaskTF.text == "" {
            self.view.makeToast("Task TextField Can't be Empty.Please Enter Task",duration: 3.0,position: .bottom)
        }else {
            self.updateTODOTaskData()
            self.navigationController?.popViewController(animated: true)
        }
           
    }
    
//    @IBAction func didTapTODOTaskDeleteBtn(_ sender: UIButton) {
//        self.deleteTODOTaskData()
//        self.navigationController?.popViewController(animated: true)
//    }
    
}
extension TODOListUpdateVC {
    
    private func toDoList_Update_Configure() {
        self.toDoTaskLbl.text = passData?.title ?? ""
        self.toDoTaskTF.text = passData?.title ?? ""
        self.toDoDateTF.text = passData?.date ?? ""
        self.toDoStatusTF.text = passData?.status ?? ""
        self.toDoPriorityTF.text = passData?.priority ?? ""
        self.toDoDescriptionTxtView.text = passData?.describe ?? ""
        self.toDoRemarkTxtView.text = passData?.remark ?? ""
        self.toDoTaskUpdateBtn.layer.borderWidth = 1
        self.toDoTaskUpdateBtn.layer.borderColor = UIColor.systemBlue.cgColor
        self.toDoList_PriorityTextColor_Configure()
    }
    
    private func toDoList_RemarkTextView_Configure() {
        if toDoStatusTF.text == "Complete" {
            self.toDoRemarkLbl.isHidden = false
            self.toDoRemarkTxtView.isHidden = false
        }else {
            self.toDoRemarkLbl.isHidden = true
            self.toDoRemarkTxtView.isHidden = true
        }
    }
    
    private func toDoList_PriorityTextColor_Configure() {
        if toDoPriorityTF.text == "Low" {
            self.toDoPriorityTF.textColor = #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1)
        }else if toDoPriorityTF.text == "Medium" {
            self.toDoPriorityTF.textColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        }else if toDoPriorityTF.text == "High" {
            self.toDoPriorityTF.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }else if toDoPriorityTF.text == "Critical" {
            self.toDoPriorityTF.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }else if toDoPriorityTF.text == "Urgent"{
            self.toDoPriorityTF.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        }
    }
    
    //MARK: Update TODO Task
    func updateTODOTaskData() {
        passData?.title = toDoTaskTF.text ?? ""
        passData?.date = toDoDateTF.text ?? ""
        passData?.status = toDoStatusTF.text ?? ""
        passData?.priority = toDoPriorityTF.text ?? ""
        passData?.describe = toDoDescriptionTxtView.text ?? ""
        passData?.remark = toDoRemarkTxtView.text ?? ""
        storageContainer.saveContext()
    }
    
    //MARK: Delete TODO Task
//    func deleteTODOTaskData() {
//        let deleteToDotask = passData
//        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
//        let container = appdelegate.persistentContainer.viewContext
//        container.delete(deleteToDotask!)
//        self.retrieveTODOListTask?.retrieveTODOListData()
//        
//    }
}

extension TODOListUpdateVC: DatePickerVCDelegate,TaskStatusVCDelegate,TaskPriorityVCDelegate {
    func passDate(date: String) {
        self.toDoDateTF.text = date
    }
    
    func passStatus(status: String) {
        self.toDoStatusTF.text = status
        if toDoStatusTF.text == "Complete" {
            self.toDoRemarkLbl.isHidden = false
            self.toDoRemarkTxtView.isHidden = false
        }else {
            self.toDoRemarkLbl.isHidden = true
            self.toDoRemarkTxtView.isHidden = true
        }
    }
    
    func passPriority(priority: String) {
        self.toDoPriorityTF.text = priority
    }
}

extension TODOListUpdateVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let currentText = textView.text {
            let updateText = (currentText as NSString).replacingCharacters(in: range, with: text)
            let allowedCharacter = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn: text)
            return allowedCharacter.isSuperset(of: characterSet) && updateText.count <= 100
        }
        return false
    }
}


