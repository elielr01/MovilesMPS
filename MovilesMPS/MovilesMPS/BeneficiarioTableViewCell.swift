//
//  BeneficiarioTableViewCell.swift
//  MovilesMPS
//
//  Created by Elí Emmanuel on 4/4/16.
//  Copyright © 2016 Elí Emmanuel. All rights reserved.
//

import UIKit

class BeneficiarioTableViewCell: UITableViewCell {
    //Outlets de la celda
    @IBOutlet var lbBeneficiarioNombre: UILabel!
    @IBOutlet var swtAsistencia: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
