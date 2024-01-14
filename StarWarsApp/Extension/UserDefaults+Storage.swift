//
//  UserDefaults+Storage.swift
//  StarWarsApp
//
//  Created by Ikechukwu Onuorah on 10/01/2024.
//

import Foundation

extension UserDefaults {
  enum Keys: String, CaseIterable {
    case filmList
    case favoriteFilms
  }

  func reset() {
    Keys.allCases.forEach {
      let key = $0.rawValue
      removeObject(forKey: key)
    }
  }
}

// MARK: - UserDefault

@propertyWrapper
struct UserDefault<T: Codable> {
  let key: String
  let defaultValue: T

  init(_ key: UserDefaults.Keys, defaultValue: T) {
    self.key = "grey.\(key.rawValue)"
    self.defaultValue = defaultValue
  }

  public var wrappedValue: T {
    get {
      if
        let data = UserDefaults.standard.object(forKey: key) as? Data,
        let value = try? JSONDecoder().decode(T.self, from: data)
      {
        return value
      } else {
        return defaultValue
      }
    }

    set {
      if let data = try? JSONEncoder().encode(newValue) {
        UserDefaults.standard.set(data, forKey: key)
      }
    }
  }
}

enum UserDefaultsStorage {
  @UserDefault(.filmList, defaultValue: nil)
  static var filmList: [Film]?

  @UserDefault(.favoriteFilms, defaultValue: nil)
  static var favoriteFilms: [Film]?
}
