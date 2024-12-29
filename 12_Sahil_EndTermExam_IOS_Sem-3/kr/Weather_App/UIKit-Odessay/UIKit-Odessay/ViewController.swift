//
//  ViewController.swift
//  UIKit-Odessay
//
//  Created by admin on 13/08/24.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var colorview: UIView!
    @IBOutlet weak var redslider: UISlider!
    @IBOutlet weak var greenslider: UISlider!
    @IBOutlet weak var blueslider: UISlider!
    @IBOutlet weak var opacityslider: UISlider!
    
    
    var red : CGFloat!
    var green : CGFloat!
    var blue : CGFloat!
    var opacity : CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }



    func changedColor(r : CGFloat, g : CGFloat , b : CGFloat , o : CGFloat){
        colorview.backgroundColor = UIColor(red: r/255, green: g/255, blue: b/255, alpha: opacity)
    }
    
    func setcolor(){
        red  = CGFloat(redslider.value)
        green = CGFloat(greenslider.value)
        blue = CGFloat(blueslider.value)
        opacity = CGFloat(opacityslider.value)
        changedColor(r: red, g: green, b: blue, o: opacity)
    
    }
    
    @IBAction func rslider(_ sender: Any) {
        setcolor()
    }
    
    @IBAction func gslider(_ sender: Any) {
        setcolor()
    }
    
    
    @IBAction func bslider(_ sender: Any) {
        setcolor()
    }
    
    @IBAction func opacitychanged(_ sender: Any) {
        setcolor()
    }
    
}

