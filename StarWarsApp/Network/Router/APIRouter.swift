//
//  APIRouter.swift
//  StarWarsApp
//
//  Created by Ikechukwu Onuorah on 10/01/2024.
//

import Foundation

enum APIRouter: EndpointType {
    case getFilms
    case getFilmById(id: Int)

    var scheme: String {
        switch self {
        case .getFilms, .getFilmById:
            return "https"
        }
    }

    var host: String {
        switch self {
        case .getFilms, .getFilmById:
            return "swapi.dev"
        }
    }

    var path: String {
        switch self {
        case .getFilms:
            return "/api/films/"
        case .getFilmById(let id):
            return "/api/films/\(id)/"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getFilms, .getFilmById:
            return .get
        }
    }

    var parameters: [URLQueryItem] {
        switch self {
        case .getFilms:
            return []
        case .getFilmById:
            return []
        }
    }

    var header: [String : String]? {
        return nil
    }
}
