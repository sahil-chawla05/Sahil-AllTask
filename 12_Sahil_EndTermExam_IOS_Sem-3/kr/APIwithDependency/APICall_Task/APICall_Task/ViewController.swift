//
//  ViewController.swift
//  APICall_Task
//
//  Created by admin on 26/09/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentcontrol: UISegmentedControl!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var DatatblView: UITableView!
    var jokeArr : [JokeModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        self.loader.startAnimating()
        APIClass().apiFunc { result in
            switch result{
            case .success(let data):
                self.jokeArr.append(contentsOf: data)
                self.DatatblView.reloadData()
                self.loader.stopAnimating()
                self.loader.isHidden = true
            case .failure(let error):
                debugPrint("Error :: \(error)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }


    @IBAction func switchPage(_ sender: UISegmentedControl) {
        switch segmentcontrol.selectedSegmentIndex
               {
               case 0:
                    self.DatatblView.isHidden = false
                    self.DatatblView.reloadData()
               case 1:
                    self.DatatblView.isHidden = true
               default:
                   break;
               }
    }
}


extension ViewController : UITableViewDelegate,UITableViewDataSource {
    
    func setup(){
        DatatblView.delegate = self
        DatatblView.dataSource = self
        DatatblView.register(UINib(nibName: "JokeCell", bundle: nil), forCellReuseIdentifier: "JokeCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokeArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DatatblView.dequeueReusableCell(withIdentifier: "JokeCell", for: indexPath) as! JokeCell
        cell.jokeLabel.text = jokeArr[indexPath.row].punchline
        return cell
    }
    
    
    
}
