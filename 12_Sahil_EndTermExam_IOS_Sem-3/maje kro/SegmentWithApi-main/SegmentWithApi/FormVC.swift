//
//  FormVC.swift
//  SegmentWithApi
//
//  Created by Hiren Masaliya on 03/12/24.
//

import UIKit
import CoreData

class FormVC: UIViewController {

   
    @IBOutlet weak var txtPunchline: UITextField!
    @IBOutlet weak var txtSetup: UITextField!
    @IBOutlet weak var txtId: UITextField!
    @IBOutlet weak var txtType: UITextField!
    
    var joke : JokeModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if((joke) != nil){
            txtId.text = String(joke.id)
            txtType.text = joke.type
            txtSetup.text = joke.setup
            txtPunchline.text = joke.punchline
            
            navigationItem.title = "Update Joke"
        }else{
            navigationItem.title = "Add Joke"
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func btnSave(_ sender: Any) {
        
        if((joke) == nil){
            let id = Int32(txtId.text!)!
            let type = txtType.text!
            let setup = txtSetup.text!
            let punchline = txtPunchline.text!
            
            CoreDataSave(jokeObject: JokeModel(id: id, type: type, setup: setup, punchline: punchline))
            
        }else{
            let id = Int32(txtId.text!)!
            let type = txtType.text!
            let setup = txtSetup.text!
            let punchline = txtPunchline.text!
            updateData(jokeModel: JokeModel(id: id, type: type, setup: setup, punchline: punchline))
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
            
            txtId.text = ""
            txtType.text = ""
            txtSetup.text = ""
            txtPunchline.text = ""
            navigationController?.popViewController(animated: true)
            
        } catch let err as NSError{
            debugPrint("Could not save to CoreData .Error \(err)")
        }
                   
    }
    
    func updateData(jokeModel : JokeModel){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else{return}
        
        let managedContext = delegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Jokes")
        
        fetchRequest.predicate = NSPredicate(format: "id == %d", jokeModel.id)
        
        do {
            let res = try managedContext.fetch(fetchRequest)
            
            
            let object = res[0] as! NSManagedObject
            object.setValue(jokeModel.type, forKey: "type")
            object.setValue(jokeModel.setup, forKey: "setup")
            object.setValue(jokeModel.punchline, forKey: "punchline")
            
            try managedContext.save()
            debugPrint("Joke Data Update Successfully!")
            navigationController?.popViewController(animated: true)
        } catch let err as NSError {
            print(err)
        }
    }
    
}





































