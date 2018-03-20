//
//  LoginScreenViewController.swift
//  RoundersRacing
//
//  Created by Anthony on 3/20/18.
//  Copyright © 2018 Anthony. All rights reserved.
//

//
//  LoginViewController.swift
//  bitCash
//
//  Created by Anthony on 8/5/17.
//  Copyright © 2017 bitCash. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LoginScreenViewController: UIViewController, UITextFieldDelegate {
    
    let sharedFirebaseAuth = FirebaseAuth.shared

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var emailTextView: UITextField!
    
    @IBOutlet weak var forgotPWLabel: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var passwordTextView: UITextField!
    
    @IBOutlet weak var createAccountButtonView: UIButton!
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) { /** Not connected to an Outlet and nothing goes here **/ }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("Login Loaded")
        
        emailTextView.delegate = self
        
        passwordTextView.delegate = self
        
        emailTextView.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor: UIColor.grayBarelyVisible])
        
        passwordTextView.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.grayBarelyVisible])
 
                    titleLabel.textColor = UIColor.purple
                    self.view.bringSubview(toFront: titleLabel)
        
                    emailTextView.textColor = UIColor.black
                    emailTextView.layer.shadowColor = UIColor.backgroundBlack.cgColor
                    emailTextView.layer.shadowOffset = CGSize(width: 1, height: 1)
                    emailTextView.layer.shadowRadius = 5
                    emailTextView.layer.shadowOpacity = 1
                    emailTextView.layer.cornerRadius = UIViewController.cornerRadius
                    self.view.bringSubview(toFront: emailTextView)
                    emailTextView.backgroundColor = UIColor.backgroundWhite
       
                    passwordTextView.textColor = UIColor.black
                    passwordTextView.layer.shadowColor = UIColor.backgroundBlack.cgColor
                    passwordTextView.layer.shadowOffset = CGSize(width: 1, height: 1)
                    passwordTextView.layer.shadowRadius = 5
                    passwordTextView.layer.shadowOpacity = 1
                    passwordTextView.layer.cornerRadius = UIViewController.cornerRadius
                    self.view.bringSubview(toFront: passwordTextView)
                    passwordTextView.backgroundColor = UIColor.backgroundWhite
       
                    loginButton.layer.cornerRadius = UIViewController.cornerRadius
                    loginButton.backgroundColor = UIColor.neonBlue.withAlphaComponent(0.75)
                    loginButton.setTitleColor(UIColor.white, for: .normal)
                    loginButton.setTitle("Member's Area", for: .normal)
                    self.view.bringSubview(toFront: loginButton)
        
                    self.view.bringSubview(toFront: forgotPWLabel)
        
                    self.view.bringSubview(toFront: createAccountButtonView)
     
        
        /// check to see if currentUser entity is still logged in.  if they are, bypass loginscreen.  This gets set when the user signs in manually the first time.  stored in coreData.
        
        //        if loginCheck() == true {
        //
        //            /// if logincheck is true, we can assume that the old user is the current user.
        //
        //            self.performSegue(withIdentifier: "skipLoginSegue", sender: self)
        //        }
    }
    
    
    //    /***** SET URGENT VIEW CONTROLLER PROPERTIES HERE *****/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /// Manual Login.
        if segue.identifier == "loginTabBarSegue" {
            
            print("login segue used")
           
        }
        
        /// Auto-Login
        if segue.identifier == "skipLoginSegue" {
            
            print("user found segue to dash")
           
            /// NOT SYNCING TO CLOUD HERE GIVES ABILITY TO HAVE AN OFFLINE MODE.
            /// MAKE AN OPTION FOR USER IF HE OR SHE WANTS OFFLINE MODE.
        }
        
    }
    
    /// this function in login view gets the users array,
    func loginCheck() -> Bool {
        
        return false
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        
        if let emailText = emailTextView.text, let passwordText = passwordTextView.text, emailText.isNotEmptyOrWhitespace && passwordText.isNotEmptyOrWhitespace {
            
            if NetworkCheck.isConnectedToNetwork() {
                
                Auth.auth().signIn(withEmail: emailText, password: passwordText) { (user, error) in
                    
                    if error == nil {
                        
                        if let verifiedUser = user {
                            
                            if verifiedUser.isEmailVerified {
                                
                                self.passwordTextView.text = ""
                                
                                let displayNameRef = self.sharedFirebaseAuth.userAccountsRef.child(verifiedUser.uid)
                                
                                /// TODO NOTES /// this takes too long to load or doesnt work in shitty network situations.  figure out how to improve.
                                displayNameRef.observeSingleEvent(of: .value, with: { snapshot in
                                    
                                    if snapshot.exists() {
                                        
                                        var serializedData = snapshot.value as! [String: Any]
                                        
                                        serializedData["userID"] = snapshot.key
                                        
                                        print("UserINFO HERE", serializedData)
                                        
                                        if let verifiedUserName = serializedData["userName"] as? String,
                                        let verifiedEmailAddress = serializedData["emailAddress"] as? String,
                                        let verifiedUserProfilePicRef = serializedData["profilePicRef"] as? String,
                                        let verifiedUserBetHistory = serializedData["betHistory"] as? [[String: Any]],
                                        let verifiedUserBalances = serializedData["tokenBalances"] as? [String: Double] {
                                            
                                            var newBetHistory = [Bet]()
                                            
                                            for betDictionary in verifiedUserBetHistory {
                                                
                                                let serializedBet = FirebaseAuth.shared.serializeBet(betInfo: betDictionary)
                                               
                                                newBetHistory.insert(serializedBet, at: 0)
                                            }
                                            
                                            FirebaseAuth.shared.setCurrentUser(userName: verifiedUserName,
                                                                               userEmail: verifiedEmailAddress,
                                                                               profileRef: verifiedUserProfilePicRef,
                                                                               betHistory: newBetHistory,
                                                                               balances: verifiedUserBalances)
                                            
                                          
                                            self.performSegue(withIdentifier: "loginTabBarSegue", sender: self)
                                            
                                        }
                                        /// CHECK flag status here.  its an optional that shows "0" for false and "1" for true
                                        //                                    if let loginStatus = serializedData["loginFlag"] as? Bool {
                                        //
                                        //                                        print("loginFlag status", loginStatus)
                                        //
                                        //                                        switch loginStatus {
                                        //
                                        //                                        case true:
                                        //
                                        //                                            let alertController = UIAlertController(title: "Account In Use", message: "Log out of other device first", preferredStyle: .alert)
                                        //
                                        //                                            let defaultAction = UIAlertAction(title: "Okay", style: .cancel, handler: { (act) in
                                        //                                                return
                                        //                                            })
                                        //
                                        //                                            alertController.addAction(defaultAction)
                                        //
                                        //                                            self.present(alertController, animated: true, completion: nil)
                                        //
                                        //                                        case false:
                                        //
                                        //                                            /// this is used to see who the last user was
                                        //                                            UserDefaults.standard.set(snapshot.key, forKey: "lastLoggedUser")
                                        //
                                        //                                            /// this sticks a UserAccount Entity into CoreData and then resets events using user's credentials
                                        //                                            self.setActiveUser(userData: serializedData)
                                        //
                                        //                                            //                                            self.setLoginFlagTrue(userRef: displayNameRef)
                                        //
                                      
                                        //
                                        //                                        }
                                        //
                                        //                                    }
                                        
                                    } else {
                                        return
                                    }
                                    
                                })
                                
                                
                            } else {
                                
                                let alertVC = UIAlertController(title: "Error", message: "Sorry. Your email address has not yet been verified. Do you want us to send another verification email to \(verifiedUser.email!)?", preferredStyle: .alert)
                                
                                let alertActionOkay = UIAlertAction(title: "Okay", style: .default) { _ in
                                    
                                    verifiedUser.sendEmailVerification(completion: nil)
                                }
                                
                                let alertActionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                                
                                alertVC.addAction(alertActionOkay)
                                
                                alertVC.addAction(alertActionCancel)
                                
                                self.present(alertVC, animated: true, completion: nil)
                                
                            }
                            
                        }
                    } else {
                        
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        } else {
            
            
            /** Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in */
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            /// this is nil even when signed into another device.  handle through firebase db
            //            if Auth.auth().currentUser == nil {
            ///
            // LOOK AT FIREBASE DB AND SET THE SIGNIN FLAG THERE.  MAKE SURE IT GETS RESET WHENEVER THE USER LOGS OUT.
            ///
            
            /// TODO NOTES /// This is used when signing in manually.  As we sign in user's credentials are stored in CoreData for future login checks.  Persists until user logs out of the app manually (can still be set to not auto).
            
            
            
            //            } else {
            //                let alertController = UIAlertController(title: "Alert", message: "Your account is currently signed in on another device", preferredStyle: .alert)
            //
            //                let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            //                alertController.addAction(defaultAction)
            //
            //                self.present(alertController, animated: true, completion: nil)
            //            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.passwordTextView.text = ""
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.passwordTextView.text = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        self.view.endEditing(true)
        
        UIView.animate(withDuration: 0.5, animations: {() in
            self.titleLabel.alpha                   = 1
            self.emailTextView.transform            = CGAffineTransform.identity
            self.createAccountButtonView.transform  = CGAffineTransform.identity
            self.passwordTextView.transform         = CGAffineTransform.identity
            self.forgotPWLabel.transform            = CGAffineTransform.identity
            self.loginButton.transform              = CGAffineTransform.identity
        })
    }
    
    @IBAction func forgotPasswordButtonPushed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "passwordResetSegue", sender: self)
        
    }
    
    @IBAction func createAccountButtonPushed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "newUserSegue", sender: self)
    }
    
    func dismissKeyboard() { view.endEditing(true) }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        if !UIApplication.shared.statusBarOrientation.isLandscape {
            
            UIView.animate(withDuration: 0.3, animations: {() in
                self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -30)
                self.emailTextView.transform            = CGAffineTransform(translationX: 0, y: -65)
                self.createAccountButtonView.transform  = CGAffineTransform(translationX: 0, y: -65)
                self.passwordTextView.transform         = CGAffineTransform(translationX: 0, y: -65)
                self.forgotPWLabel.transform            = CGAffineTransform(translationX: 0, y: -65)
                self.loginButton.transform              = CGAffineTransform(translationX: 0, y: -65)  /**-120 */
            })
        } else {
            
            UIView.animate(withDuration: 0.3, animations: {() in
                //                self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -30)
                self.titleLabel.alpha = 0
                self.emailTextView.transform            = CGAffineTransform(translationX: 0, y: -120)
                self.createAccountButtonView.transform  = CGAffineTransform(translationX: 0, y: -120)
                self.passwordTextView.transform         = CGAffineTransform(translationX: 0, y: -120)
                self.forgotPWLabel.transform            = CGAffineTransform(translationX: 0, y: -120)
                self.loginButton.transform              = CGAffineTransform(translationX: 0, y: -140)
            })
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print("textfield resigning first responder")
        textField.resignFirstResponder()
        
        return true
    }
    
    func setActiveUser(userData: [String: Any]) {
        
        print("need to implement set active user here")
        
    }
    
    //    func setLoginFlagTrue(userRef: DatabaseReference) {
    //
    //        let loginFlagData: [String : Any] = [
    //
    //            "loginFlag"     : true
    //
    //        ]
    //
    //
    //        userRef.updateChildValues(loginFlagData)
    //    }
    
    deinit {
        
        print("Login Deinit")
        
    }
    
}




