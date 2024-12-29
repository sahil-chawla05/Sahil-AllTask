//
//  NextVC.swift
//  PersistantData
//
//  Created by admin on 03/10/24.
//

import UIKit

class NextVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userdata = UserDefaults.standard.string(forKey: "UserText")
        navigationItem.title = "Hello \(userdata!)"
    }
    

   

}
