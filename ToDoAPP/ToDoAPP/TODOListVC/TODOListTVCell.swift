//
//  TODOListTVCell.swift
//  ToDoAPP
//
//  Created by Loyltwo3ks on 04/11/24.
//

import UIKit

class TODOListTVCell: UITableViewCell {
    
    @IBOutlet weak var taskTitleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var taskStatusLbl: UILabel!
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var statusView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.shadow_Configure()
    }
    
    private func shadow_Configure() {
        self.taskView.layer.shadowColor = UIColor.black.cgColor
        self.taskView.layer.shadowRadius = 1.0
        self.taskView.layer.shadowOffset = .zero
        self.taskView.layer.shadowOpacity = 0.2
    }
}
