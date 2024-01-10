//
//  FilmDetailView.swift
//  StarWarsApp
//
//  Created by Ikechukwu Onuorah on 10/01/2024.
//

import SwiftUI

struct FilmDetailView: View {
  @StateObject var viewModel: FilmDetailViewModel

  init(film: Film) {
    _viewModel = StateObject(wrappedValue: FilmDetailViewModel(film: film))
  }

  var body: some View {
    ZStack {
      Color.backgroundColor
        .edgesIgnoringSafeArea(.all)
      filmDetail
      CustomProgressView()
        .opacity(viewModel.isLoading ? 1 : 0)
    }
    .navigationTitle(viewModel.film?.title ?? "Film Detail")
    .toolbarBackground(.visible, for: .navigationBar)
    .toolbarColorScheme(.dark, for: .navigationBar)
    .foregroundColor(.white)
    .errorAlert(error: $viewModel.error)
  }

  var filmDetail: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(alignment: .leading, spacing: 24) {
        if let film = viewModel.film {
          Text(film.title)
          Text(film.openingCrawl)
          Text(film.director)
          Text(film.producer)
          Text(film.releaseDate)
          Text(film.created)
          Text(film.edited)
        }
      }
      .padding(.top, 150)
    }
    .disabled(viewModel.isLoading)
    .blur(radius: viewModel.isLoading ? 3 : 0)
    .refreshable {
      viewModel.refreshFilmDetails(shouldShowLoading: true)
    }
  }
}

#Preview {
  FilmDetailView(film: Film(
    title: "",
    episodeID: 0,
    openingCrawl: "",
    director: "",
    producer: "",
    releaseDate: "",
    characters: [],
    planets: [],
    starships: [],
    vehicles: [],
    species: [],
    created: "",
    edited: "",
    url: ""
  ))
}
