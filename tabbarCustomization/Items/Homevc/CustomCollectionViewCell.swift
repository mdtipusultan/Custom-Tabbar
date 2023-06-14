//
//  CustomCollectionViewCell.swift
//  CloudStorageAppDesign
//
//  Created by Tipu on 23/5/23.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageview1: UIImageView!
    
    @IBOutlet weak var imageview2: UIImageView!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
            }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
    }
}
