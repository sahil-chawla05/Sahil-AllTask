//
//  ShowDetailsVC.swift
//  FormDataTask
//
//  Created by admin on 26/11/24.
//

import UIKit
import CoreData

class ShowDetailsVC: UIViewController {

    @IBOutlet weak var dataTblView: UITableView!
    var formArr : [FormDataModal] = []
    
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FetchData()
        setUp()

       
    }
    

    func FetchData(){
        let delegate = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "FormData")
        do{
            
            let response = try delegate.fetch(fetchData)
            debugPrint("Fetch Done...")
            for data in response as! [NSManagedObject]{
                self.formArr.append(FormDataModal(id: Int(data.value(forKey: "id") as! Int32), 
                                                  name: data.value(forKey: "name") as! String,
                                                  email: data.value(forKey: "email") as! String,
                                                  phone: Int(data.value(forKey: "phone") as! Int32),
                                                  stream: data.value(forKey: "stream") as! String))
                
            }
//            self.formArr = response
            DispatchQueue.main.async {
                self.dataTblView.reloadData()
            }

        }catch{
            
            debugPrint("Fetch Failed...")
        }
       
    }

}

extension ShowDetailsVC : UITableViewDelegate,UITableViewDataSource{
    
    func setUp(){
        dataTblView.delegate = self
        dataTblView.dataSource = self
        dataTblView.register(UINib(nibName: "FormDataCell", bundle: nil), forCellReuseIdentifier: "FormDataCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dataTblView.dequeueReusableCell(withIdentifier: "FormDataCell", for: indexPath) as! FormDataCell
        let idData = formArr[indexPath.row].id
        let name = formArr[indexPath.row].name
        let email = formArr[indexPath.row].email
        let phoneData = formArr[indexPath.row].phone
        let stream = formArr[indexPath.row].stream
        
        cell.idLbl.text = "\(idData)"
        cell.nameLbl.text = name
        cell.emailLbl.text = email
        cell.phoneLbl.text = "\(phoneData)"
        cell.streamLbl.text = stream
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func CoreDataDelete(data : FormDataModal){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "FormData")
        debugPrint("\(fetchData) =====  \(data.id)")
        
        let idDel = Int(data.id)
        
        fetchData.predicate = NSPredicate(format: "id == %d", idDel)
        
        do{
            
            let getdata = try context.fetch(fetchData)
            
            guard let del = getdata.first else {
                debugPrint("Delete Done..")
                return
            }
            
            context.delete(del as! NSManagedObject)
            try context.save()
            
        }catch{
            debugPrint("Failed Deleted...")
        }
    }
    
   
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete  = UIContextualAction(style: .normal, title:"Delete") { _, _,  complete in
            
            let ObjectData = self.formArr[indexPath.row]
            self.CoreDataDelete(data: ObjectData)
            
            self.formArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with:.automatic)
            complete(true)
                
            }
        delete.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [delete])
    }
   
   
}
