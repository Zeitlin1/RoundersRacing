//
//  SettingsViewController.swift
//  RoundersRacing
//
//  Created by Anthony on 3/20/18.
//  Copyright © 2018 Anthony. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButtonPushed(_ sender: UIButton) {
//        if NetworkCheck.isConnectedToNetwork() {
//            print("connected to network")
//            /// REMOVE device signin flag here, then signout? // lets go with this one first since we may run into auth rules issues if we are already signed out.  use a completion to make sure it finishes first.  or signout first?
//            if let currentUser = Events.shared.currentUser {
//
//                let displayNameRef = FirebaseAuth.shared.userAccountsRef.child(currentUser)
//
//                self.setLoginFlagFalse(userRef: displayNameRef, completion: { (success) in
//
//                    print("login set false")
//
//                    if success {
         if NetworkCheck.isConnectedToNetwork() {
                        do {
                            
                            try Auth.auth().signOut()
                            
                            FirebaseAuth.shared.resetCurrentUser()
                            
//                            print("On Signout, user is now:", Auth.auth().currentUser)
//
//                            print("in logout check, try to remove calendar")
//                            // remove the calendar that matches currentUserEmail
//                            Events.shared.removeCalendar {
//                                print("in logout check, after attempting to remove calendar")
//                                // set shared events singleton to nil
//                                Events.resetCurrentEvents()
//
//                                UserDefaults.standard.set("No User Logged In", forKey: "lastLoggedUser")
//
//                                UserDefaults.standard.synchronize()
//
//                                print("set lastLoggedUser on signout to", UserDefaults.standard.value(forKey: "lastLoggedUser"))
//
//                            }
//
//                            self.sharedMPC.transactionStatus = false
//
//                            self.sharedMPC.browser.stopBrowsingForPeers()
//
//                            self.sharedMPC.advertiser.stopAdvertisingPeer()
//
//                            self.tableViewOutlet.reloadData()
                            
//                            self.dismiss(animated: true, completion: nil)
                            
                        } catch let error as NSError {

                            print(error.localizedDescription)
                        }
                    }
//                })
                
//            }
//
//        }
    }
    
    
    @IBAction func cancelButtonPushed(_ sender: UIButton) {
        print("dismiss pushed")
        self.dismiss(animated: true) {
            print("dismiss view")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("settings View Deinit")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
