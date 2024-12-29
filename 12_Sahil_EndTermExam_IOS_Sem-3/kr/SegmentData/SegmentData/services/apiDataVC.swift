//
//  apiDataVC.swift
//  SegmentData
//
//  Created by admin on 03/12/24.
//

import UIKit

class apiDataVC: UIViewController {
    
    
    @IBOutlet weak var apiTblData: UITableView!
    var jokeArr : [JokeModal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
setUp()
       
    }




}

extension apiDataVC : UITableViewDelegate,UITableViewDataSource{
    
    func setUp(){
        apiTblData.dataSource = self
        apiTblData.delegate = self
        apiTblData.register(UINib(nibName: "apiDatacell", bundle: nil), forCellReuseIdentifier: "apiDatacell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = apiTblData.dequeueReusableCell(withIdentifier: "apiDataCell", for: indexPath) as! apiDataCell
        cell.setupLbl.text = "Hey....!!!!"
        return cell
    }
    
    
}
