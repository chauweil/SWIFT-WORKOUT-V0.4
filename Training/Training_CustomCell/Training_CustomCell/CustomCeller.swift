//
//  CustomCeller.swift
//  Training_CustomCell
//
//  Created by Jeff on 30/07/2017.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit

class CustomCeller: UITableViewCell {

    @IBOutlet weak var lab1: UILabel!
    @IBOutlet weak var lab2: UILabel!
    
    @IBOutlet weak var serieCurrent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
