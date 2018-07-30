//
//  BlockInfo.swift
//  EOS_Client
//
//  Created by Matt Versteeg on 7/30/18.
//  Copyright © 2018 Matt Versteeg. All rights reserved.
//

import Foundation
import SwiftyJSON

class BlockInfo{
    var serverVersion: String
    var headBlockNum: BlockNum
    var lastIrreversibleBlockNum: BlockNum
    var headBlockID: String
    var headBlockTime: Date
    var headBlockProducer: String
    
    init?(with json: JSON) {
        print(json)
        guard let _version = json["server_version"].string else{
            return nil
        }
        serverVersion = _version
        
        guard let _blockNum = json["head_block_num"].int else{
            return nil
        }
        headBlockNum = _blockNum
        
        guard let _lastIrreversibleBlockNum = json["last_irreversible_block_num"].int else{
            return nil
        }
        lastIrreversibleBlockNum = _lastIrreversibleBlockNum
        
        guard let _id = json["head_block_id"].string else{
            return nil
        }
        headBlockID = _id
        
        guard let _timeString = json["head_block_time"].string, let _time = Date.from(_timeString) else{
            return nil
        }
        headBlockTime = _time
        
        guard let _prod = json["head_block_producer"].string else{
            return nil
        }
        headBlockProducer = _prod
        
        
    }
    
}
