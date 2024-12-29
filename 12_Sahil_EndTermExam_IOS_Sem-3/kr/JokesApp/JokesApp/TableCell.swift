//
//  TableCell.swift
//  JokesApp
//
//  Created by admin on 05/09/24.
//

import UIKit

class TableCell: UITableViewCell {
    
    
    @IBOutlet weak var jokeslbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
