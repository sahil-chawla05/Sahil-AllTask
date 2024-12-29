//
//  ViewController.swift
//  FormDataTask
//
//  Created by admin on 26/11/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    

    @IBOutlet weak var idTxt: UITextField!
    @IBOutlet weak var streamTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var showData: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
    
    
    func SubmitData(formData : FormDataModal){
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = delegate.persistentContainer.viewContext
        
        guard let addEntity = NSEntityDescription.entity(forEntityName: "FormData", in: managedContext) else { return }
        
        let data = NSManagedObject(entity: addEntity, insertInto: managedContext)
        
        data.setValue(formData.id, forKey: "id")
        data.setValue(formData.name, forKey: "name")
        data.setValue(formData.email, forKey: "email")
        data.setValue(formData.phone, forKey: "phone")
        data.setValue(formData.stream, forKey: "stream")
        
        
        do{
            try managedContext.save()
            debugPrint("Save Successfully...")
        }catch{
            debugPrint("Error...")
        }
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        
        let idtext = self.idTxt.text!
        let idInt = Int(idtext) ?? 0
        let nameText = self.nameTxt.text!
        let emailText = self.emailTxt.text!
        let phoneText = self.phoneTxt.text!
        let phoneInt = Int(phoneText) ?? 0
        let streamText = self.streamTxt.text!
        
        SubmitData(formData: FormDataModal(id: idInt, name: nameText , email: emailText, phone: phoneInt, stream: streamText))
       
    }
    
    @IBAction func showDetailsBtn(_ sender: Any) {
        performSegue(withIdentifier: "showdDataSegue", sender: self) as? ShowDetailsVC
    }
    

}

