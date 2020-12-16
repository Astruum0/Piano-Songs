//
//  data.swift
//  Piano Songs
//
//  Created by Arthur VELLA on 23/10/2020.
//

import UIKit
import SwiftUI
import CoreLocation
import Foundation
import Combine


let songsData: [Song] = load("songsData.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

final class ImageStore {
    typealias _ImageDictionary = [String: CGImage]
    fileprivate var images: _ImageDictionary = [:]

    fileprivate static var scale = 2
    
    static var shared = ImageStore()
    
    func image(imageName: String?) -> Image {
        var name: String
        if let imageN = imageName {
            name = imageN
        } else {
            name = "default"
        }
        let index = _guaranteeImage(name: name)
        
        return Image(images.values[index], scale: CGFloat(ImageStore.scale), label: Text(name))
    }

    static func loadImage(name: String) -> CGImage {
        guard
            let url = Bundle.main.url(forResource: name, withExtension: "jpg"),
            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
        else {
            fatalError("Couldn't load image \(name).jpg from main bundle.")
        }
        return image
    }
    
    fileprivate func _guaranteeImage(name: String) -> _ImageDictionary.Index {
        if let index = images.index(forKey: name) { return index }
        
        images[name] = ImageStore.loadImage(name: name)
        return images.index(forKey: name)!
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL

    init(url: URL) {
        self.url = url
    }

    deinit {
        cancel()
    }
    private var cancellable: AnyCancellable?

    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}

enum imageType {
    case large
    case small
}

struct AsyncImage: View {
    @StateObject private var loader: ImageLoader

    var state:imageType
    
    init(url: URL, type: imageType) {
        
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
        state = type
    }

    var body: some View {
        content
            .onAppear(perform: loader.load)
    }

    private var content: some View {
        Group {
            
            switch state {
                case .large:
                    if loader.image != nil {
                        
                        GeometryReader { geo in
                        Image(uiImage: loader.image!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geo.size.width)
                            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        }
                            
                    } else {
                        GeometryReader { geo in
                        Image("default")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width)
                            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        }
                    }
                case .small:
                    if loader.image != nil {
                        Image(uiImage: loader.image!)
                            .resizable().frame(width: 50, height: 50)
                    } else {
                        Image("default").resizable().frame(width: 50, height: 50)
                    }
            }
            
            
        }
    }
}

struct test: PreviewProvider {
    static var previews: some View {
        Group {
            SongList().environmentObject(UserData())
        }
    }
}
