//
//  FilmsList.swift
//  StarWarsApp
//
//  Created by Ikechukwu Onuorah on 10/01/2024.
//

import Foundation

struct FilmsList: Codable {
  let results: [Film]
}

struct Film: Codable, Hashable {
  let title: String
  let episodeID: Int
  let openingCrawl, director, producer, releaseDate: String
  let characters, planets, starships, vehicles: [String]
  let species: [String]
  let created, edited: String
  let url: String

  enum CodingKeys: String, CodingKey {
    case title
    case episodeID = "episode_id"
    case openingCrawl = "opening_crawl"
    case director, producer
    case releaseDate = "release_date"
    case characters, planets, starships, vehicles, species, created, edited, url
  }
}
