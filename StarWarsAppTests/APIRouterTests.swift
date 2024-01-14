//
//  APIRouterTests.swift
//  StarWarsAppTests
//
//  Created by Ikechukwu Onuorah on 13/01/2024.
//

import XCTest
@testable import StarWarsApp

final class APIRouterTests: XCTestCase {
  override func setUpWithError() throws {
    try super.setUpWithError()

  }

  func testGetFilms() {
    let sut = APIRouter.getFilms

    XCTAssertEqual(sut.scheme, "https")
    XCTAssertEqual(sut.host, "swapi.dev")
    XCTAssertEqual(sut.path, "/api/films/")
    XCTAssertEqual(sut.httpMethod, .get)
    XCTAssertEqual(sut.parameters, [])
    XCTAssertEqual(sut.header, nil)
  }

  func testGetFilmById() {
    let filmId = 123
    let sut = APIRouter.getFilmById(id: filmId)

    XCTAssertEqual(sut.scheme, "https")
    XCTAssertEqual(sut.host, "swapi.dev")
    XCTAssertEqual(sut.path, "/api/films/\(filmId)/")
    XCTAssertEqual(sut.httpMethod, .get)
    XCTAssertTrue(sut.parameters.isEmpty)
    XCTAssertEqual(sut.header, nil)
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()
  }
}
