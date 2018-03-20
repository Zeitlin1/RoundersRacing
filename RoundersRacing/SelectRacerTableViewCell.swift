//
//  SelectRacerTableViewCell.swift
//  RoundersRacing
//
//  Created by Anthony on 3/19/18.
//  Copyright © 2018 Anthony. All rights reserved.
//

import UIKit

class SelectRacerTableViewCell: UITableViewCell {

    @IBOutlet weak var racerName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.backgroundColor = UIColor.blue
        } else {
            self.backgroundColor = UIColor.clear
        }
        // Configure the view for the selected state
    }

}
