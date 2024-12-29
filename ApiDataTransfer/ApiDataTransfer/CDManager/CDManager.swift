//
//  CDManager.swift
//  Demo
//
//  Created by Saloni Pathak Behrens Bokelmann on 21/12/24.
//

import UIKit
import CoreData

class CDManager {
    
    func addToCD(joke: JokeModel) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context = delegate.persistentContainer.viewContext
        
        guard let JokeEntity = NSEntityDescription.entity(forEntityName: "Jokes", in: context) else {return}
        
        let myJoke = NSManagedObject(entity: JokeEntity, insertInto: context)
        
        myJoke.setValue(joke.id, forKey: "id")
        myJoke.setValue(joke.setup, forKey: "setup")
        myJoke.setValue(joke.punchline, forKey: "punchline")
        myJoke.setValue(joke.type, forKey: "type")
        
        do {
            try context.save()
            debugPrint("Data Save Successfully")
        } catch let err as NSError {
            debugPrint(err)
        }
    }
    
    func fetchFromCD() -> [JokeModel] {
        var jokeCoreData : [JokeModel] = []
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return []}
        
        let context = delegate.persistentContainer.viewContext
        
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Jokes")
        
        do {
            let response = try context.fetch(fetchData)
            
            for data in response as! [NSManagedObject] {
                let id = data.value(forKey: "id") as! Int32
                let punchline = data.value(forKey: "punchline") as! String
                let setup = data.value(forKey: "setup") as! String
                let type = data.value(forKey: "type") as! String
                
                jokeCoreData.append(JokeModel(id: id, type: type, punchline: punchline, setup: setup))
            }
            
        } catch let err as NSError {
            debugPrint(err)
        }
        
        return jokeCoreData
    }
    
    func deleteFromCD(id: Int32) {
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context = delegate.persistentContainer.viewContext
        
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Jokes")
        
        fetchData.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let response = try context.fetch(fetchData)
            
            if let objToDelete = response.first{
                context.delete(objToDelete as! NSManagedObject)
                try context.save()
                debugPrint("Delete Successfully!")
            }
        } catch let err as NSError {
            print(err)
        }
        
    }
    
    func updateToCD(joke: JokeModel) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context = delegate.persistentContainer.viewContext
        
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Jokes")
        
        fetchData.predicate = NSPredicate(format: "id == %d", joke.id)
        
        do {
            let response = try context.fetch(fetchData)
            
            let object = response[0] as! NSManagedObject
            object.setValue(joke.punchline, forKey: "puncline")
            object.setValue(joke.setup, forKey: "setup")
            object.setValue(joke.type, forKey: "type")
            
            try context.save()
            debugPrint("Joke Data Update Successfully!")
        } catch let err as NSError {
            print(err)
        }
    }
    
}
