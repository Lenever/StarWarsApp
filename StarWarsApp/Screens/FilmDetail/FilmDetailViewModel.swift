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

@MainActor
class FilmDetailViewModel: FilmDetailProtocol, ObservableObject {
  @Published var film: Film?
  @Published var isLoading: Bool = false
  @Published var error: Error?

  init(film: Film) {
    self.film = film
  }

  func refreshFilmDetails(shouldShowLoading: Bool = false) {
    if shouldShowLoading {
      isLoading = true
    }

    if let film = film {
      Task {
        do {
          try await getFilmDetailById(filmId: film.episodeID)
          isLoading = false
        } catch {
          isLoading = false
          self.error = error
        }
      }
    }
  }

  func getFilmDetailById(filmId: Int) async throws {
    do {
      self.film = try await NetworkManager.request(apiRouter: .getFilmById(id: filmId))
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
