//
//  ViewController.swift
//  PersistantData
//
//  Created by admin on 03/10/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userTxt: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
      
    }


    @IBAction func nextBtn(_ sender: Any) {
       
        UserDefaults.standard.set(userTxt.text!, forKey: "UserText")
        performSegue(withIdentifier: "NextNav", sender: self)
    }
    
   
}

