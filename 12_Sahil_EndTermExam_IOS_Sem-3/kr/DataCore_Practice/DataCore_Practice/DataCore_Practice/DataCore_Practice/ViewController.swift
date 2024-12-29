//
//  ViewController.swift
//  DataCore_Practice
//
//  Created by admin on 19/11/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var saveJokeBtn: UIButton!
    @IBOutlet weak var tblViewData: UITableView!
    var jokeArr : [JokeModal] = []
    
    @IBAction func btnSaveJoke(_ sender: Any) {
        performSegue(withIdentifier: "showJokeNav", sender: self) as! SaveJokesVC
    }
     
    override func viewWillAppear(_ animated: Bool) {
        apiCallService().apiCall { result in
            switch result {
            case .success(let data):
                self.jokeArr.append(contentsOf: data)
                self.tblViewData.reloadData()
            case .failure(let err):
                debugPrint("error :: \(err)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
     func CoreDataFunc(jokeObject : JokeModal){
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
         
        let managedContext = delegate.persistentContainer.viewContext
         
        guard let jokeEntity = NSEntityDescription.entity(forEntityName: "Jokes", in: managedContext) else { return }
        
        let joke = NSManagedObject(entity: jokeEntity, insertInto: managedContext)
        
        joke.setValue(jokeObject.id, forKey: "id")
        joke.setValue(jokeObject.type, forKey: "type")
        joke.setValue(jokeObject.setup, forKey: "setup")
        joke.setValue(jokeObject.punchline, forKey: "punchline")
        
        do{
            try managedContext.save()
            debugPrint("Save Successfully...")
            
        }  catch let err as NSError{
            debugPrint("Error...\(err)")
        }
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func setUp(){
        tblViewData.delegate = self
        tblViewData.dataSource = self
        tblViewData.register(UINib(nibName: "DataCell", bundle: nil), forCellReuseIdentifier: "tblDataCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokeArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblViewData.dequeueReusableCell(withIdentifier: "tblDataCell", for: indexPath) as! DataCell
        cell.lblDataJoke.text = jokeArr[indexPath.row].setup
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let jokes = jokeArr[indexPath.row]
        CoreDataFunc(jokeObject: jokes)
    
    }
}
