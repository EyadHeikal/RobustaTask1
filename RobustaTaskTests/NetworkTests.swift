//
//  NetworkTests.swift
//  RobustaTaskTests
//
//  Created by Eyad Heikal on 4/24/21.
//

import XCTest
@testable import RobustaTask

class NetworkTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testLoadingRepositories() {
        let url =  URL(string: "https://api.github.com/search/repositories?q=swift&per_page=10&page=1")!
        let promise = expectation(description: "test")

        URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard error == nil else {
                return XCTFail()
            }
            guard let data = data else {
                return XCTFail()
            }
            guard let _ = try? newJSONDecoder().decode(RepoSearchResponse.self, from: data) else {
                print(String(data: data, encoding: .utf8) ?? .init())
                return XCTFail()
            }
            promise.fulfill()
        }
        .resume()
        wait(for: [promise], timeout: 5)

    }

    func testLoadingImageData() {
        let promise = expectation(description: "test")

        URLSession.shared.dataTask(with: URL(string: "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50")!) { data, response, error in
            guard let _ = data, error == nil else { return XCTFail() }
            promise.fulfill()
        }
        .resume()
        wait(for: [promise], timeout: 5)

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
