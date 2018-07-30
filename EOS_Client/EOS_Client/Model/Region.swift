//
//  Region.swift
//  EOS_Client
//
//  Created by Matt Versteeg on 7/30/18.
//  Copyright © 2018 Matt Versteeg. All rights reserved.
//

import Foundation
import SwiftyJSON

class Region{
    var regionNum: Int
    var cyclesSummary: [Cycle] = []
    
    init?(with json: JSON) {
        guard let _num = json["region_num"].int else{
            return nil
        }
        regionNum = _num
        
//        if let cycles = json["cycles"].array {
//            for cycle in cycles{
//                cyclesSummary.append(Cycle(cycle))
//            }
//        } else{
//            print("No cycles specified")
//            return nil
//        }
    }
}
