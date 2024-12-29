//
//  ViewController.swift
//  Demo
//
//  Created by Saloni Pathak Behrens Bokelmann on 21/12/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var MySegmentController: UISegmentedControl!
    
    @IBOutlet weak var MyTable1: UITableView!
    @IBOutlet weak var MyTable2: UITableView!
    
    var joke: JokeModel! // For adding, deleting, updating
    var jokes: [JokeModel] = [] // For API
    var jokeCoreData : [JokeModel] = [] // For CoreData
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        callTable()
        callJokeApi()
        jokeCoreData = CDManager().fetchFromCD()
        
        MyTable1.isHidden = false
        MyTable2.isHidden = true
        MyTable1.reloadData()
    }

    func callJokeApi() {
        ApiService().callJokeApi {
            res in switch res {
                case .success(let data) :
                    DispatchQueue.main.async {
                        self.jokes.append(contentsOf: data)
                        self.MyTable1.reloadData()
                    }
                case .failure(let error) :
                    debugPrint(error)
            }
            
        }
    }
    
    @IBAction func MySegmentActionController(_ sender: Any) {
        switch MySegmentController.selectedSegmentIndex {
            case 0:
                MyTable1.isHidden = false
                MyTable2.isHidden = true
                MyTable1.reloadData()
            case 1:
                MyTable1.isHidden = true
                MyTable2.isHidden = false
                jokeCoreData.removeAll()
                jokeCoreData = CDManager().fetchFromCD()
                MyTable2.reloadData()
            default:
                MyTable1.isHidden = false
                MyTable2.isHidden = true
                MyTable1.reloadData()
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func callTable() {
        MyTable1.delegate = self
        MyTable1.dataSource = self
        MyTable2.delegate = self
        MyTable2.dataSource = self
        
        MyTable1.register(UINib(nibName: "TableOneCell", bundle: nil), forCellReuseIdentifier: "TableOneCell")
        MyTable2.register(UINib(nibName: "TableTwoCell", bundle: nil), forCellReuseIdentifier: "TableTwoCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let selectedIndex = MySegmentController.selectedSegmentIndex
        return selectedIndex == 0 ? jokes.count : jokeCoreData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedIndex = MySegmentController.selectedSegmentIndex
        
        let cellOne = MyTable1.dequeueReusableCell(withIdentifier: "TableOneCell", for: indexPath) as! TableOneCell
        let cellTwo = MyTable2.dequeueReusableCell(withIdentifier: "TableTwoCell", for: indexPath) as! TableTwoCell
        
        if tableView == MyTable1 {
            cellOne.punchline.text = jokes[indexPath.row].punchline
            cellOne.type.text = jokes[indexPath.row].type
        } else {
            cellTwo.punchline.text = jokeCoreData[indexPath.row].punchline
            cellTwo.type.text = jokeCoreData[indexPath.row].type
            cellTwo.setup.text = jokeCoreData[indexPath.row].setup
        }
        
        return selectedIndex == 0 ? cellOne : cellTwo
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == MyTable1 {
            joke = jokes[indexPath.row]
            CDManager().addToCD(joke: joke)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            if(tableView == MyTable1) {
                jokes.remove(at: indexPath.row)
                MyTable1.reloadData()
            } else if (tableView == MyTable2){
                let id = jokeCoreData[indexPath.row].id as Int32
                CDManager().deleteFromCD(id: id)
                jokeCoreData.removeAll()
                jokeCoreData = CDManager().fetchFromCD()
                MyTable2.reloadData()
            }
        }
    }
}
