//
//  ViewController.swift
//  Weather_App
//
//  Created by admin on 09/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var navigatebtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func fetchPressedBtn(_ sender: Any) {
        
        performSegue(withIdentifier: "NavigateToDetail", sender: self)
    }
    
    
    
}

