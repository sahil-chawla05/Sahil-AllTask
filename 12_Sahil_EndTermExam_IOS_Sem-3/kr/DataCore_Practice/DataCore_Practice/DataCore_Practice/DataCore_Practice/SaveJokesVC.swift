//
//  SaveJokesVC.swift
//  DataCore_Practice
//
//  Created by admin on 21/11/24.
//

import UIKit
import CoreData

class SaveJokesVC: UIViewController {
    
    
    @IBOutlet weak var saveDataTbl: UITableView!
    @IBOutlet weak var jokeSaveLbl: UILabel!
    var jokes : [JokeModal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        readData()
    }
    

    func readData(){
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = delegate.persistentContainer.viewContext
        
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Jokes")
        
        do {
            
            let response = try managedContext.fetch(fetchrequest)
            debugPrint("Fetch data success..")
            
            for data in response as! [NSManagedObject] {
             
                self.jokes.append(JokeModal(id: Int(data.value(forKey: "id") as! Int32),
                                            punchline: data.value(forKey: "type") as! String,
                                            setup: data.value(forKey: "setup") as! String,
                                            type: data.value(forKey: "punchline") as! String))
                
                self.saveDataTbl.reloadData()
                
            }
        }
        catch{
            debugPrint("Error..")
        }
    }
}


extension SaveJokesVC : UITableViewDelegate,UITableViewDataSource{
    
    func setup(){
        saveDataTbl.dataSource = self
        saveDataTbl.delegate = self
        saveDataTbl.register(UINib(nibName: "FetchDataCell", bundle: nil), forCellReuseIdentifier: "FetchDataCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = saveDataTbl.dequeueReusableCell(withIdentifier: "FetchDataCell", for: indexPath) as! FetchDataCell
        let idInt = jokes[indexPath.row].id
        cell.jokeId.text = "\(idInt)"
        cell.jokeType.text = jokes[indexPath.row].type
        cell.jokeSetup.text = jokes[indexPath.row].setup
        cell.jokePunchline.text = jokes[indexPath.row].punchline
        return cell
    }
    
    
}
