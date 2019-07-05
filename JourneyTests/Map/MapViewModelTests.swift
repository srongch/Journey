//
//  MapViewModelTests.swift
//  JourneyTests
//
//  Created by Chhem Sronglong on 26/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//

import XCTest
@testable import Journey
import Moya

class MapViewModelTests: XCTestCase {

    var model : MapViewModelObj!
    var fakeNetwork : FakeNetwork!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        fakeNetwork = FakeNetwork(provider: MoyaProvider<Journey>())
        let mapNetwork = MapNetwork(mapNetWork: fakeNetwork)
        model = MapViewModelObj.init(mapNetWork: mapNetwork)
    }
    
    func test_giveMapBound_ReceiveList(){

        let spyDelegate = SpyMapNetworkProtocol()
        model.delegate = spyDelegate
        
        let expect = expectation(description: "after loading done, call delegate")
        expect.expectedFulfillmentCount = 1
        
        spyDelegate.didCall_taskDidChangeStatus = { error in
            if (error) {
                //need more business logic
                expect.fulfill()
            }
        }
        
        spyDelegate.didCall_taskFinish = { count in
            XCTAssertEqual(3, count)
            XCTAssertNil(self.model.getCarPoint(at: Int32(count + 1)))
            XCTAssertNotNil(self.model.getCarPoint(at: Int32(count - 1)))
            expect.fulfill()
        }
        
        
        
        let mockRect = MKMapRect(origin: MKMapPoint(x: 141489399.78174415, y: 86566511.021178886), size: MKMapSize(width: 8227.8402649760246, height: 17026.144139453769))
        model.setMapBound(mockRect)
        
        let mockBound = MapBound(latitude1: 53.68838346404299, longtitute1: 9.75207180316707, latitude2: 53.701902957168834, longtitute2: 9.763106196832979)
        
        XCTAssertEqual(mockRect, model.getCurrentMapRect())
        XCTAssertEqual(mockBound, model.calculatMapBound(mockRect)!)
        
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
         model = nil
         fakeNetwork = nil
    }

    

}
