//
//  coreDataVC.swift
//  SegmentData
//
//  Created by admin on 03/12/24.
//

import UIKit

class coreDataVC: UIViewController {

    @IBOutlet weak var coreDataTbl: UITableView!
    var jokeArr : [JokeModal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

            setUp()
    }


}



extension coreDataVC : UITableViewDelegate,UITableViewDataSource{
    
    func setUp(){
        coreDataTbl.dataSource = self
        coreDataTbl.delegate = self
        coreDataTbl.register(UINib(nibName: "apiDatacell", bundle: nil), forCellReuseIdentifier: "apiDatacell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = coreDataTbl.dequeueReusableCell(withIdentifier: "apiDataCell", for: indexPath) as! apiDataCell
        cell.setupLbl.text = "Hello...!!!!"
        return cell
    }
    
    
}
