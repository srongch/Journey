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
        

        let mockRect = MKMapRect(origin: MKMapPoint(x: 133094305.64442337, y: 87506967.062840745), size: MKMapSize(width: 12493.858283638954, height: 12493.858283638954))
        model.setMapBound(mockRect)
        
        let mockBound = MapBound(latitude1: 52.938522321001983, longtitute1: -1.5066267848297628, latitude2: 52.948619248797378, longtitute2: -1.4898712151701829)
        
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
