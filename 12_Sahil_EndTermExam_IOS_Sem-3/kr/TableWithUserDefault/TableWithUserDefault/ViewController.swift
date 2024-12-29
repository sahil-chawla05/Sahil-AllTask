//
//  ViewController.swift
//  TableWithUserDefault
//
//  Created by admin on 03/10/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var APICallbtn: UIButton!
    @IBOutlet weak var txtUser: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func APICallbtn(_ sender: Any) {
        UserDefaults.standard.set(txtUser.text!, forKey: "TableWithUser")
        performSegue(withIdentifier: "CallSegue", sender: self)
    }
    
}

