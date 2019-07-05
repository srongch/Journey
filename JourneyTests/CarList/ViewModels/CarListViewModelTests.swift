//
//  CarListViewModelTests.swift
//  JourneyTests
//
//  Created by Chhem Sronglong on 26/05/2019.
//  Copyright © 2019 Chhem Sronglong. All rights reserved.
//
//https://medium.com/blablacar-tech/4-tips-to-master-xctestexpectation-aee2b2631d93

import XCTest
@testable import Journey
import Moya

class CarListViewModelTests: XCTestCase {

//    let mockBound = MapBound(latitude1: 53.694865, longtitute1: 9.757589, latitude2: 53.394655, longtitute2: 10.099891)
    var model : CarListViewModel!
    var fakeNetwork : FakeNetwork!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    fakeNetwork = FakeNetwork(provider: MoyaProvider<Journey>())
        
    model = CarListViewModel(carNetwork:fakeNetwork, mapBound: MapBound(latitude1: 52.926763991689398, longtitute1: -1.5066267848297628, latitude2: 52.948619248797378, longtitute2: -1.4898712151701829), filterType: .all)
    }
    
    func testMainLocation() {
        print(model.mainLocation)
        XCTAssertEqual("Derby", model.mainLocation.city)
        XCTAssertEqual("UK", model.mainLocation.country)
    }
    
    func testCollectionView(){
        //iphone xs : width 375
        XCTAssertEqual(CGSize(width: 157.5 , height: 205), model.collectionViewSizeForItem(with: 375))

    }
    
    func testFectch(){
        let spyDelegate = SpyLoadingProtocol()
        model.delegate = spyDelegate
        
        let expect = expectation(description: "after loading done, call delegate")
        expect.expectedFulfillmentCount = 3
        
        spyDelegate.didCall_taskDidChangeStatus = { error in
            if (error) {
                expect.fulfill()
                expect.fulfill()
                expect.fulfill()
            }else
            if (self.model.getFilter == .all) {
                print("task all")
                XCTAssertEqual(3, self.model.numberOfItems(for: 0))
                self.model.changeFilter(filterType: .taxi)
                expect.fulfill()
            }else if (self.model.getFilter == .taxi) {
                print("task taxi")
                XCTAssertEqual(1, self.model.numberOfItems(for: 0))
                self.model.changeFilter(filterType: .pooling)
                expect.fulfill()
            }else if   (self.model.getFilter == .pooling) {
                print("task pooling")
                XCTAssertEqual(2, self.model.numberOfItems(for: 0))
                expect.fulfill()
            }
        }
        
        model.fectch()
        
        waitForExpectations(timeout: 0.5, handler: nil)
        
    }
    
    func test_getRowNumer_Recived_CellViewModel(){
        
        let spyDelegate = SpyLoadingProtocol()
        model.delegate = spyDelegate
        
        let expect = expectation(description: "after loading done, call delegate")
        expect.expectedFulfillmentCount = 1
        
        spyDelegate.didCall_taskDidChangeStatus = { error in
            
            if(error) {
                expect.fulfill()
            }else {
            // mock model
            var mockModel = Model.make().first!
    
            let car = Car.make().first
            let address = Address.make(location: (latitude: mockModel.latitude, longtitude: mockModel.longitude))
            mockModel.car = car
            mockModel.addreess = address.address
            let mockCellModel = CarListCellViewModel(viewModel: mockModel)
            // end mock model
            
            //model from cell
            let model = self.model.cellViewModel(for: IndexPath(item: 0, section: 0))
            
            XCTAssertEqual(mockCellModel.plateNumber, model.plateNumber)
            XCTAssertEqual(mockCellModel.modelName, model.modelName)
            XCTAssertEqual(mockCellModel.color, model.color)
            XCTAssertEqual(mockCellModel.carImage, model.carImage)
            
            expect.fulfill()
            }
        }
        
        model.fectch()
        
        waitForExpectations(timeout: 0.5, handler: nil)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        model = nil
        fakeNetwork = nil
    }

    

}
