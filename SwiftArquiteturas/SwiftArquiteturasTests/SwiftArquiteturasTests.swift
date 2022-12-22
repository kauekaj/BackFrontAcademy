//
//  SwiftArquiteturasTests.swift
//  SwiftArquiteturasTests
//
//  Created by Kaue de Assis Jacyntho on 22/12/22.
//

import XCTest
@testable import SwiftArquiteturas

class SwiftArquiteturasTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRegister() throws {
        
        let manager = UserManager(business: UserBusiness())
        
        manager.register(email: "teste@teste.com",
                         password: "123456") { userModel in
            print(userModel)
        } failureHandler: { error in
            print(error)
        }

    }
    
    func testLogin() throws {
        let manager = UserManager(business: UserBusiness())

        manager.login(email: "teste@teste.com",
                      password: "123456") { userModel in
            print(userModel)
        } failureHandler: { error in
            print(error)
        }
    }
    
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
