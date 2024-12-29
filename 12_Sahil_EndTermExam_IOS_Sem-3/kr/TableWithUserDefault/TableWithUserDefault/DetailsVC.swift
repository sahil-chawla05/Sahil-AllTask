//
//  DetailsVC.swift
//  TableWithUserDefault
//
//  Created by admin on 03/10/24.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var punchlinelbl: UILabel!
    @IBOutlet weak var setuplbl: UILabel!
    @IBOutlet weak var typelbl: UILabel!
    @IBOutlet weak var idlbl: UILabel!
    
    var id : Int!
    var type : String!
    var setUp : String!
    var punchline : String!
    var JokeTapped : JokeModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        idlbl.text = String(JokeTapped.id)
        typelbl.text = JokeTapped.type
        setuplbl.text = JokeTapped.setup
        punchlinelbl.text = JokeTapped.punchline
    }
    

  

}
