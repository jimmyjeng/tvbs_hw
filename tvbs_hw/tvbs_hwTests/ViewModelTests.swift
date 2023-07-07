//
//  ViewModelTests.swift
//  tvbs_hwTests
//
//  Created by Jimmy on 2023/7/7.
//

import XCTest
@testable import tvbs_hw

final class ViewModelTests: XCTestCase {
    
    var viewModels: ViewModel = ViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // 5 fake data
        viewModels.loadData()
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAll() throws {
        
        //        getData
        XCTAssertNil(viewModels.getData(index: -1))
        XCTAssertNotNil(viewModels.getData(index: 0))
        XCTAssertNotNil(viewModels.getData(index: 1))
        XCTAssertNotNil(viewModels.getData(index: 2))
        XCTAssertNotNil(viewModels.getData(index: 3))
        XCTAssertNotNil(viewModels.getData(index: 4))
        XCTAssertNil(viewModels.getData(index: 5))
        
        //        changeLike
        let data1 = viewModels.getData(index: 1)!
        let data2 = viewModels.getData(index: 2)!
        
        viewModels.changeLike(index: 1)
        viewModels.changeLike(index: 2)
        
        XCTAssert(data1.isLike)
        XCTAssertEqual(data1.likeCount, 601)
        
        XCTAssertFalse(data2.isLike)
        XCTAssertEqual(data2.likeCount, 776)
        
        //        changeDislike
        viewModels.changeDislike(index: 1)
        viewModels.changeDislike(index: 2)
        
        XCTAssertFalse(data1.isDislike)
        XCTAssert(data2.isDislike)
        
        //        isLastData
        XCTAssertFalse(viewModels.isLastData(index: -1))
        XCTAssertFalse(viewModels.isLastData(index: 0))
        XCTAssertFalse(viewModels.isLastData(index: 1))
        XCTAssertFalse(viewModels.isLastData(index: 2))
        XCTAssertFalse(viewModels.isLastData(index: 3))
        XCTAssert(viewModels.isLastData(index: 4))
        
        
        //        numberOfItemsInSection
        XCTAssertEqual(viewModels.numberOfItemsInSection(section: 0), 5)

    }
    
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
