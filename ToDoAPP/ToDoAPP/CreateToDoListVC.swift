//
//  CreateToDoListVC.swift
//  ToDoAPP
//
//  Created by Loyltwo3ks on 04/11/24.
//

import UIKit
import Toast_Swift

class CreateToDoListVC: UIViewController {

    @IBOutlet weak var taskTF: UITextField!
    @IBOutlet weak var priorityTF: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    var storageContainer = ToDoListStorage()
    var toDoListDate = Date()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.descTextView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.toDoList_PriorityTextColor_Configure()
    }
    
    @IBAction func didTapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func didTapPriorityBtn(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "TaskPriorityVC") as? TaskPriorityVC{
            vc.delegate = self
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    
    
        
    @IBAction func didTapSaveBtn(_ sender: UIButton) {
        if self.taskTF.text == "" {
            self.view.makeToast("Please Enter Task.",duration: 3.0,position: .bottom)
        }else{
            self.createTODOList()
            self.navigationController?.popViewController(animated: true)
        }
    }
}
extension CreateToDoListVC {
    //MARK: Create TODO List
    func createTODOList() {
        let toDoList = ToDoList(context:storageContainer.persistentContainer.viewContext)
        toDoList.title = taskTF.text ?? ""
        toDoList.status = "Open"
        toDoList.date = "\(toDoListDate)"
        toDoList.priority = priorityTF.text ?? ""
        toDoList.describe = descTextView.text ?? ""
        storageContainer.saveContext()
    }
    private func toDoList_PriorityTextColor_Configure() {
        if priorityTF.text == "Low" {
            self.priorityTF.textColor = #colorLiteral(red: 0, green: 0.4235294118, blue: 0.7098039216, alpha: 1)
        }else if priorityTF.text == "Medium" {
            self.priorityTF.textColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        }else if priorityTF.text == "High" {
            self.priorityTF.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }else if priorityTF.text == "Critical" {
            self.priorityTF.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }else if priorityTF.text == "Urgent"{
            self.priorityTF.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        }
    }
}

extension CreateToDoListVC: UITextViewDelegate {
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

extension CreateToDoListVC: TaskPriorityVCDelegate {
    func passPriority(priority: String) {
        self.priorityTF.text = priority
    }
    
    
}
