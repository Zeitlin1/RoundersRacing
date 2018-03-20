//
//  SharedBetLogic.swift
//  RoundersRacing
//
//  Created by Anthony on 3/19/18.
//  Copyright © 2018 Anthony. All rights reserved.
//

import Foundation

class SharedBetLogic {
    
    static let shared = SharedBetLogic()
    
    private init() {
        
    }
    
    final func determineResult() -> String {
        
        let countdownSwitch = ["countdownSwitch": false]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setButtonStatus"), object: countdownSwitch)
        
        let number = Int(arc4random_uniform(UInt32(SharedBetManager.shared.lineup.count - 1)))
        
        print(number)
        
        if SharedBetManager.shared.lineup[number] == SharedBetManager.shared.selectedRacer {
            
            let prize = SharedBetManager.shared.potValue / (SharedBetManager.shared.potSize / 3)
            
            if SharedBetManager.shared.currentBet {
                
                if let oldBalance = SharedBetManager.shared.userBalances["starterTokens"] {
                    
                    let newBalance = oldBalance + prize
                    
                    SharedBetManager.shared.userBalances["starterTokens"] = newBalance
                    
                }
            }
            
            SharedBetManager.shared.resetPot()
            
            SharedBetManager.shared.resetSelection() 
            
            SharedBetManager.shared.resetRace()
            
            SharedBetManager.shared.resetBet()
            
            return "WIN"
            
        } else {
            
            SharedBetManager.shared.resetPot()
            
            SharedBetManager.shared.resetSelection()
            
            SharedBetManager.shared.resetRace()
            
            SharedBetManager.shared.resetBet()
            
            return "LOSS"
            
        }
    }
    
}
