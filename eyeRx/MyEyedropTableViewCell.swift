//
//  MyEyedropTableViewCell.swift
//  eyeRx
//
//  Created by ET USER on 6/16/20.
//  Copyright © 2020 mHealthWellnessLLC. All rights reserved.
//

import UIKit

class MyEyedropTableViewCell: UITableViewCell {

    @IBOutlet weak var eyedropImage: UIImageView!
    @IBOutlet weak var eyedropInfo: UILabel!
    @IBOutlet weak var eyedropName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
