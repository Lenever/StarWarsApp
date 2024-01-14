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
  @Published var film: Film
  @Published var isFavorite: Bool
  @Published var isLoading: Bool = false
  @Published var error: Error?

  var networkManager: NetworkManagerProtocol

  init(
    film: Film,
    networkManager: NetworkManagerProtocol = NetworkManager()
  ) {
    self.film = film
    self.networkManager = networkManager

    if let favorites = UserDefaultsStorage.favoriteFilms {
      self.isFavorite = favorites.contains(film)
    } else {
      self.isFavorite = false
    }
  }

  func handleAddToFavorites() {
    if let favorites = UserDefaultsStorage.favoriteFilms {
      if favorites.contains(film) {
        UserDefaultsStorage.favoriteFilms = favorites.filter {
          $0 == film
        }
        isFavorite = false
      } else {
        UserDefaultsStorage.favoriteFilms?.append(film)
        isFavorite = true
      }
    } else {
      UserDefaultsStorage.favoriteFilms = [film]
      isFavorite = true
    }
  }

  func refreshFilmDetails(shouldShowLoading: Bool = false) {
    if shouldShowLoading {
      isLoading = true
    }

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

  func getFilmDetailById(filmId: Int) async throws {
    do {
      self.film = try await networkManager.request(apiRouter: .getFilmById(id: filmId))
    } catch {
      throw error
    }
  }
}
