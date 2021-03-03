//
//  ApiCall.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 24/01/2021.
//

import Foundation

//struct artistFound: Codable {
//    var name: String
//    var picture_big: String
//}
//
//private func loadJson(fromURLString urlString: String,
//                      completion: @escaping (Result<Data, Error>) -> Void) {
//    if let url = URL(string: urlString) {
//        let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                completion(.failure(error))
//            }
//
//            if let data = data {
//                completion(.success(data))
//            }
//        }
//
//        urlSession.resume()
//    }
//}
//
//private func parseArtistPicture(jsonData: Data) {
//    do {
//        let decodedData = try JSONDecoder().decode(artistFound.self,
//                                                   from: jsonData)
//
//        print("\(decodedData.picture_big)")
//    } catch {
//        print("decode error")
//    }
//}
//
//let urlString = "https://raw.githubusercontent.com/programmingwithswift/ReadJSONFileURL/master/hostedDataFile.json"
//
//loadJson(fromURLString: urlString) { (result) in
//    switch result {
//    case .success(let data):
//        parseArtistPicture(jsonData: data)
//    case .failure(let error):
//        print(error)
//    }
//}

