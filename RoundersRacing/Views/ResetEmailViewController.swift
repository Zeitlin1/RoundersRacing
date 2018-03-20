//
//  ResetEmailViewController.swift
//  RoundersRacing
//
//  Created by Anthony on 3/20/18.
//  Copyright © 2018 Anthony. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var resetPasswordTitleLabel: UILabel!
    
    @IBOutlet weak var emailTextView: UITextField!
    
    @IBOutlet weak var resetButtonLabel: UIButton!
    
    @IBOutlet weak var cancelButtonLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextView.delegate = self
        
        emailTextView.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor: UIColor.placeholderTextColorLight])
        
//        resetPasswordTitleLabel.snp.makeConstraints { (make) in
//            make.width.equalTo(self.view).multipliedBy(0.85)
//            make.top.equalTo(self.view).offset(self.view.frame.height * 0.05)
//            make.centerX.equalTo(self.view)
//            make.height.equalTo(UIViewController.titleFieldHeight)
//            resetPasswordTitleLabel.textColor = UIColor.white
//        }
//
//        emailTextView.snp.makeConstraints { (make) in
//            make.width.equalTo(self.view).multipliedBy(0.85)
//            make.centerX.equalTo(self.view)
//            make.height.equalTo(UIViewController.textFieldHeight)
//            make.centerY.equalTo(self.view).offset(-20)
//
//            emailTextView.layer.cornerRadius = UIViewController.cornerRadius
//            emailTextView.layer.borderWidth = UIViewController.borderWidth
//            emailTextView.layer.borderColor = UIColor.black.cgColor
//            emailTextView.backgroundColor = UIColor.backgroundBlack
//            emailTextView.textColor = UIColor.white
//        }
//
//        resetButtonLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(emailTextView.snp.bottom).offset(UIViewController.offset10)
//            make.height.equalTo(UIViewController.textFieldHeight)
//            make.width.equalTo(self.view).multipliedBy(0.2)
//            make.right.equalTo(emailTextView.snp.right).offset(-UIViewController.offset20)
//
//            resetButtonLabel.layer.borderWidth = UIViewController.borderWidth
//            resetButtonLabel.layer.cornerRadius = UIViewController.cornerRadius
//            resetButtonLabel.backgroundColor = UIColor.backgroundBlack
//            resetButtonLabel.setTitleColor(UIColor.green, for: .normal)
//        }
//
//        cancelButtonLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(emailTextView.snp.bottom).offset(UIViewController.offset10)
//            make.height.equalTo(UIViewController.textFieldHeight)
//            make.width.equalTo(self.view).multipliedBy(0.2)
//            make.left.equalTo(emailTextView.snp.left).offset(UIViewController.offset20)
//
//            cancelButtonLabel.layer.borderWidth = UIViewController.borderWidth
//            cancelButtonLabel.layer.cornerRadius = UIViewController.cornerRadius
//            cancelButtonLabel.backgroundColor = UIColor.backgroundBlack
//            cancelButtonLabel.setTitleColor(UIColor.red, for: .normal)
//        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("touch in reset")
        
        self.view.endEditing(true)
        
    }
    
    @IBAction func resetButtonPushed(_ sender: Any) {
        
        if (self.emailTextView.text?.isEmptyOrWhitespace)! {
            
            let alertController = UIAlertController(title: "Oops!", message: "Please enter an email.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().sendPasswordReset(withEmail: self.emailTextView.text!, completion: { (error) in
                
                if error != nil {
                    
                    print(error!)
                    
                } else {
                    
                    let title = "Success!"
                    
                    let message = "Password reset email sent."
                    
                    self.emailTextView.text = ""
                    
                    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func cancelButtonPushed(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
        }
    }
    
    func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    
}
