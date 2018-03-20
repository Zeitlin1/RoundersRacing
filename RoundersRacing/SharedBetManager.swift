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
    
    var userBalances: [String: Double] = [:]
    
    var betHistory: [Bet] = []
    
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
             
    func placeNewBet(completionHandler: @escaping ()-> Void) {
        if currentBet == false && selectedRacer != nil {
            
            currentBet = true
            
            if let oldBalance = self.userBalances["starterTokens"] {
            
                   let newBalance = (oldBalance - 1.00)
            
            self.userBalances["starterTokens"] = newBalance
            
            let newBetValue = Double(oldBalance - newBalance)
                
            let newBet = Bet(betValue: newBetValue,
                             raceID: "\(Date().timeIntervalSince1970)" + "raceIDGoesHere",
                             betID: "\(Date().timeIntervalSince1970)" + "betIDGoesHere",
                             betDate: "\(Date().timeIntervalSince1970)",
                             selection: selectedRacer!,
                             result: false)
           
            self.betHistory.insert(newBet, at: 0)
              
                FirebaseAuth.shared.updateUserBetInfo(userBalances: self.userBalances, betHistory: betHistory, completion: {
                    
                    self.potValue += 1
                    
                    self.potSize += 1
                    
                    completionHandler()
                    
                })
            }
            
        } else {
            print("bet was already placed")
        }
    }
    
    deinit {
        print("deinit bet manager")
    }
}
