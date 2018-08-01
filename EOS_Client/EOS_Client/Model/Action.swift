//
//  Action.swift
//  EOS_Client
//
//  Created by Matt Versteeg on 8/1/18.
//  Copyright © 2018 Matt Versteeg. All rights reserved.
//

import Foundation
import SwiftyJSON

class Action{
    var hex: String
    var name: String
    var account: String
    var authorization: (actor: String, permission: String)
    var data: JSON
    
    init?(with json: JSON){
        guard let _hex = json["hex_data"].string else{
            return nil
        }
        hex = _hex
        
        guard let _n = json["name"].string else{
            return nil
        }
        name = _n
        
        guard let _acc = json["account"].string else{
            return nil
        }
        account = _acc
        
        data = json["data"]
        guard let _auth = json["authorization"].array?.first else{
            return nil
        }
        guard let _actor = _auth["actor"].string else{
            return nil
        }
        
        guard let _perm = _auth["permission"].string else{
            return nil
        }
        authorization = (actor: _actor, permission: _perm)
    }
    
    func toString()->String{
        return "\(name): \(data)"
    }
}
