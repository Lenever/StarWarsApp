//
//  FilmDetailViewModel.swift
//  StarWarsApp
//
//  Created by Ikechukwu Onuorah on 10/01/2024.
//

import Foundation

protocol FilmDetailProtocol {
  func getFilmDetailById(filmId: Int) async throws
}

class FilmDetailViewModel: FilmDetailProtocol, ObservableObject {
  @Published var film: Film?
  @Published var error: Error?

  var filmId: Int

  init(filmId: Int) {
    self.filmId = filmId
    Task {
      do {
        try await getFilmDetailById(filmId: filmId)
      } catch {
        self.error = error
        print(error.localizedDescription)
      }
    }
  }

  func getFilmDetailById(filmId: Int) async throws {
    do {
      self.film = try await NetworkManager.request(apiRouter: .getFilmById(id: filmId))
      print(film)
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
