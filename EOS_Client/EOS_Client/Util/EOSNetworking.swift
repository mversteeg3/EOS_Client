//
//  EOSNetworking.swift
//  EOS_Client
//
//  Created by Matt Versteeg on 7/30/18.
//  Copyright © 2018 Matt Versteeg. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import SwiftyJSON


class NetworkError: Error, CustomDebugStringConvertible{
    var debugDescription: String{
        return message
    }
    
    var message: String
    
    init(_ message: String){
        self.message = message
    }
}

class EOSNetworking{
    
    static var url_base: String{
        return "https://api.eosnewyork.io/v1"
    }
    static var chain_base: String{
        return "\(url_base)/chain"
    }
    
    static func fetchBlockInfo() ->  Promise<BlockInfo>{
        return Promise { seal in
            guard let url = URL(string: "\(chain_base)/get_info") else {
                return seal.reject(NetworkError("Invalid URL"))
            }
            Alamofire.request(url,
                              method: .post,
                              parameters: nil,
                              encoding: JSONEncoding.default,
                              headers: nil)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        guard let ret = BlockInfo(with: JSON(data)) else {
                            return seal.reject(NetworkError("Error: Response data was malformed"))
                        }
                        seal.fulfill(ret)
                    case .failure(let error):
                        seal.reject(error)
                    }
            }
        }
    }
    
    static func fetchBlock(with id: String) -> Promise<BlockData>{
        return Promise { seal in
            guard let url = URL(string: "\(chain_base)/get_block") else {
                return seal.reject(NetworkError("Invalid URL"))
            }
            Alamofire.request(url,
                              method: .post,
                              parameters: ["block_num_or_id":"\(id)"],
                              encoding: JSONEncoding.default,
                              headers: nil)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        guard let ret = BlockData(with: JSON(data)) else {
                            return seal.reject(NetworkError("Error: Response data was malformed"))
                        }
                        seal.fulfill(ret)
                    case .failure(let error):
                        seal.reject(error)
                    }
            }
        }
    }
}
