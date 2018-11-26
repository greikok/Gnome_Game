//
//  InhabitanTableViewCell.swift
//  BrastlewarkGame
//
//  Created by Hector Hernandez on 11/22/18.
//  Copyright © 2018 Hector Hernandez. All rights reserved.
//

import UIKit

class InhabitanTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var friends: UILabel!
    @IBOutlet weak var professions: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }
    
}
