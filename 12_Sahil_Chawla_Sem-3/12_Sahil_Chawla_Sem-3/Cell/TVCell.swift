//
//  TVCell.swift
//  SegmentWithApi
//
//  Created by Hiren Masaliya on 03/12/24.
//

import UIKit

class TVCell: UITableViewCell {

    @IBOutlet weak var lblSetup: UILabel!
    
    @IBOutlet weak var lblPunchline: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
