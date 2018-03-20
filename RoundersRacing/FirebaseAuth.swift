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
    
     var currentUserBetHistory: [String: Any]?
    
    private init(){
        
        print("FirebaseAuth Online")
        
    }
    
    var firebaseAuthID: String {
        
        return Auth.auth().currentUser?.uid ?? "ERROR_NO_USER"
    }
    
    func removeAllObservers() {
        
        userAccountsRef.removeAllObservers()
        
    }
    
    final func setCurrentUser(userName: String, userEmail: String, profileRef: String, betHistory: [String: Any], balances: [String: Double]) {
        
        currentUserName = userName
        
        currentUserEmail = userEmail
        
        currentUserProfilePicRef = profileRef
        
        currentUserBetHistory = betHistory
        
        SharedBetManager.shared.userBalances = balances
        
    }
    
    final func resetCurrentUser() {
    
        print("reset user begin")
        
        currentUserName = nil
    
        currentUserEmail = nil
    
        currentUserProfilePicRef = nil
    
        currentUserBetHistory = nil
    
        SharedBetManager.shared.userBalances = [:]
        
        print("reset user end")
    }
    
    private func deserializeBet(bet: Bet) -> [String: Any] {
        
        let deserializedBet = ["": "", "": "", "": "", "": "",]
        
        return deserializedBet
    }
    
    final func updateUserBetInfo(userBalances: [String: Double], betHistory: [Bet], completion: @escaping ()-> Void) {
        
        let userID = FirebaseAuth.shared.firebaseAuthID
        
        print("make sure this is == to the CURRENT userID even after a logout", userID)
        
        let userRef = FirebaseAuth.shared.userAccountsRef.child(userID)
        
        var newBetHistory = [[String: Any]]()
        
        for bet in betHistory {
            
            newBetHistory.insert(deserializeBet(bet: bet), at: 0)
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

