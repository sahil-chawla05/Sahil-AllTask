//
//  TableOneCell.swift
//  Demo
//
//  Created by Saloni Pathak Behrens Bokelmann on 21/12/24.
//

import UIKit

class TableOneCell: UITableViewCell {

    @IBOutlet weak var type: UILabel!
    
    @IBOutlet weak var punchline: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
