//
//  ISPostCustomCell.swift
//  iSaldos
//
//  Created by Andres Felipe Ocampo Eljaiesk on 2/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class ISPostCustomCell: UITableViewCell {
    
    @IBOutlet weak var myImagenPerfil: UIImageView!
    @IBOutlet weak var myUsername: UILabel!
    @IBOutlet weak var myNombreYApellido: UILabel!
    @IBOutlet weak var myFechaPost: UILabel!
    @IBOutlet weak var myDescripcionPost: UILabel!
    @IBOutlet weak var myImagenPost: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
