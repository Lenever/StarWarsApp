//
//  FilmsView.swift
//  StarWarsApp
//
//  Created by Ikechukwu Onuorah on 10/01/2024.
//

import SwiftUI

struct FilmsView: View {
  @StateObject var viewModel = FilmsViewModel()

  var body: some View {
    ZStack {
      Color.backgroundColor
        .edgesIgnoringSafeArea(.all)

      List(viewModel.films, id: \.self) { film in
        filmRow(film: film)
          .listRowBackground(Color.backgroundColor)
      }
      .listStyle(PlainListStyle())
      .listRowBackground(Color.backgroundColor)
      .scrollContentBackground(.hidden)
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
    .navigationTitle("Films")
    .toolbarBackground(.visible, for: .navigationBar)
    .toolbarColorScheme(.dark, for: .navigationBar)
    .foregroundColor(.white)
    .errorAlert(error: $viewModel.error)
  }

  func filmRow(film: Film) -> some View {
    NavigationLink {
      FilmDetailView(filmId: film.episodeID)
        .ignoresSafeArea()
    } label: {
      Text(film.title)
        .padding(.vertical)

      Spacer()
    }
  }
}

#Preview {
  FilmsView()
}
