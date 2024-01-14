//
//  NetworkManagerTests.swift
//  StarWarsAppTests
//
//  Created by Ikechukwu Onuorah on 13/01/2024.
//

import XCTest
@testable import StarWarsApp

final class NetworkManagerTests: XCTestCase {
  var sut: NetworkManager!

  override func setUpWithError() throws {
    sut = NetworkManager()
  }

  func testRequestSuccess() async throws {
    // Arrange
    let apiRouter = APIRouter.getFilms

    // Act
    let response: FilmsList = try await sut.request(apiRouter: apiRouter)

    XCTAssertNotNil(response)
  }

//  func testRequestFailure() {
//    // Arrange
//    let apiRouter = APIRouter.getFilms
//
//    // Act
//    let response: FilmsList = try await sut.request(apiRouter: apiRouter)
//  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
}
