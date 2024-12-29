//
//  ViewController.swift
//  CollectionView_Learn
//
//  Created by admin on 26/09/24.
//

import UIKit

class ViewController: UIViewController {
    
    let cellSize : CGFloat = 50
    var w: Double!
    var h: Double!

    @IBOutlet weak var collectView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        w = view.frame.size.width
        h = view.frame.size.height
        setup()
        
    }
}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func setup(){
        collectView.delegate = self
        collectView.dataSource = self
        collectView.register(UINib(nibName: "CollectUI", bundle: nil), forCellWithReuseIdentifier:"CollectUI")
    }
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectView.dequeueReusableCell(withReuseIdentifier: "CollectUI", for: indexPath) as! CollectUI
        cell.collectlbl.text = "asdfghj"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: w / 3, height: cellSize)
    }
}
