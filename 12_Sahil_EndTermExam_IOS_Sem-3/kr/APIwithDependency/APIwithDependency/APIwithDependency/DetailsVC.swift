//
//  DetailsVC.swift
//  APIwithDependency
//
//  Created by admin on 24/09/24.
//

import UIKit

class DetailsVC: UIViewController {

    
    @IBOutlet weak var punchlinejokelbl: UILabel!
    @IBOutlet weak var setupjokelbl: UILabel!
    @IBOutlet weak var titlejokelbl: UILabel!
    @IBOutlet weak var idjokelbl: UILabel!
    
    var titlejoke: String!
    var punchlinejoke: String!
    
    var joketapped : JokeModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.idjokelbl.text = "\(joketapped.id)"
        self.titlejokelbl.text = "\(joketapped.type)"
        self.setupjokelbl.text = "\(joketapped.setup)"
        self.punchlinejokelbl.text = "\(joketapped.punchline)"

    }
}
