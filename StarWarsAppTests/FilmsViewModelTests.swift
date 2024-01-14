//
//  FilmsViewModelTests.swift
//  StarWarsAppTests
//
//  Created by Ikechukwu Onuorah on 10/01/2024.
//

import XCTest
@testable import StarWarsApp

@MainActor
final class FilmsViewModelTests: XCTestCase {
  var sut: FilmsViewModel!
  var networkManager: FilmsMockNetworkManager!

  override func setUpWithError() throws {
    networkManager = FilmsMockNetworkManager()
    sut = FilmsViewModel(networkManager: networkManager)
  }

  func testRefreshList() async {
    // Setup
    let filmsList: FilmsList = FilmsList(results: [])
    networkManager.response = filmsList

    // Act
    sut.refreshList()

    // Assert
    XCTAssertFalse(sut.isLoading)
    XCTAssertNil(sut.error)
    XCTAssertEqual(sut.films.count, 0)
    XCTAssertEqual(sut.searchResults.count, 0)
  }

  func testGetFilmListSuccess() async throws {
    // Setup
    let filmsList: FilmsList = FilmsList(results: [])
    networkManager.response = filmsList

    // Act
    try await sut.getFilmList()

    // Assert
    XCTAssertEqual(sut.films, [])
  }

  func testGetFilmListFailure() async throws {
    networkManager.shouldSucceed = false

    do {
      try await sut.getFilmList()
      XCTFail("Expected error but got success")
    } catch let error as APIRequestError {
      XCTAssertEqual(error, APIRequestError.invalidResponse)
    } catch {
      XCTFail("Unexpected error: \(error)")
    }
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
}

class FilmsMockNetworkManager: NetworkManagerProtocol {
  var shouldSucceed = true
  var response: FilmsList?

  func request<T: Codable>(apiRouter: APIRouter) async throws -> T {
    if shouldSucceed, let response = response as? T {
      return try await withCheckedThrowingContinuation { continuation in
        return continuation.resume(with: .success(response))
      }
    } else {
      return try await withCheckedThrowingContinuation { continuation in
        return continuation.resume(with: .failure(APIRequestError.invalidResponse))
      }
    }
  }
}
