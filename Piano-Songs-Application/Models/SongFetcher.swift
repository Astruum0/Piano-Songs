//
//  SongFetcher.swift
//  Piano-Songs-Application
//
//  Created by Arthur VELLA on 31/03/2021.
//

import Foundation
import Combine

protocol SongFetchable {
  func SongForecast(
    songName: String, artist: String
  ) -> AnyPublisher<SongResponse, SongError>
}

class SongFetcher {
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
}

// MARK: - WeatherFetchable
extension SongFetcher: SongFetchable {
  func SongForecast(
    songName: String, artist: String
  ) -> AnyPublisher<SongResponse, SongError> {
    return forecast(with: makeForecastComponents(songName: songName, artist: artist))
  }

  private func forecast<T>(
    with components: URL?
  ) -> AnyPublisher<T, SongError> where T: Decodable {
    guard let url = components else {
      let error = SongError.network(description: "Couldn't create URL")
      return Fail(error: error).eraseToAnyPublisher()
    }
    return session.dataTaskPublisher(for: URLRequest(url: url))
      .mapError { error in
        .network(description: error.localizedDescription)
      }
      .flatMap(maxPublishers: .max(1)) { pair in
        decode(pair.data)
      }
      .eraseToAnyPublisher()
  }
}

// MARK: - OpenWeatherMap API
private extension SongFetcher {
  struct DeezerAPI {
    static let scheme = "https"
    static let host = "https://api.deezer.com/"
    static let path = "/search"
  }
    
  
  func makeForecastComponents(
    songName: String, artist: String
  ) -> URL? {
//    var components = URLComponents()
//    components.scheme = DeezerAPI.scheme
//    components.host = DeezerAPI.host
//    components.path = DeezerAPI.path
//
//    components.queryItems = [
//      URLQueryItem(name: "q", value: "artist:%22" + artist + "%22%20" + "track:%22" + songName + "%22")
//    ]
//    print(components.url)
//    print("https://api.deezer.com/search?q=artist:%22\(artist)%22%20track:%22\(songName)%22")
    
    return URL(string: "https://api.deezer.com/search?q=artist:%22\(artist.replacingOccurrences(of: " ", with: "%20"))%22%20track:%22\(songName.replacingOccurrences(of: " ", with: "%20"))%22")
  }
}

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, SongError> {
  let decoder = JSONDecoder()

  return Just(data)
    .decode(type: T.self, decoder: decoder)
    .mapError { error in
      .parsing(description: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}
