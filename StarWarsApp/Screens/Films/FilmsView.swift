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
      films
      CustomProgressView()
        .opacity(viewModel.isLoading ? 1 : 0)
    }
    .navigationTitle("Films")
    .toolbarBackground(.visible, for: .navigationBar)
    .toolbarColorScheme(.dark, for: .navigationBar)
    .foregroundColor(.white)
    .searchable(text: $viewModel.searchText)
    .errorAlert(error: $viewModel.error)
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
      viewModel.refreshList(shouldShowLoading: true)
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
  FilmsView()
}
