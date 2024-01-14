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
  @Published var searchText = ""
  @Published var isLoading: Bool = false
  @Published var error: Error?

  var searchResults: [Film] {
    if searchText.isEmpty {
      return films
    } else {
      return films.filter { $0.title.contains(searchText) }
    }
  }

  init() {
    if let filmList = UserDefaultsStorage.filmList {
      self.films = filmList
    } else {
      isLoading = true
    }

    refreshList()
  }

  func refreshList(shouldShowLoading: Bool = false) {
    if shouldShowLoading {
      isLoading = true
    }
    
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
      UserDefaultsStorage.filmList = response.results
      films = response.results
    } catch {
      throw error
    }
  }
}
