//
//  BookFormVC.swift
//  SegmentData
//
//  Created by admin on 03/12/24.
//
    
import UIKit
import CoreData

class BookFormVC: UIViewController {
    
    
    @IBOutlet weak var booknameTxt: UITextField!
    @IBOutlet weak var bookPageTxt: UITextField!
    @IBOutlet weak var bookISBNtxt: UITextField!
    @IBOutlet weak var bookauthorTxt: UITextField!
    @IBOutlet weak var bookCoverImg: UIImageView!
    
    var bName : String!
    var bAuthorName : String!
    var bISBN : Int?
    var bPageNum : Int?
    var checkBool : Bool!
    var retrivedData : BookModal!
    
    @IBOutlet weak var submitBookBtn: UIButton!
    @IBOutlet weak var updateBookBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        
        if(checkBool == true){
            addData()
        }else if (checkBool == false){
            setforUpdate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(checkBool == true){
            addData()
        }else if (checkBool == false){
            setforUpdate()
        }
    }
    
    
    func setforUpdate(){
        updateBookBtn.isHidden = false
        submitBookBtn.isHidden = true
        booknameTxt.text = retrivedData.bookname
        bookauthorTxt.text = retrivedData.bookauthor
        bookISBNtxt.text = "\(retrivedData.bookisbn)"
        bookPageTxt.text = "\(retrivedData.bookpage)"
    }
    
    func addData(){
        updateBookBtn.isHidden = true
        submitBookBtn.isHidden = false
        bName = self.booknameTxt.text
        bAuthorName = self.bookauthorTxt.text
        bISBN = Int(bookISBNtxt.text!)
        bPageNum = Int(bookPageTxt.text!)
    }
    
    @IBAction func updateBtn(_ sender: Any) {
        submitBookBtn.isHidden = true
        updateBookBtn.isHidden = false
        
        let updateBName = booknameTxt.text
        let updateBAuthorName = bookauthorTxt.text
        let updateBISBN = Int(bookISBNtxt.text!)
        let updateBPageNum = Int(bookPageTxt.text!)
        
        updateCoreData(atName: retrivedData.bookname, bookModalObj: BookModal(bookname: updateBName! ,
                                                                              bookauthor: updateBAuthorName!,
                                                                              bookisbn: updateBISBN!,
                                                                              bookpage: updateBPageNum!))
    }
    
    
    @IBAction func submitBtn(_ sender: Any) {
        addData()
        insertData(bookObj: BookModal(bookname: bName ,
                                      bookauthor: bAuthorName,
                                      bookisbn: bISBN!,
                                      bookpage: bPageNum!))
    }
   
    
    func insertData(bookObj : BookModal){
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = delegate.persistentContainer.viewContext
        guard let insertEntity = NSEntityDescription.entity(forEntityName: "Books", in: managedContext) else { return }
                
        let books = NSManagedObject(entity: insertEntity, insertInto: managedContext)
        
        books.setValue(bookObj.bookname, forKey: "bookname")
        books.setValue(bookObj.bookauthor, forKey: "bookauthor")
        books.setValue(bookObj.bookisbn, forKey: "bookisbn")
        books.setValue(bookObj.bookpage, forKey: "bookpage")
        
        do{
            try managedContext.save()
            debugPrint("Save Successfully...")
            
        }  catch let err as NSError{
            debugPrint("Error...\(err)")
        }
    }
    
    
    
    func updateCoreData(atName : String,bookModalObj : BookModal){
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else{return}
        let managedContext = delegate.persistentContainer.viewContext
        
        let fetchDataB = NSFetchRequest<NSFetchRequestResult>(entityName: "Books")
        
        fetchDataB.predicate = NSPredicate(format: "bookname = %@",atName)
        
        do{
            let rawData = try managedContext.fetch(fetchDataB)
            
            let objUpdate = rawData[0] as! NSManagedObject
            objUpdate.setValue(bookModalObj.bookname, forKey: "bookname")
            objUpdate.setValue(bookModalObj.bookauthor, forKey: "bookauthor")
            objUpdate.setValue(bookModalObj.bookisbn, forKey: "bookisbn")
            objUpdate.setValue(bookModalObj.bookpage, forKey: "bookpage")
            
            try managedContext.save()
            
        }catch{
            print("Updating Failed...")
        }
    }
    
}


