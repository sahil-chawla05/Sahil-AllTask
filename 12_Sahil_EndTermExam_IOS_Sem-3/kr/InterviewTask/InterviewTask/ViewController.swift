//
//  ViewController.swift
//  InterviewTask
//
//  Created by admin on 28/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailAddTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var btnsignin: UIButton!
    @IBOutlet weak var create: UILabel!
    
    @IBOutlet weak var alredy: UILabel!
    @IBOutlet weak var btnCreate: UIButton!
    
    @IBOutlet weak var account: UILabel!
    
    @IBOutlet weak var phonenum: UITextField!
    override func viewWillAppear(_ animated: Bool) {
       
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTxt.borderStyle = .none
        nameTxt.layer.borderColor = UIColor.green.cgColor
        nameTxt.layer.borderWidth = 1
        
        let nameleft = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 40))
        nameTxt.leftView = nameleft
        nameTxt.leftViewMode = .always
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
                   .foregroundColor: UIColor.gray,
               ]
               
               emailAddTxt.attributedPlaceholder = NSAttributedString(string: emailAddTxt.placeholder ?? "Email Address", attributes: placeholderAttributes)
      
       
        let emailleft = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 40))
        emailAddTxt.leftView = emailleft
        emailAddTxt.leftViewMode = .always
        
        phonenum.attributedPlaceholder = NSAttributedString(string: phonenum.placeholder ?? "Phone Number", attributes: placeholderAttributes)
        let phoneleft = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 40))
        phonenum.leftView = phoneleft
        phonenum.leftViewMode = .always
        
        
        guard let customFont = UIFont(name: "KronaOne-Regular", size: 10) else {
            fatalError("""
                Failed to load the "CustomFont-Light" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        
     
        create.font = UIFontMetrics.default.scaledFont(for: customFont)
        create.adjustsFontForContentSizeCategory = true
        
        account.font = UIFontMetrics.default.scaledFont(for: customFont)
        account.adjustsFontForContentSizeCategory = true
        
        alredy.font = UIFontMetrics.default.scaledFont(for: customFont)
        alredy.adjustsFontForContentSizeCategory = true
        
        
        
        guard let headerFont = UIFont(name: "KronaOne-Regular", size: UIFont.labelFontSize) else {
            fatalError("""
                Failed to load the "CustomFont-Light" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        
     
        create.font = UIFontMetrics.default.scaledFont(for: headerFont)
        create.adjustsFontForContentSizeCategory = true
        account.font = UIFontMetrics.default.scaledFont(for: headerFont)
        account.adjustsFontForContentSizeCategory = true
        
        
    
    }


}

