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
    
    var seconds = 10
    
    var userName = "Mr. Jones"
    
    var userBalance: Double = 100
    
    var potValue: Double = 0
    
    var potSize: Double = 0
    
    var lineup: [String] = []
    
    var selectedRacer: String?
    
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
        lineup = ["marble1", "marble2", "marble3"]
    }
    
    func resetSelection() {
        self.selectedRacer = nil
    }
    
    func resetPot() {
        potValue = 0
        potSize = 0
    }
    
    func resetRace() {
        isRaceActive = false
    }
    
    func resetBet() {
        currentBet = false
    }
             
    func placeNewBet(completion: ()-> Void) {
        if currentBet == false {
            currentBet = true
            self.userBalance -= 1
            self.potValue += 1
            self.potSize += 1
        } else {
            print("bet was already placed")
        }
        completion()
    }
    
}
