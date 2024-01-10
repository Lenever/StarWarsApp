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
    }
    .navigationTitle("Films")
    .toolbarBackground(.visible, for: .navigationBar)
    .toolbarColorScheme(.dark, for: .navigationBar)
    .foregroundColor(.white)
    .errorAlert(error: $viewModel.error)
  }

  func filmRow(film: Film) -> some View {
    NavigationLink {
      FilmDetailView()
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
