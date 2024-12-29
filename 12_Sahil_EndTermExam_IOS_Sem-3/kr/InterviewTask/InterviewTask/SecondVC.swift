//
//  SecondVC.swift
//  InterviewTask
//
//  Created by admin on 30/11/24.
//

import UIKit

class SecondVC: UIViewController {
    
    @IBOutlet weak var welcome: UILabel!
    
    @IBOutlet weak var notelbl: UILabel!
    @IBOutlet weak var notice: UILabel!
    @IBOutlet weak var createone: UIButton!
    @IBOutlet weak var dont: UILabel!
    @IBOutlet weak var champ: UILabel!
    @IBOutlet weak var otpNumber: UITextField!
    @IBOutlet weak var noteLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
                   .foregroundColor: UIColor.gray,
               ]
        
        otpNumber.attributedPlaceholder = NSAttributedString(string: otpNumber.placeholder ?? "Enter OTP", attributes: placeholderAttributes)
        let otpNumberleft = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 40))
        otpNumber.leftView = otpNumberleft
        otpNumber.leftViewMode = .always
    }
    
    
    
    
   
}
