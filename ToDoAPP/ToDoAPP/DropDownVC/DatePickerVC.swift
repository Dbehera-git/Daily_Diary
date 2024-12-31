//
//  DatePickerVC.swift
//  ToDoAPP
//
//  Created by Loyltwo3ks on 04/11/24.
//

import UIKit

protocol DatePickerVCDelegate{
    func passDate(date: String)
}

class DatePickerVC: UIViewController {
    
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    var date = ""
    var delegate: DatePickerVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datePicker.date = Date()
        self.datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
        self.datePicker.datePickerMode = .dateAndTime
        self.dateSelected()
        self.shadow_Configure()
    }
    @objc func dateSelected(){
           let dateFormatter = DateFormatter()
          dateFormatter.dateStyle = .full
           dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        self.date = dateFormatter.string(from: datePicker.date)
       }
    
    private func shadow_Configure() {
        self.datePickerView.layer.shadowColor = UIColor.black.cgColor
        self.datePickerView.layer.shadowRadius = 1.0
        self.datePickerView.layer.shadowOffset = .zero
        self.datePickerView.layer.shadowOpacity = 0.2
    }
    
    
    @IBAction func didTapConfirmBtn(_ sender: UIButton) {
        self.delegate?.passDate(date: date)
        self.dismiss(animated: true)
    }
    
    
    @IBAction func didTapCancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    

}
