//
//  NetworkCommunicator.swift
//  RoundersRacing
//
//  Created by Anthony on 3/20/18.
//  Copyright © 2018 Anthony. All rights reserved.
//

import Foundation

// this class will handle the communication of current bet information between the client and the server.
class NetworkCommunicator {
    
    static let shared = NetworkCommunicator()
    
    private init() {
        
    }
    
    /// this function will get information related to the next race including pot size, pot value and the countdown until the next race
    func getEventInfo() {
        
    }
    
    func sendNewBet(bet: Bet, completion: (Bool)-> Void) {
        completion(true)
    }
    
}
