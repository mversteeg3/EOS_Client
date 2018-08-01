//
//  EOS_ClientTests.swift
//  EOS_ClientTests
//
//  Created by Matt Versteeg on 7/30/18.
//  Copyright © 2018 Matt Versteeg. All rights reserved.
//

import XCTest
@testable import EOS_Client

class EOS_ClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEndpoints() {
        let exp = expectation(description: "BlockInfo")
        var blockInfo: BlockInfo?
        EOSNetworking.fetchBlockInfo().done { b in
            blockInfo = b
            exp.fulfill()
        }.catch { (err) in
            print(err)
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        if blockInfo == nil{
            XCTFail("Block info value was nil")
        }
        
        let idExp = expectation(description: "BlockDetails_Id")
        var blockDetails_ID: BlockData?
        EOSNetworking.fetchBlock(with: "\(blockInfo!.headBlockID)").done { b_d in
            blockDetails_ID = b_d
            idExp.fulfill()
            }.catch { (err) in
                print(err)
        }
        let numExp = expectation(description: "BlockDetails_Num")
        var blockDetails_Num: BlockData?
        EOSNetworking.fetchBlock(with: "\(blockInfo!.headBlockNum)").done { b_d in
            blockDetails_Num = b_d
            numExp.fulfill()
            }.catch { (err) in
                print(err)
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        if blockDetails_ID != blockDetails_Num{
            XCTFail("Mismatching block ID and num")
        }
        
        let abiExp = expectation(description: "ABI")
        EOSNetworking.getABI(with: "eosio.token").done { abi in
            abiExp.fulfill()
            }.catch { (err) in
                print(err)
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testBlockDetails(_ id: String){
        
    }
    
//    func test
    
}
