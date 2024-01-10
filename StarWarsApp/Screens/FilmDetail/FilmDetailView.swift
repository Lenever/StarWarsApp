//
//  FilmDetailView.swift
//  StarWarsApp
//
//  Created by Ikechukwu Onuorah on 10/01/2024.
//

import SwiftUI

struct FilmDetailView: View {
  @StateObject var viewModel: FilmDetailViewModel

  init(filmId: Int) {
    _viewModel = StateObject(wrappedValue: FilmDetailViewModel(filmId: filmId))
  }

  var body: some View {
    ZStack {
      Color.backgroundColor
        .edgesIgnoringSafeArea(.all)

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
        .padding(.top, 100)
      }
      .disabled(viewModel.isLoading)
      .blur(radius: viewModel.isLoading ? 3 : 0)

      ProgressView()
        .progressViewStyle(.automatic)
        .frame(width: 100, height: 100)
        .background(Color.secondary.colorInvert())
        .foregroundColor(Color.primary)
        .cornerRadius(20)
        .opacity(viewModel.isLoading ? 1 : 0)
    }
    .navigationTitle("Film Detail")
    .toolbarBackground(.visible, for: .navigationBar)
    .toolbarColorScheme(.dark, for: .navigationBar)
    .foregroundColor(.white)
    .errorAlert(error: $viewModel.error)
  }
}

#Preview {
  FilmDetailView(filmId: 1)
}
