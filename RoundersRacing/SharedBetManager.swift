//
//  SharedBetManager.swift
//  RoundersRacing
//
//  Created by Anthony on 3/19/18.
//  Copyright © 2018 Anthony. All rights reserved.
//

import Foundation

class SharedBetManager {
    
    static let shared = SharedBetManager()
    
    var currentBet = false {
        didSet {
            let betStatus = ["currentBet": currentBet]
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setButtonStatus"), object: betStatus)
            
            print("betStatus notice posted \(betStatus)")
            
        }
    }
    
    var isRaceActive: Bool = false {
        didSet {
            let activeRace = ["isRaceActive": isRaceActive]
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setButtonStatus"), object: activeRace)
            
            print("activeRace notice posted \(activeRace)")
        }
    }
    
    private init() {
        
    }
    
    func placeNewBet(completion: ()-> Void) {
        if currentBet == false {
            currentBet = true
        } else {
            print("bet was already placed")
        }
        completion()
    }
}
