//
//  FetchDataCell.swift
//  DataCore_Practice
//
//  Created by admin on 21/11/24.
//

import UIKit

class FetchDataCell: UITableViewCell {
    
    
    @IBOutlet weak var jokeId: UILabel!
    @IBOutlet weak var jokePunchline: UILabel!
    @IBOutlet weak var jokeSetup: UILabel!
    @IBOutlet weak var jokeType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
