//
//  TableViewCell.swift
//  Company_Task_Releted_To_TableView_And_CollectionView
//
//  Created by Apple on 17/12/22.
//

import UIKit

class TableViewCell: UITableViewCell {

//Mark :- Taking connection of Labels
    
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var lastNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
