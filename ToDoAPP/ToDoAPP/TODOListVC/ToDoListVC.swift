//
//  ViewController.swift
//  ToDoAPP
//
//  Created by Loyltwo3ks on 04/11/24.
//

import UIKit
import CoreData

class ToDoListVC: UIViewController {
    
    @IBOutlet weak var tsakSearchBar: UISearchBar!
    @IBOutlet weak var toDoListTV: UITableView!
    @IBOutlet weak var noTaskFoundLbl: UILabel!
    var toDoListArray = [ToDoList]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.toDoListTV.delegate = self
        self.toDoListTV.dataSource = self
        self.toDoListTV.register(UINib(nibName: "TODOListTVCell", bundle: nil), forCellReuseIdentifier: "TODOListTVCell")
        self.tsakSearchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.retrieveTODOListData()
        self.ToDoListVC_Configure()
    }
    
    @IBAction func didTapFilterBtn(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier:"TODOListFilterVC") as?  TODOListFilterVC {
            vc.delegate = self
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func didTapAddTaskBtn(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CreateToDoListVC") as? CreateToDoListVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ToDoListVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TODOListTVCell", for: indexPath) as? TODOListTVCell
        guard let cell else {
            fatalError("No Data Found")
        }
        cell.taskTitleLbl.text = toDoListArray[indexPath.row].title
        cell.taskStatusLbl.text = toDoListArray[indexPath.row].status
        cell.dateLbl.text = toDoListArray[indexPath.row].date
        if cell.taskStatusLbl.text == "Open" {
            cell.statusView.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }else if cell.taskStatusLbl.text == "InProgress" {
            cell.statusView.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        }else if cell.taskStatusLbl.text == "Complete" {
            cell.statusView.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        }else if cell.taskStatusLbl.text == "InHold" {
            cell.statusView.backgroundColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "TODOListUpdateVC") as? TODOListUpdateVC {
            vc.passData = toDoListArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let container = appdelegate.persistentContainer.viewContext
            container.delete(self.toDoListArray[indexPath.row])
            self.toDoListArray.remove(at: indexPath.row)
            do {
                try container.save()
                self.navigationController?.popViewController(animated: true)

            }catch{
                print("Error")
            }
        }
        self.toDoListTV.deleteRows(at: [indexPath], with: .automatic)
        if self.toDoListArray.count == 0 {
            self.toDoListTV.isHidden = true
            self.noTaskFoundLbl.isHidden = false
        }
    }
}

extension ToDoListVC {
    //MARK: Retrieve TODO List Data
    func retrieveTODOListData() {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let container = appdelegate.persistentContainer.viewContext
        let request = NSFetchRequest<ToDoList>(entityName: "ToDoList")
//        let sorting = NSSortDescriptor(key: "title", ascending: false)
//        request.sortDescriptors = [sorting]
        do {
            let requestResult = try container.fetch(request)
            self.toDoListArray = requestResult
                self.toDoListTV.reloadData()
        }catch {
            print("Error")
        }
    }
    
    private func ToDoListVC_Configure() {
        if self.toDoListArray.count > 0 {
            self.toDoListTV.isHidden = false
            self.noTaskFoundLbl.isHidden = true
        }else {
            self.toDoListTV.isHidden = true
            self.noTaskFoundLbl.isHidden = false
        }
    }
}

extension ToDoListVC: UISearchBarDelegate {
    
    //MARK:  Function for search TODO List Task in the SearchBar
    func retrieveSearchToDoListTask(task: String) -> [ToDoList] {
        var toDoListTask = [ToDoList]()
       let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let container = appdelegate.persistentContainer.viewContext
        let request = NSFetchRequest<ToDoList>(entityName: "ToDoList")
        let predicate = NSPredicate(format: "title contains %@",task)
        request.predicate = predicate
        do {
            toDoListTask = try container.fetch(request)
        }catch {
            print("Error")
        }
        return toDoListTask
    }
    //MARK: Delegate method of UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            self.toDoListArray = retrieveSearchToDoListTask(task: searchText)
            self.toDoListTV.reloadData()
        }else{
            self.retrieveTODOListData()
        }
        
        if self.toDoListArray.count == 0 {
            self.noTaskFoundLbl.isHidden = false
        }else{
            self.noTaskFoundLbl.isHidden = true
        }
    }   
}
 
extension ToDoListVC: TODOListFilterVCDelegate{
    func passFilterData(task: String, date: String, status: String) {
        let filterTask = task
        let filterDate = date
        let filterStatus = status
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let container = appdelegate.persistentContainer.viewContext
        let request = NSFetchRequest<ToDoList>(entityName: "ToDoList")
        let filterTaskPredicate = NSPredicate(format: "title contains %@", filterTask)
        let filterStatusPredicate = NSPredicate(format: "status contains %@", filterStatus)
        let filterDatePredicate = NSPredicate(format: "date contains %@", filterDate)
        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [filterTaskPredicate,filterStatusPredicate,filterDatePredicate])
        request.predicate = andPredicate
        do{
            let requestResult = try container.fetch(request)
            self.toDoListArray = requestResult
            self.toDoListTV.reloadData()
        }catch{
            print("Error")
        }
        if self.toDoListArray.count == 0 {
            self.toDoListTV.isHidden = true
            self.noTaskFoundLbl.isHidden = false
        }
    }
}

