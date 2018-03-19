//
//  ViewController.swift
//  RoundersRacing
//
//  Created by Anthony on 3/19/18.
//  Copyright © 2018 Anthony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBAction func activeRaceSwitched(_ sender: UISwitch) {
        SharedBetManager.shared.isRaceActive = sender.isOn
    }
    
    @IBOutlet weak var watchVideoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.setButtonStatus(_:)),name:NSNotification.Name(rawValue: "setButtonStatus"), object: nil)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @objc
    func setButtonStatus(_ notification: NSNotification) {
        
        if let notificationObject = notification.object as? [String: Bool] {
        
            let noticeKey = notificationObject.first!.key
            
            switch noticeKey {
                
            case "isRaceActive":
                if notificationObject.first?.value == true {
                    watchVideoButton.setTitle("Watch Video", for: .normal)
                } else {
                    if SharedBetManager.shared.currentBet {
                        watchVideoButton.setTitle("Bet Placed", for: .normal)
                    } else {
                        watchVideoButton.setTitle("Place Bet", for: .normal)
                    }
                }

            case "currentBet":
                if notificationObject.first?.value == true {
                   watchVideoButton.setTitle("Bet Placed", for: .normal)
                } else {
                   watchVideoButton.setTitle("Place Bet", for: .normal)
                }

            default :
                print("error occured in set button status")
            }
        }
    }
    
    @IBAction func watchVideoButtonPushed(_ sender: UIButton) {
        if SharedBetManager.shared.isRaceActive {
        self.performSegue(withIdentifier: "watchVideoSegue", sender: self)
        } else if SharedBetManager.shared.currentBet {
            UIView.animate(withDuration: 0.25, animations: {
                self.watchVideoButton.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            }, completion: { (success) in
                UIView.animate(withDuration: 0.25, animations: {
                    self.watchVideoButton.transform = CGAffineTransform.identity
                })
            })
        } else {
            self.performSegue(withIdentifier: "placeBetSegue", sender: self)
        }
    }

}

