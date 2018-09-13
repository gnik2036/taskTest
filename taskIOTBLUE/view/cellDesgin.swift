//
//  cellDesgin.swift
//  taskIOTBLUE
//
//  Created by shady on 9/13/18.
//  Copyright © 2018 XYZ. All rights reserved.
//

import UIKit

class cellDesgin: UITableViewCell {

    @IBOutlet weak var latLabel: UILabel!
    
    @IBOutlet weak var lonlabel: UILabel!
    
    @IBOutlet weak var latTextLabel: UILabel!
    
    @IBOutlet weak var lonTextLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
