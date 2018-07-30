//
//  Date+Util.swift
//  EOS_Client
//
//  Created by Matt Versteeg on 7/30/18.
//  Copyright © 2018 Matt Versteeg. All rights reserved.
//

import Foundation

extension Date{
    
    static var SERVER_FORMAT: String{
        return "YYYY-MM-dd'T'HH:mm:ss.uuu"
    }
    
    static var FRIENDLY_FORMAT: String{
        return "YYYY-MM-dd' at ' HH:mm:ss.uuu"
    }
    
    static func from(_ string: String, with format: String = SERVER_FORMAT) -> Date?{
        let df = DateFormatter()
        df.dateFormat = format
        return df.date(from: string)
    }
    
    var friendly: String{
        let df = DateFormatter()
        df.dateFormat = Date.FRIENDLY_FORMAT
        return df.string(from: self)
    }
}
