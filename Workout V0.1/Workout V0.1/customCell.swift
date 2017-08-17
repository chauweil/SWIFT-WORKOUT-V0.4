//
//  customCell.swift
//  Workout V0.1
//
//  Created by Jeff on 30/07/2017.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit

class customCell: UITableViewCell {

    @IBOutlet weak var serieValue: UILabel!
  
    @IBOutlet weak var serieObj: UILabel!
    
    @IBOutlet weak var serieMean: UILabel!
    
    @IBOutlet weak var serieNum: UILabel!
    
    @IBOutlet weak var imageObj: UIImageView!


    @IBOutlet weak var imageStat: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    
    
    
}
