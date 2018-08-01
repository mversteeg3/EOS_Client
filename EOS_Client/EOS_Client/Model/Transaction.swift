//
//  Transaction.swift
//  EOS_Client
//
//  Created by Matt Versteeg on 7/30/18.
//  Copyright © 2018 Matt Versteeg. All rights reserved.
//

import Foundation
import SwiftyJSON
class Transaction{
    var status: String
    var kcpuUsage: Int
    var netUsageWords: Int
    var id: String
    var actions: [Action] = []
    
    
    init?(with json: JSON) {
        guard let _s = json["status"].string else{
            return nil
        }
        status = _s
        
        guard let _nuw = json["net_usage_words"].int else{
            return nil
        }
        netUsageWords = _nuw
        
        guard let _cpu = json["cpu_usage_us"].int else{
            return nil
        }
        kcpuUsage = _cpu
        
        let _trx = json["trx"]
        
        guard let _id = _trx["id"].string else{
            return nil
        }
        id = _id
        
        let _trans = _trx["transaction"]
        if let _actions = _trans["actions"].array{
            for a in _actions{
                if let _action = Action(with: a){
                    self.actions.append(_action)
                }
            }
        }
    }
    
    func update(with json: JSON) -> Bool{
        print(json)
        return true
    }
    
    func toString() -> String{
        var ret =
            "id: \(id)\n " +
            "status: \(status)\n " +
            "cpu: \(kcpuUsage)\n" +
            "netUsage: \(netUsageWords)\n "
        if actions.count > 0{
            ret += "actions:\n"
            for action in actions{
                ret += "\t\(action.toString())\n"
            }
        }
        return ret
    }
}
