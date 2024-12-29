import UIKit

class ViewController: UIViewController {
    
    var jokeArr : [JokeModel] = []
    
    @IBOutlet weak var jokeTable: UITableView!
   
    override func viewWillAppear(_ animated: Bool) {
        apiCall().fetchedData { res in
            
                switch res {
                case .success(let data):
                    self.jokeArr.append(contentsOf: data)
                    self.jokeTable.reloadData()
                case .failure(let error):
                    debugPrint("\(error)")
                }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func setUp(){
        jokeTable.delegate = self
        jokeTable.dataSource = self
        jokeTable.register(UINib(nibName: "JokeCell", bundle: nil), forCellReuseIdentifier: "JokeCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokeArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = jokeTable.dequeueReusableCell(withIdentifier: "JokeCell", for: indexPath) as! JokeCell
        cell.titleLbl.text = jokeArr[indexPath.row].setup
        return cell
    }
    
    
    
}
