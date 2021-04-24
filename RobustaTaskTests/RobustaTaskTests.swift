//
//  RobustaTaskTests.swift
//  RobustaTaskTests
//
//  Created by Eyad Heikal on 4/24/21.
//

import XCTest
@testable import RobustaTask

class RobustaTaskTests: XCTestCase {

    var sut: RepositoriesPresenter!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = container.resolve(RepositoriesPresenter.self)!
        let viewController = container.resolve(RepositoriesViewController.self)!
        viewController.presenter = sut
        _ = viewController.view
        sut.view = viewController
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        sut.repositories = .init(repeating: .dummy, count: 15)
        XCTAssert(sut.getNumberOfItems() == 15)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            sut.loadRepositories(searchKey: "swift")

        }
    }

}
