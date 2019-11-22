//
//  UserDonationTableViewCell.swift
//  ProyectoFinal_Ricardo_V1
//
//  Created by Morello Santos Ricardo on 11/21/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//

import UIKit

class UserDonationTableViewCell: UITableViewCell {

    @IBOutlet weak var userDonationImage: UIImageView!
    @IBOutlet weak var labelCategory: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelAmount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
