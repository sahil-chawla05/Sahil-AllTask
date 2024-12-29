//
//  ViewController.swift
//  SegmentWithApi
//
//  Created by Hiren Masaliya on 03/12/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var SegmentView: UISegmentedControl!
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var tableView1: UITableView!
    
    var jokes : [JokeModel] = []
    var joke : JokeModel!
    var jokeCoreData : [JokeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        setUpTableView()
        fetchData()
        fetchCoreData()
       
        SegmentView.selectedSegmentIndex = 0
        tableView2.isHidden = true
        tableView1.isHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        jokeCoreData.removeAll()
        fetchCoreData()
        tableView2.reloadData()
    }
    
    
    
    
    @IBAction func SegmentTab(_ sender: Any) {
        switch SegmentView.selectedSegmentIndex {
        case 0:
            tableView1.isHidden = false
            tableView2.isHidden = true
            
        case 1:
            tableView1.isHidden = true
            tableView2.isHidden = false
            jokeCoreData.removeAll()
            fetchCoreData()
            tableView2.reloadData()
        
        default:
            tableView2.isHidden = true
        }
    }
    
    func fetchData(){
        ApiCall().JokeApi { res in
            switch res {
            case .success(let data):
                DispatchQueue.main.async {
                    self.jokes.append(contentsOf: data)
                    self.tableView1.reloadData()
                }
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    

}


extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func setUpTableView(){
        tableView1.delegate = self
        tableView1.dataSource = self
        tableView1.register(UINib(nibName: "TVCell", bundle: nil), forCellReuseIdentifier: "TVCell")
        
        tableView2.delegate = self
        tableView2.dataSource = self
        tableView2.register(UINib(nibName: "TVCell", bundle: nil), forCellReuseIdentifier: "TVCell")
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        
        if tableView == tableView1{
            count = jokes.count
        }else if tableView == tableView2{
            count = jokeCoreData.count
        }
        
        return count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVCell", for: indexPath) as! TVCell

        if tableView == tableView1{
            
            cell.lblSetup.text = jokes[indexPath.row].setup
            cell.lblPunchline.text = jokes[indexPath.row].punchline
            
        }else if tableView == tableView2{
           
            cell.lblSetup.text = jokeCoreData[indexPath.row].setup
            cell.lblPunchline.text = jokeCoreData[indexPath.row].punchline
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableView1 {
            joke = jokes[indexPath.row]
            CoreDataSave(jokeObject: joke)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == tableView2{
            let Delete = UIContextualAction.init(style: .normal, title: "Delete") { (action, view, nil) in
                let id = self.jokeCoreData[indexPath.row].id
                self.DeleteCoreData(id: id)
                self.removeInArray(index: indexPath)
            }
            
            Delete.backgroundColor = UIColor.red

            let config = UISwipeActionsConfiguration.init(actions: [Delete])
            config.performsFirstActionWithFullSwipe = false

            tableView.reloadRows(at: [indexPath], with: .none)
            return config
        }else if tableView == tableView1{
            let Save = UIContextualAction.init(style: .normal, title: "Save") { (action, view, nil) in
                self.joke = self.jokes[indexPath.row]
                self.CoreDataSave(jokeObject: self.joke)
            }
            
            Save.backgroundColor = UIColor.orange

            let config = UISwipeActionsConfiguration.init(actions: [Save])
            config.performsFirstActionWithFullSwipe = false

            tableView.reloadRows(at: [indexPath], with: .none)
            return config
        }
        
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if tableView == tableView2{
            let update = UIContextualAction.init(style: .normal, title: "Update") { (action, view, nil) in
                self.joke = self.jokeCoreData[indexPath.row]
                self.performSegue(withIdentifier: "FormVC", sender: self)
            }
            
            update.backgroundColor = UIColor.orange

            let config = UISwipeActionsConfiguration.init(actions: [update])
            config.performsFirstActionWithFullSwipe = false

            tableView.reloadRows(at: [indexPath], with: .none)
            return config
        }
        
        
        return nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FormVC"{
            if let data = segue.destination as? FormVC{
                data.joke = joke
            }
        }
    }
    
    
    func CoreDataSave(jokeObject:JokeModel){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else{return}
        
        let managedContext = delegate.persistentContainer.viewContext
        
        guard let JokeEntity = NSEntityDescription.entity(forEntityName: "Jokes", in: managedContext) else{return}
        
        let joke = NSManagedObject(entity: JokeEntity, insertInto: managedContext)
        
        joke.setValue(jokeObject.id, forKey: "id")
        joke.setValue(jokeObject.setup, forKey: "setup")
        joke.setValue(jokeObject.punchline, forKey: "punchline")
        joke.setValue(jokeObject.type, forKey: "type")
        
        do {
            try managedContext.save()
            debugPrint("Data Save Successfully")
        } catch let err as NSError{
            debugPrint("Could not save to CoreData .Error \(err)")
        }
        
                
    }
    
    func fetchCoreData(){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else{return}
        
        let manageContext = delegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Jokes")
        
        do {
            let res = try manageContext.fetch(fetchRequest)
            
            for data in res as! [NSManagedObject]{
                let id = data.value(forKey: "id") as! Int32
                let type = data.value(forKey: "type") as! String
                let setup = data.value(forKey: "setup") as! String
                let punchline = data.value(forKey: "punchline") as! String
                
                jokeCoreData.append(JokeModel(id: id, type: type, setup: setup, punchline: punchline))
            }
        } catch let err as NSError {
            print(err)
        }
    }
    
    func DeleteCoreData(id:Int32){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else{return}
        
        let manageContex = delegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Jokes")
        
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let res = try manageContex.fetch(fetchRequest)
            
            if let objectToDelete = res.first{
                manageContex.delete(objectToDelete as! NSManagedObject)
                try manageContex.save()
                debugPrint("Record is Delete")
            }
        } catch let err as NSError {
            print(err)
        }
        
        
    }
    
    func removeInArray(index: IndexPath){
        jokeCoreData.remove(at: index.row)
        DispatchQueue.main.async {
            self.tableView2.reloadData()
        }
    }
    
    
}

