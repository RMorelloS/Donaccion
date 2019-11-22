//
//  DonationTableViewCell.swift
//  ProyectoFinal_Ricardo_V1
//
//  Created by Morello Santos Ricardo on 11/15/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//

import UIKit

class DonationTableViewCell: UITableViewCell {
    @IBOutlet weak var labelPersonName : UILabel!
    @IBOutlet weak var labelDescription : UILabel!
    @IBOutlet weak var labelEmail : UILabel!
    @IBOutlet weak var imageDonation : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
