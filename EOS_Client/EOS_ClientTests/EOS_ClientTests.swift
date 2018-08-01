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
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        guard let blockInfo = try? EOSNetworking.fetchBlockInfo().wait() else{
            XCTFail("Failed to load block info")
            return
        }
        guard let blockDetails_ID = EOSNetworking.fetchBlock(with: blockInfo.headBlockID).value() else{
            XCTFail("Failed to load block info")
            return
        }
        guard let blockDetails_Num = EOSNetworking.fetchBlock(with: blockInfo.headBlockNum).value() else{
            XCTFail("Failed to load block info")
            return
        }
        if blockDetails_ID != blockDetails_Num{
            XCTFail("Mismatching block ID and num")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
