# SegmentWithApi - iOS App

This iOS app demonstrates a segmented control UI that switches between displaying jokes fetched from an API and displaying jokes saved in Core Data. The app provides functionality for saving, updating, and deleting jokes from Core Data, as well as fetching jokes from an API.

# Features
- **Segmented Control:** Switches between displaying jokes fetched from an API and jokes stored in Core Data.
- **API Fetching:** Jokes are fetched from a remote API and displayed in a table view.
- **Core Data Integration:** Save, update, and delete jokes using Core Data.
- **UITableView:** Displays jokes in two different table views based on the selected segment.

# Requirements
- Xcode 12.0 or later
- iOS 13.0 or later
- Swift 5.0 or later
- CoreData for persistent data storage

## Installation

**1. Clone the repository:**
```
git clone https://github.com/hirenmasaliya/SegmentWithApi.git
```

**2. Open the project in Xcode:**
```
open SegmentWithApi.xcodeproj
```

**3. Build and run the project on your preferred simulator or real device.**
## Screenshots
**Segmented Control:**

- The first segment displays jokes fetched from the API.
- The second segment displays jokes saved in Core Data.

**Add/Update Joke:**

Users can add new jokes or update existing ones.

# Implementation Details

```ViewController.swift```
- Displays jokes either from the API or from Core Data based on the selected segment.
- **Segmented Control:** Switches between two table views.
- **API Fetching:** Jokes are fetched from a remote API and displayed in the first table view.
- **Core Data Operations:** Fetch, save, and delete jokes from Core Data.
  
```FormVC.swift```
- Handles the form to add or update a joke.
- When the form is loaded, if a joke is provided, it pre-fills the form fields for updating; otherwise, it allows for adding a new joke.


### Core Data Management
- **Saving Jokes:** Jokes are saved into Core Data via CoreDataSave.
- **Fetching Jokes:** Jokes are fetched from Core Data and displayed in the second table view.
- **Deleting Jokes:** Jokes can be deleted from Core Data via swipe-to-delete action in the table view.
- **Updating Jokes:** Jokes can be updated from the second table view by swiping to edit.

### API Fetching
- The app fetches jokes from an API using ```ApiCall().JokeApi```. The data is parsed and displayed in the table view.

### JokeApi
```ruby 
https://official-joke-api.appspot.com/jokes/random/25
```
```ruby
https://official-joke-api.appspot.com/jokes/programming/random
```

## Core Data Entities
- **Entity Name:** Jokes
  - ```Attributes:```
    - ```id:``` Integer (Unique ID for the joke)
    - ```type:``` String (Type of joke)
    - ```setup:``` String (The joke setup)
    - ```punchline:``` String (The punchline)

### JokeModel
```ruby
import Foundation

struct JokeModel : Codable{
    var id : Int32
    var type : String
    var setup : String
    var punchline : String
}
```

## Api

### Api Call
```ruby
import Foundation
import Alamofire

class ApiCall {
    
    func JokeApi(cv:@escaping(Result<[JokeModel],Error>)->Void){
        
        let urlstr = "https://official-joke-api.appspot.com/jokes/random/25"
        
        AF.request(urlstr).responseDecodable(of: [JokeModel].self) { response in
            switch response.result {
            case .success(let data):
                cv(.success(data))
            case .failure(let error):
                cv(.failure(error))
            }
        }
        
    }
}
```

```ruby
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
```

## Core Data Operations

### Save Joke to Core Data

```ruby
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
```

### Fetch Jokes from Core Data
```ruby
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
```

### Delete Joke from Core Data
```ruby
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
```

### Update Joke in Core Data
```ruby
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
```











