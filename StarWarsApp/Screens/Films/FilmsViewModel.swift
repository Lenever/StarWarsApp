//
//  FilmsViewModel.swift
//  StarWarsApp
//
//  Created by Ikechukwu Onuorah on 10/01/2024.
//

import Foundation

protocol FilmListProtocol {
  func getFilmList() async throws
}

@MainActor
class FilmsViewModel: FilmListProtocol, ObservableObject {
  @Published var films: [Film] = []
  @Published var isLoading: Bool = false
  @Published var error: Error?

  init() {
    isLoading = true
    Task {
      do {
        try await getFilmList()
        isLoading = false
      } catch {
        isLoading = false
        self.error = error
      }
    }
  }

  func getFilmList() async throws {
    do {
      let response: FilmsList = try await NetworkManager.request(apiRouter: .getFilms)
      films = response.results
    } catch APIRequestError.invalidUrl {
      throw APIRequestError.invalidUrl
    } catch APIRequestError.invalidData {
      throw APIRequestError.invalidData
    } catch APIRequestError.invalidResponse {
      throw APIRequestError.invalidResponse
    } catch {
      throw error
    }
  }
}
