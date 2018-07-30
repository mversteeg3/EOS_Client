//
//  Cycle.swift
//  EOS_Client
//
//  Created by Matt Versteeg on 7/30/18.
//  Copyright © 2018 Matt Versteeg. All rights reserved.
//

import Foundation

typealias Lock = Int

class Cycle{
    var readLocks: [Lock] = []
    var writeLocks: [Lock] = []
    var transactions: [Transaction] = []

    
    func addTransaction(_ transaction: Transaction){
        transactions.append(transaction)
    }
}
