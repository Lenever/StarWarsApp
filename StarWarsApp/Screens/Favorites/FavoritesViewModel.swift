//
//  FavoritesViewModel.swift
//  StarWarsApp
//
//  Created by Ikechukwu Onuorah on 14/01/2024.
//

import Foundation

protocol FavoritesProtocol {
  func refreshList()
}

class FavoritesViewModel: FavoritesProtocol, ObservableObject {
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
    refreshList()
  }

  func refreshList() {
    if let favorites = UserDefaultsStorage.favoriteFilms {
      self.films = favorites
    }
  }
}
