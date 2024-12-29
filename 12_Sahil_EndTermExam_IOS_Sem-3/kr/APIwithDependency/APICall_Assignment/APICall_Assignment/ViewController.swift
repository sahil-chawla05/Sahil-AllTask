//
//  ViewController.swift
//  APICall_Assignment
//
//  Created by admin on 26/09/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var dataarr : [DataModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        APICall().dataRequest (completionHandler: { response in
            switch response {
            case .success(let data):
                self.dataarr.append(contentsOf: data)
                self.tblView.reloadData()
            case .failure(let error):
                debugPrint("Error :: \(error)")
            }
        },paramUrl: "programming")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }


}


extension ViewController : UITableViewDelegate,UITableViewDataSource {
    
    func setup(){
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(UINib(nibName: "DataCell", bundle: nil), forCellReuseIdentifier: "DataCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataarr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataCell
        cell.datalabel.text = dataarr[indexPath.row].punchline
        return cell
    }
    
    
    
}
