//
//  TableTwoCell.swift
//  Demo
//
//  Created by Saloni Pathak Behrens Bokelmann on 21/12/24.
//

import UIKit

class TableTwoCell: UITableViewCell {

    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var punchline: UILabel!
    @IBOutlet weak var setup: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
