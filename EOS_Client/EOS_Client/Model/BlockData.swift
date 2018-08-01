//
//  BlockData.swift
//  EOS_Client
//
//  Created by Matt Versteeg on 7/30/18.
//  Copyright © 2018 Matt Versteeg. All rights reserved.
//

import Foundation
import SwiftyJSON
public typealias BlockNum = Int

class BlockData: Equatable{
    
    
    var id: String
    var blockNum: BlockNum
    var previous: String
    var timeStamp: Date
    var transactionMRoot: String
    var actionMRoot: String
//    var blockMRoot: String
    var producer: String
    var scheduleVersion: Int
    var newProducers: [String] = []
    var producerSignature: String
    var regions: [Region] = []
    var inputTransactions: [Transaction] = []
    var refBlockPrefix: Int
    var abi: ABI?
    
    init?(with json: JSON){
        print(json)
        guard let _id = json["id"].string else{
            return nil
        }
        id = _id
        
        guard let _block = json["block_num"].int else{
            return nil
        }
        blockNum = _block
        
        guard let _prev = json["previous"].string else{
            return nil
        }
        previous = _prev
        
        guard let _timeString = json["timestamp"].string, let _time = Date.from(_timeString) else{
            return nil
        }
        timeStamp = _time
        
        guard let _tMR = json["transaction_mroot"].string else{
            return nil
        }
        transactionMRoot = _tMR
        
        guard let _amr = json["action_mroot"].string else{
            return nil
        }
        actionMRoot = _amr
        
//        guard let _bmr = json["block_mroot"].string else{
//            return nil
//        }
//        blockMRoot = _bmr
        
        guard let _prod = json["producer"].string else{
            return nil
        }
        producer = _prod
        
        guard let _vers = json["schedule_version"].int else{
            return nil
        }
        scheduleVersion = _vers
        
        if let newProducers = json["new_producers"].array{
            for prod in newProducers{
                if let producerString = prod.string{
                    self.newProducers.append(producerString)
                } else{
                    print("Invalid new producer")
                    return nil
                }
            }
        } else{
            print("No new producers array specified")
            // Should this be considered a failure?
        }
        
        if let regions = json["regions"].array{
            for reg in regions{
                if let region = Region(with: reg){
                    self.regions.append(region)
                } else{
                    print("Invalid region definition")
                    return nil
                }
            }
        } else{
            print("No regions array specified")
            // Should this be considered a failure?
        }
        
        if let _it = json["transactions"].array{
            for t in _it{
                if let transaction = Transaction(with: t){
                    inputTransactions.append(transaction)
                }
            }
        }
        
        guard let _ps = json["producer_signature"].string else{
            return nil
        }
        producerSignature = _ps
        
        guard let _prefix = json["ref_block_prefix"].int else{
            return nil
        }
        refBlockPrefix = _prefix
    }
    
    func toString() -> String{
        var ret =
            "id: \(id)\n\n" +
            "blockNumber: \(blockNum)\n\n" +
            "timestamp: \(timeStamp.friendly)\n\n" +
            "previous block: \(previous)\n\n" +
            "transactionMRoot: \(transactionMRoot)\n\n" +
            "actionMRoot: \(actionMRoot)\n\n" +
            "producer: \(producer)\n\n" +
            "scheduleVersion: \(scheduleVersion)\n\n" +
            "new producers: \(newProducers.joined(separator: "," ))\n\n" +
            "producerSignature: \(producerSignature)\n\n" +
            "refBlockPrefix: \(refBlockPrefix)\n\n"
        
        if inputTransactions.count > 0{
            ret += "transactions:\n"
            for trans in inputTransactions{
                ret += "\t\(trans.toString())\n"
            }
        }
        
        if let abi = abi{
            ret += "abi:\n\(abi.toString)"
        }
        
        return ret
    }
    
    static func == (lhs: BlockData, rhs: BlockData) -> Bool {
        return lhs.id == rhs.id && lhs.blockNum == rhs.blockNum
    }
}
