//
//  FavoritesView.swift
//  StarWarsApp
//
//  Created by Ikechukwu Onuorah on 14/01/2024.
//

import SwiftUI

struct FavoritesView: View {
  @StateObject var viewModel = FavoritesViewModel()

  var body: some View {
    NavigationView {
      ZStack {
        Color.backgroundColor
          .edgesIgnoringSafeArea(.all)
        films
      }
      .navigationTitle(Strings.favorites)
      .toolbarBackground(.visible, for: .navigationBar)
      .toolbarColorScheme(.dark, for: .navigationBar)
      .foregroundColor(.white)
      .searchable(text: $viewModel.searchText)
      .onAppear() {
        viewModel.refreshList()
      }
    }
  }

  var films: some View {
    List(viewModel.searchResults, id: \.self) { film in
      filmRow(film: film)
        .listRowBackground(Color.backgroundColor)
    }
    .listStyle(PlainListStyle())
    .listRowBackground(Color.backgroundColor)
    .scrollContentBackground(.hidden)
    .disabled(viewModel.isLoading)
    .blur(radius: viewModel.isLoading ? 3 : 0)
    .refreshable {
      viewModel.refreshList()
    }
  }

  func filmRow(film: Film) -> some View {
    NavigationLink {
      FilmDetailView(film: film)
        .ignoresSafeArea()
    } label: {
      Text(film.title)
        .padding(.vertical)

      Spacer()
    }
  }
}

#Preview {
    FavoritesView()
}
