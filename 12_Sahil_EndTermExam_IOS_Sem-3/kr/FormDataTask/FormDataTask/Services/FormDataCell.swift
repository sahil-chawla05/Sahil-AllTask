//
//  FormDataCell.swift
//  FormDataTask
//
//  Created by admin on 26/11/24.
//

import UIKit

class FormDataCell: UITableViewCell {

    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var streamLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
