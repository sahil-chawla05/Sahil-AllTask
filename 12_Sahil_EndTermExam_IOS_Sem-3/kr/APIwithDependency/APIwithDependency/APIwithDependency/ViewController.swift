//
//  ViewController.swift
//  APIwithDependency
//
//  Created by admin on 19/09/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loadingindicator: UIActivityIndicatorView!
    @IBOutlet weak var joketable: UITableView!
    var jokearr : [JokeModel] = []
    var tappedJoke: JokeModel!
    
   
    

    override func viewWillAppear(_ animated: Bool) {
        self.loadingindicator.startAnimating()
        APIClass().callJokesAPI { result in
            switch result {
                case .success(let data):
              
                    self.jokearr.append(contentsOf: data)
                    self.joketable.reloadData()
                    self.loadingindicator.stopAnimating()
                    self.loadingindicator.isHidden = true
                
                case .failure(let error):
                   
                    debugPrint("err:\(error)")
            }
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func setup(){
        joketable.delegate = self
        joketable.dataSource = self
        joketable.register(UINib(nibName: "JokeCell", bundle: nil), forCellReuseIdentifier: "JokeCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokearr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = joketable.dequeueReusableCell(withIdentifier: "JokeCell", for: indexPath) as! JokeCell
        cell.jokeLbl.text = jokearr[indexPath.row].punchline
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let delete = UIContextualAction(style:.normal,title: "Delete"){ _,_,complete in
            self.jokearr.remove(at: indexPath.row)
            self.joketable.deleteRows(at: [indexPath], with: .automatic)
            complete(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
        {
            let deleteAction = UIContextualAction(style: .destructive, title: "Add") { (action, view, handler) in
                print("Add Action Tapped")
            }
            deleteAction.backgroundColor = .black
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
        }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tappedJoke = jokearr[indexPath.row]
        performSegue(withIdentifier: "JokeSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailsVC
        detailVC.joketapped =  tappedJoke
        
    }
}



