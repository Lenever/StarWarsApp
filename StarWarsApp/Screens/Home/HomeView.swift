//
//  HomeView.swift
//  StarWarsApp
//
//  Created by Ikechukwu Onuorah on 14/01/2024.
//

import SwiftUI

struct HomeView: View {
  @State private var tabSelection = 1

  var body: some View {
    TabView(selection: $tabSelection) {
      FilmsView()
        .tabItem {
          tabButton(name: Strings.films, image: "film.fill")
        }.tag(1)

      FavoritesView()
        .tabItem {
          tabButton(name: Strings.favorites, image: "heart.fill")
        }.tag(2)
    }
  }

  func tabButton(name: String, image: String) -> some View {
    VStack(alignment: .leading, spacing: 50) {
      Image(systemName: image)
        .resizable()
        .scaledToFit()
        .frame(width: 30, height: 30)
        .padding(5)
        .background(Color.white)

      Text(name)
        .font(.headline)
    }
    .padding()
  }
}

#Preview {
  HomeView()
}
