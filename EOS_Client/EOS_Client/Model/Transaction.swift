//
//  Transaction.swift
//  EOS_Client
//
//  Created by Matt Versteeg on 7/30/18.
//  Copyright © 2018 Matt Versteeg. All rights reserved.
//

import Foundation
class Transaction{
    var status: String
    var kcpuUsage: Int
    var netUsageWords: Int
    var id: String
    
    
    
    init(_ id: String, status: String, usage: Int, netUsageWords: Int) {
        self.id = id
        self.status = status
        self.kcpuUsage = usage
        self.netUsageWords = netUsageWords
    }
}
