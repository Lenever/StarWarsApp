//
//  FilmDetailViewModelTests.swift
//  StarWarsAppTests
//
//  Created by Ikechukwu Onuorah on 13/01/2024.
//

import XCTest
@testable import StarWarsApp

@MainActor
final class FilmDetailViewModelTests: XCTestCase {
  var sut: FilmDetailViewModel!
  var networkManager: FilmDetailMockNetworkManager!

  override func setUpWithError() throws {
    networkManager = FilmDetailMockNetworkManager()
    sut = FilmDetailViewModel(film: .dummy, networkManager: networkManager)
  }

  func testRefreshFilmDetails() {
    // Act
    sut.refreshFilmDetails()

    // Assert
    XCTAssertFalse(sut.isLoading)
    XCTAssertNil(sut.error)
    XCTAssertNotNil(sut.film)
    XCTAssertEqual(sut.film.title, "Dummy")
  }

  func testGetFilmDetailSuccess() async throws {
    // Setup
    networkManager.response = .dummy

    // Act
    try await sut.getFilmDetailById(filmId: 0)

    // Assert
    XCTAssertEqual(sut.film, .dummy)
  }

  func testGetFilmDetailFailure() async {
    networkManager.shouldSucceed = false

    do {
      try await sut.getFilmDetailById(filmId: 0)
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

class FilmDetailMockNetworkManager: NetworkManagerProtocol {
  var shouldSucceed = true
  var response: Film?

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
