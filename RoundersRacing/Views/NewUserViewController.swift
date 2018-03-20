//
//  NewUserViewController.swift
//  RoundersRacing
//
//  Created by Anthony on 3/20/18.
//  Copyright © 2018 Anthony. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class NewUserViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var submitButtonLabel: UIButton!
    
    @IBOutlet weak var cancelButtonLabel: UIButton!
    
    @IBOutlet weak var newUserTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.delegate = self
        
        emailTextField.delegate = self
        
        passwordTextField.delegate = self
        
        confirmPasswordTextField.delegate = self
        
        userNameTextField.attributedPlaceholder = NSAttributedString(string: "User Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor.placeholderTextColorLight])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: [NSAttributedStringKey.foregroundColor: UIColor.placeholderTextColorLight])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.placeholderTextColorLight])
        confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Password Confirm", attributes: [NSAttributedStringKey.foregroundColor: UIColor.placeholderTextColorLight])
        
        //        newUserTitleLabel.snp.makeConstraints { (make) in
        //            make.width.equalTo(self.view).multipliedBy(0.85)
        //            make.top.equalTo(self.view).offset(self.view.frame.height * 0.05)
        //            make.centerX.equalTo(self.view)
        //            make.height.equalTo(UIViewController.titleFieldHeight)
        //            newUserTitleLabel.textColor = UIColor.white
        //        }
        //
        //        firstNameTextField.snp.makeConstraints { (make) in
        //            make.top.equalTo(newUserTitleLabel.snp.bottom).offset(UIViewController.offset10)
        //            make.centerX.equalTo(self.view)
        //            make.width.equalTo(self.view).multipliedBy(0.85)
        //            make.height.equalTo(UIViewController.textFieldHeight)
        //            firstNameTextField.layer.borderWidth = UIViewController.borderWidth
        //            firstNameTextField.layer.cornerRadius = UIViewController.cornerRadius
        //            firstNameTextField.backgroundColor = UIColor.backgroundBlack
        //        }
        //
        //        lastNameTextField.snp.makeConstraints { (make) in
        //            make.top.equalTo(firstNameTextField.snp.bottom).offset(UIViewController.offset10)
        //            make.width.equalTo(self.view).multipliedBy(0.85)
        //            make.centerX.equalTo(self.view)
        //            make.height.equalTo(UIViewController.textFieldHeight)
        //            lastNameTextField.layer.borderWidth = UIViewController.borderWidth
        //            lastNameTextField.layer.cornerRadius = UIViewController.cornerRadius
        //            lastNameTextField.backgroundColor = UIColor.backgroundBlack
        //        }
        //
        //        emailTextField.snp.makeConstraints { (make) in
        //            make.width.equalTo(self.view).multipliedBy(0.85)
        //            make.centerX.equalTo(self.view)
        //            make.top.equalTo(lastNameTextField.snp.bottom).offset(UIViewController.offset10)
        //            make.height.equalTo(UIViewController.textFieldHeight)
        //            emailTextField.layer.cornerRadius = UIViewController.cornerRadius
        //            emailTextField.layer.borderWidth = UIViewController.borderWidth
        //            emailTextField.layer.borderColor = UIColor.black.cgColor
        //            emailTextField.backgroundColor = UIColor.backgroundBlack
        //        }
        //
        //        passwordTextField.snp.makeConstraints { (make) in
        //            make.width.equalTo(self.view).multipliedBy(0.85)
        //            make.centerX.equalTo(self.view)
        //            make.height.equalTo(UIViewController.textFieldHeight)
        //            make.top.equalTo(emailTextField.snp.bottom).offset(UIViewController.offset10)
        //            passwordTextField.layer.cornerRadius = UIViewController.cornerRadius
        //            passwordTextField.layer.borderWidth = UIViewController.borderWidth
        //            passwordTextField.layer.borderColor = UIColor.black.cgColor
        //            passwordTextField.backgroundColor = UIColor.backgroundBlack
        //        }
        //
        //        confirmPasswordTextField.snp.makeConstraints { (make) in
        //            make.width.equalTo(self.view).multipliedBy(0.85)
        //            make.centerX.equalTo(self.view)
        //            make.height.equalTo(UIViewController.textFieldHeight)
        //            make.top.equalTo(passwordTextField.snp.bottom).offset(UIViewController.offset10)
        //            confirmPasswordTextField.layer.cornerRadius = UIViewController.cornerRadius
        //            confirmPasswordTextField.layer.borderWidth = UIViewController.borderWidth
        //            confirmPasswordTextField.layer.borderColor = UIColor.black.cgColor
        //            confirmPasswordTextField.backgroundColor = UIColor.backgroundBlack
        //        }
        //
        //        submitButtonLabel.snp.makeConstraints { (make) in
        //            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(UIViewController.offset10)
        //            make.height.equalTo(UIViewController.textFieldHeight)
        //            make.width.equalTo(self.view).multipliedBy(0.2)
        //            make.right.equalTo(confirmPasswordTextField.snp.right).offset(-UIViewController.offset20)
        //
        //            submitButtonLabel.layer.borderWidth = UIViewController.borderWidth
        //            submitButtonLabel.layer.cornerRadius = UIViewController.cornerRadius
        //            submitButtonLabel.backgroundColor = UIColor.backgroundBlack
        //            submitButtonLabel.setTitleColor(UIColor.green, for: .normal)
        //        }
        //
        //        cancelButtonLabel.snp.makeConstraints { (make) in
        //            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(UIViewController.offset10)
        //            make.height.equalTo(UIViewController.textFieldHeight)
        //            make.width.equalTo(self.view).multipliedBy(0.2)
        //            make.left.equalTo(confirmPasswordTextField.snp.left).offset(UIViewController.offset20)
        //
        //            cancelButtonLabel.layer.borderWidth = UIViewController.borderWidth
        //            cancelButtonLabel.layer.cornerRadius = UIViewController.cornerRadius
        //            cancelButtonLabel.backgroundColor = UIColor.backgroundBlack
        //            cancelButtonLabel.setTitleColor(UIColor.red, for: .normal)
        //        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("touch in newUser")
        
        self.view.endEditing(true)
        
        
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //        if textField == emailTextField || textField == passwordTextField || textField == confirmPasswordTextField {
        //            UIView.animate(withDuration: 0.25, animations: {() in
        //                textField.transform = CGAffineTransform.identity
        //            })
        //        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        //        if textField == emailTextField || textField == passwordTextField || textField == confirmPasswordTextField {
        //            UIView.animate(withDuration: 0.25, animations: {() in
        //                textField.transform = CGAffineTransform(translationX: 0, y: -100)
        //            })
        //        }
    }
    
    @IBAction func cancelButtonPushed(_ sender: UIButton) {
        print("dismiss pushed")
        self.dismiss(animated: true) {
            print("dismiss view")
        }
    }
    
    
    @IBAction func submitNewUserButton(_ sender: Any) {
        
        if let userNameText = userNameTextField.text,
            let emailText = emailTextField.text,
            let passwordText = passwordTextField.text,
            let confirmPasswordText = confirmPasswordTextField.text,
            userNameText != "" &&
            passwordText == confirmPasswordText &&
            passwordText != "" &&
            emailText.contains("@") &&
            emailText.contains(".") {
            
            if NetworkCheck.isConnectedToNetwork() {
                
                Auth.auth().createUser(withEmail: emailText, password: passwordText) { (user, error) in
                    
                    if error != nil {
                        
                        print("er", error!)
                        
                        let alertController = UIAlertController(title: "Error", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                        
                    } else {
                        
                        let alertController = UIAlertController(title: "Email Verification Sent", message: "Please Check Your Email To Verify Your Account", preferredStyle: .alert)
                        
                        let okayAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: { (action) in
                            
                            user?.sendEmailVerification(completion: { error in
                                
                                if error == nil {
                                    
                                    if let newUser = user, let newUserEmail = newUser.email {
                                        
                                        self.storeNewUserInFB(id: newUser.uid, userName: userNameText, emailAddress: newUserEmail, completionHandler: {
                                            
                                            self.dismiss(animated: true, completion: nil)
                                        })
                                    }
                                    
                                } else {
                                    
                                    let alertController = UIAlertController(title: "Error", message: "There was a problem sending to that email address", preferredStyle: .alert)
                                    
                                    let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                                        
                                        self.dismiss(animated: true, completion: nil)
                                    })
                                    
                                    alertController.addAction(defaultAction)
                                    
                                    self.present(alertController, animated: true, completion: nil)
                                }
                            })
                        })
                        
                        alertController.addAction(okayAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
            
        } else {
            
            let alertController = UIAlertController(title: "Error", message: "One or more of your credentials has a problem", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        userNameTextField.text = ""
        
        emailTextField.text = ""
        
        passwordTextField.text = ""
        
        confirmPasswordTextField.text = ""
        
    }
    
    func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    /*** THIS IS WHERE WE WILL CREATE NEW USER TIED TO AUTH ***/
    func storeNewUserInFB(id: String, userName: String, emailAddress: String, completionHandler: @escaping () -> Void) {
        
        //        Create a reference point for the user info
        let newUserRef = FirebaseAuth.shared.userAccountsRef.child(id)
        
        let newUserData: [String : Any] = [
            
            "userID"             : id,
            
            "userName"           : userName,
            
            "emailAddress"       : emailAddress,
            
            "createDate"         : String(describing: NSDate()),
            
            "tokenBalances"      : ["starterTokens": 5.00, "premiumTokens": 0], // <----- this is fronted to each new user.  (think of this as starting weapons)
            // this is also going to be the minimum?  No.
            "betHistory"         : [["beginBetHistory": "beginBetHistory"]],
            
            "profilePicRef"      : "",
            
            "loginFlag"          : false
            
        ]
        
        newUserRef.updateChildValues(newUserData) { (err, dbRef) in
            
            completionHandler()
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    deinit {
        print("deinit new user view")
    }
    
}
