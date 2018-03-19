//
//  PlaceBetViewController.swift
//  RoundersRacing
//
//  Created by Anthony on 3/19/18.
//  Copyright © 2018 Anthony. All rights reserved.
//

import UIKit

class PlaceBetViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func backButtonPushed(_ sender: UIButton) {
        self.dismiss(animated: true) {}
    }
    
    @IBOutlet weak var placeBetButton: UIButton!
    
    @IBAction func placeBetButtonPushed(_ sender: UIButton) {
        // place new bet in shared mngr
        SharedBetManager.shared.placeNewBet {
            self.dismiss(animated: true) {
                print("current bet has been placed \(SharedBetManager.shared.currentBet)")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
