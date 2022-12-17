//
//  CollectionViewCell.swift
//  Company_Task_Releted_To_TableView_And_CollectionView
//
//  Created by Apple on 17/12/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

//Mark :- Take Connection of View and ImageView
    
    @IBOutlet var view: UIView!
    @IBOutlet var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
