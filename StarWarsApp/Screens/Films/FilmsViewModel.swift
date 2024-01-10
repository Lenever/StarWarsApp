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

class FilmsViewModel: FilmListProtocol, ObservableObject {
  @Published var films: [Film] = []
  @Published var error: Error?

  init() {
    Task {
      do {
        try await getFilmList()
      } catch {
        self.error = error
        print(error.localizedDescription)
      }
    }
  }

  func getFilmList() async throws {
    do {
      let response: FilmsList = try await NetworkManager.request(apiRouter: .getFilms)
      films = response.results
      print(films.count)
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
