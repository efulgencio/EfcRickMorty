//
//  Testc.swift
//  EfcRickMortyTests
//
//  Created by efulgencio on 21/4/24.
//

import XCTest

@testable import EfcRickMorty


final class TestListFeature: XCTestCase {

    var sut: CombineManager!
    
    override func setUpWithError() throws {
        super.setUp()
        sut = CombineManager.shared
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testGetList_idFirst_equal_one() throws {

        let expectation = self.expectation(description: "Espera el resultado de la API")
        
        let cancellabe = sut.getData(endpoint: EndPoint.character(.all), type: ListDTO.self).sink (
            receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        expectation.fulfill()
                    case .failure(let error):
                        XCTFail("Error: \(error.localizedDescription)")
                    }
                }, receiveValue: { response in
                    XCTAssertEqual(response.results[0].id, 1)
                })
            
            waitForExpectations(timeout: 10, handler: nil)
            cancellabe.cancel()
    
    }
    
    func testGetList_pageNumberThree_previousTwo_nextFour() throws {

        let previousUrl = "https://rickandmortyapi.com/api/character/?page=2"
        let nextUrl = "https://rickandmortyapi.com/api/character/?page=4"
        
        let expectation = self.expectation(description: "Espera el resultado de la API")
        
        let cancellabe = sut.getData(endpoint: EndPoint.character(.page("3")), type: ListDTO.self).sink (
            receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        expectation.fulfill()
                    case .failure(let error):
                        XCTFail("Error: \(error.localizedDescription)")
                    }
                }, receiveValue: { response in
                    XCTAssertEqual(response.info.prev, previousUrl)
                    XCTAssertEqual(response.info.next, nextUrl)
                })
            
            waitForExpectations(timeout: 10, handler: nil)
            cancellabe.cancel()
        
    }

}
