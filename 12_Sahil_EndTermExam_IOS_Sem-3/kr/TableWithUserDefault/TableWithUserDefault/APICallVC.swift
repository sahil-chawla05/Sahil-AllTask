//
//  APICallVC.swift
//  TableWithUserDefault
//
//  Created by admin on 03/10/24.
//

import UIKit

class APICallVC: UIViewController {

    @IBOutlet weak var JokeTbl: UITableView!
    @IBOutlet weak var UserDefaultLbl: UILabel!
    var JokeArr : [JokeModel] = []
    var joketape : JokeModel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        APICall().fetchData { [self] res in
            switch res {
            case .success(let data):
                self.JokeArr.append(contentsOf: data)
                JokeTbl.reloadData()
            case .failure(let err):
                debugPrint(err)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        let userdata = UserDefaults.standard.string(forKey: "TableWithUser")
        UserDefaultLbl.text = userdata!
    }
}


extension APICallVC : UITableViewDelegate,UITableViewDataSource{
    
    
    func setUp(){
        JokeTbl.dataSource = self
        JokeTbl.delegate = self
        JokeTbl.register(UINib(nibName: "JokeCell", bundle: nil), forCellReuseIdentifier: "JokeCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JokeArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = JokeTbl.dequeueReusableCell(withIdentifier: "JokeCell", for: indexPath) as! JokeCell
        cell.jokelbl.text = JokeArr[indexPath.row].setup
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        joketape = JokeArr[indexPath.row]
        performSegue(withIdentifier: "JokeSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailsVC
        detailVC.JokeTapped =  joketape
        
    }
}
