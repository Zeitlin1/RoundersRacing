//
//  FirebaseAuth.swift
//  RoundersRacing
//
//  Created by Anthony on 3/20/18.
//  Copyright © 2018 Anthony. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseDatabase

class FirebaseAuth {
    
    static let shared = FirebaseAuth()
    
    let userAccountsRef: DatabaseReference = Database.database().reference().child("userAccounts")
    
     var currentUserName: String?
    
     var currentUserEmail: String?
    
     var currentUserProfilePicRef: String?
    
    private init(){
        
        print("FirebaseAuth Online")
        
    }
    
    var firebaseAuthID: String {
        
        return Auth.auth().currentUser?.uid ?? "ERROR_NO_USER"
    }
    
    func removeAllObservers() {
        
        userAccountsRef.removeAllObservers()
        
    }
    
    final func setCurrentUser(userName: String, userEmail: String, profileRef: String, betHistory: [Bet], balances: [String: Double]) {
        
        currentUserName = userName
        
        currentUserEmail = userEmail
        
        currentUserProfilePicRef = profileRef
        
        SharedBetManager.shared.betHistory = betHistory
        
        SharedBetManager.shared.userBalances = balances
        
    }
    
    final func resetCurrentUser() {
        
        currentUserName = nil
    
        currentUserEmail = nil
    
        currentUserProfilePicRef = nil
    
        SharedBetManager.shared.betHistory = []
    
        SharedBetManager.shared.userBalances = [:]
        
    }
    
    private func deserializeBet(bet: Bet) -> [String: Any] {
        
        let deserializedBet: [String: Any] = ["betValue": bet.betValue, "raceID": "\(bet.raceID)", "betID": "\(bet.betID)", "betDate": "\(bet.betDate)", "selection": "\(bet.selection)", "result": "\(bet.result)"]
        
        return deserializedBet
    }
    
    func serializeBet(betInfo: [String: Any]) -> Bet {
        
        var serializedBet = Bet()
        
        if let betValue = betInfo["betValue"] as? Double {
         
            serializedBet.betValue = betValue
        }
        if let raceID = betInfo["raceID"] as? String {
       
            serializedBet.raceID = raceID
        }
        if let betID = betInfo["betID"] as? String {
      
            serializedBet.betID = betID
        }
        if let betDate = betInfo["betDate"] as? String {
            
            serializedBet.betDate = betDate
        }
        if let selection = betInfo["selection"] as? String {
            
            serializedBet.selection = selection
        }
        if let result = betInfo["result"] as? Bool {
            
            serializedBet.result = result
        }
        
        return serializedBet
    }
    
    final func updateUserBetInfo(userBalances: [String: Double], betHistory: [Bet], completion: @escaping ()-> Void) {
        
        let userID = FirebaseAuth.shared.firebaseAuthID
        
        print("make sure this is == to the CURRENT userID even after a logout", userID)
        
        let userRef = FirebaseAuth.shared.userAccountsRef.child(userID)
        
        var newBetHistory = [[String: Any]]()
        
        for bet in betHistory {
            
            let newDeserializedBet = deserializeBet(bet: bet)
            
            newBetHistory.insert(newDeserializedBet, at: 0)
        }
        
        /// serialize each bet in the history into a full dictionary and then send that dictionary up into FB
        let updatedUserData: [String : Any] = [
            
            "tokenBalances"      : userBalances,
            
            "betHistory"         : newBetHistory
            
        ]
        
        userRef.updateChildValues(updatedUserData) { (err, dbRef) in
            
            if err != nil {
                print("err!", err!)
            }
                completion()
        }
    }
    
    deinit {
        print("firebase auth offline")
        
        self.removeAllObservers()
    }
}

