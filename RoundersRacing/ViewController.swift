//
//  ViewController.swift
//  RoundersRacing
//
//  Created by Anthony on 3/19/18.
//  Copyright © 2018 Anthony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countdownLabel: UILabel!
    
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBAction func settingsButtonPushed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "settingsSegue", sender: self)
    }
    
    @IBOutlet weak var raceSwitch: UISwitch!
    @IBAction func addBetButtonPushed(_ sender: UIButton) {
        SharedBetManager.shared.potSize += 1
        SharedBetManager.shared.potValue += 1
        
        potSizeLabel.text = "Bet Count: \(Int(SharedBetManager.shared.potSize))"
        potValueLabel.text = "Pot Value: \(SharedBetManager.shared.potValue)"
    }
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userBalance: UILabel!
    
    @IBOutlet weak var potSizeLabel: UILabel!
    
    @IBOutlet weak var potValueLabel: UILabel!
    
    @IBAction func activeRaceSwitched(_ sender: UISwitch) {
        
        if sender.isOn {
            startCountdownTimer()
        } else {
            SharedBetManager.shared.seconds = 10
        }

    }

    @objc
    func startCountdownTimer() {
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (time) in
            
            SharedBetManager.shared.seconds -= 1
            self.countdownLabel.text = "\(SharedBetManager.shared.seconds)"
            
            if SharedBetManager.shared.seconds <= 0 {
                time.invalidate()
                SharedBetManager.shared.isRaceActive = true
            }
        }
        timer.fire()
    }
    
    @IBOutlet weak var watchVideoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.setButtonStatus(_:)),name:NSNotification.Name(rawValue: "setButtonStatus"), object: nil)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let userName = FirebaseAuth.shared.currentUserName {
            userNameLabel.text = "User: \(userName)"
        }
        if let starterTokenBalance = SharedBetManager.shared.userBalances["starterTokens"] {
            userBalance.text = "Balance: \(starterTokenBalance)"
        }
            potSizeLabel.text = "Bet Count: \(Int(SharedBetManager.shared.potSize))"
            potValueLabel.text = "Pot Value: \(SharedBetManager.shared.potValue)"
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
                
            case "countdownSwitch":
                if notificationObject.first?.value == true {
                    raceSwitch.isOn = true
                } else {
                    raceSwitch.isOn = false
                    SharedBetManager.shared.seconds = 10
                }
                
            default :
                print("error occured in set button status")
            }
        }
    }
    
    @IBAction func watchVideoButtonPushed(_ sender: UIButton) {

        if let userStarterTokenBalance = SharedBetManager.shared.userBalances["starterTokens"] {
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
            } else if userStarterTokenBalance < 1 {
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
    
    deinit {
        print("front View Deinit")
    }

}

