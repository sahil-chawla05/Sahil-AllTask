//
//  ViewController.swift
//  SegmentData
//
//  Created by admin on 03/12/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
        
    @IBOutlet weak var segmentControl: UISegmentedControl!
 
    @IBOutlet weak var addDataBtn: UIButton!
    @IBOutlet weak var apiTblData: UITableView!
    var oneselectIndex : Int = 1
    var jokeArr : [JokeModal] = []
    var BookData : [BookModal] = []
    var btnBool : Bool!
    var bookname : BookModal!
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
            apiCallService().apiCall { result in
                switch result{
                case .success(let data):
                    self.jokeArr.append(contentsOf: data)
                    self.apiTblData.reloadData()
                    
                case .failure(let error):
                    debugPrint("Error...\(error)")
                }
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        self.BookData = self.readData()
    }

    
    func reloadUI() {
         DispatchQueue.main.async {
             
             if self.oneselectIndex == 1 {
                 self.apiTblData.reloadData()
             } else  {
                 self.BookData = self.readData()
                 self.apiTblData.reloadData()
             }
         }
     }
    
    @IBAction func navigateBtwnTbl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.oneselectIndex = 1
        }
           else {
               self.oneselectIndex = 2
               reloadUI()
           }
        
        self.apiTblData.reloadData()
        

    }
    
    @IBAction func addDataBtn(_ sender: Any) {
        btnBool = true
        performSegue(withIdentifier: "addDataSegue", sender: self)
        
    }
    
 
}


extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func setUp(){
            apiTblData.delegate = self
            apiTblData.dataSource = self
            apiTblData.register(UINib(nibName: "apiDataCell", bundle: nil), forCellReuseIdentifier: "apiDataCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if oneselectIndex == 1 {
            return self.jokeArr.count
        }
        else {
            return self.BookData.count
        }
    }
    
    
    
    
    func readData() -> [BookModal]{
        
        var bookArr: [BookModal] = []
         let delegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = delegate!.persistentContainer.viewContext
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Books")
        
        do {
            
            let response = try managedContext.fetch(fetchrequest)
            debugPrint("Fetch data success..")
            
            for data in response as! [NSManagedObject] {
             
                bookArr.append(BookModal(bookname: data.value(forKey: "bookname") as! String,
                                               bookauthor: data.value(forKey: "bookauthor") as! String,
                                               bookisbn: Int(data.value(forKey: "bookisbn") as! Int32),
                                               bookpage: Int(data.value(forKey: "bookpage") as! Int32)))
                
                self.apiTblData.reloadData()
                
            }
        }
        catch{
            debugPrint("Error..")
        }
        
        return bookArr
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = apiTblData.dequeueReusableCell(withIdentifier: "apiDataCell", for: indexPath) as! apiDataCell

               if oneselectIndex == 1 {
                   cell.setupLbl.text = jokeArr[indexPath.row].setup
               }
               else {
                   
                   cell.setupLbl.text = BookData[indexPath.row].bookname
               }

               return cell
    }
    
    
    func BookDataDelete(data : BookModal){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Books")
        debugPrint("\(fetchData) =====  \(data.bookid)")
        
        fetchData.predicate = NSPredicate(format: "bookname == %@", data.bookname)
        
        do{
            let fetchRes = try context.fetch(fetchData)
            let objToDelete = fetchRes[0] as! NSManagedObject
            context.delete(objToDelete)
                     
            try context.save()
            print("Book deleted successfully")
            
            
        }catch let err as NSError{
            debugPrint("Failed Deleted...\(err)")
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if oneselectIndex == 1 {
            return nil
        }
        else {
            let delete  = UIContextualAction(style: .normal, title:"Delete") { _, _,  complete in
                
                let ObjectData = self.BookData[indexPath.row]
             
                self.BookDataDelete(data: ObjectData)
                
                self.BookData.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with:.automatic)
                DispatchQueue.main.async {
                         self.apiTblData.reloadData()
                     }
                complete(true)
                    
                }
            delete.backgroundColor = .red
            return UISwipeActionsConfiguration(actions: [delete])
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if oneselectIndex == 1 {
            return nil
        }
        else {
            let update  = UIContextualAction(style: .normal, title:"Update") { [self] _, _,  complete in
                btnBool = false
                bookname = self.BookData[indexPath.row]
                performSegue(withIdentifier: "addDataSegue", sender: self)
                
                DispatchQueue.main.async {
                         self.apiTblData.reloadData()
                     }
                complete(true)
                    
                }
            update.backgroundColor = .cyan
            return UISwipeActionsConfiguration(actions: [update])
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addDataSegue"{
            if(btnBool == true){
                if let bookVC = segue.destination as? BookFormVC{
                    debugPrint("UpdateBtn...")
                    bookVC.checkBool = btnBool
                }
            }else{
                if let bookVC = segue.destination as? BookFormVC{
                    debugPrint("UpdateBtn...")
                    bookVC.checkBool = btnBool
                    bookVC.retrivedData = bookname
                }
            }
        }
    }
   
}
