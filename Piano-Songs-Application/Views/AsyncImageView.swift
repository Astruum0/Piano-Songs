//
//  AsyncImageView.swift
//  Piano-Songs-Application
//
//  Created by Arthur VELLA on 31/03/2021.
//

import SwiftUI


struct AsyncImageForNewSong: View {
    @StateObject private var loader: ImageLoader
    @ObservedObject var SongVM: SongViewModel
    var state:imageType
    
    init(songVM: SongViewModel, type: imageType) {
        print("Reload Image View ––––––––––––––––– \(songVM.coverUrl)")
        self.SongVM = songVM
        _loader = StateObject(wrappedValue: ImageLoader(url: URL(string: songVM.coverUrl)!))
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
                        Image(uiImage: loader.image!)
                            .resizable()
                            .frame(width: 300, height: 300)
                            .scaledToFill()
                            .cornerRadius(12.0)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            
                    } else {
                        Image("default")
                            .resizable()
                            .frame(width: 300, height: 300)
                            .scaledToFill()
                            .cornerRadius(12.0)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    }
                case .small:
                    if loader.image != nil {
                        Image(uiImage: loader.image!)
                            .resizable().frame(width: 50, height: 50)
                    } else {
                        Image("default").resizable().frame(width: 50, height: 50)
                    }
                    
                case .medium:
                    if loader.image != nil {
                        Image(uiImage: loader.image!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .scaledToFill()
                            .cornerRadius(12.0)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    } else {
                        Image("default")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .scaledToFill()
                            .cornerRadius(12.0)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    }
            }
            
            
        }
    }
}

struct AsyncImage: View {
    @StateObject private var loader: ImageLoader

    var state:imageType
    var url: URL
    
    init(url: URL, type: imageType) {
        
        self.url = url
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
                        Image(uiImage: loader.image!)
                            .resizable()
                            .frame(width: 300, height: 300)
                            .scaledToFill()
                            .cornerRadius(12.0)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            
                    } else {
                        Image("default")
                            .resizable()
                            .frame(width: 300, height: 300)
                            .scaledToFill()
                            .cornerRadius(12.0)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    }
                case .small:
                    if loader.image != nil {
                        Image(uiImage: loader.image!)
                            .resizable().frame(width: 50, height: 50)
                    } else {
                        Image("default").resizable().frame(width: 50, height: 50)
                    }
                    
                case .medium:
                    if loader.image != nil {
                        Image(uiImage: loader.image!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .scaledToFill()
                            .cornerRadius(12.0)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    } else {
                        Image("default")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .scaledToFill()
                            .cornerRadius(12.0)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    }
            }
            
            
        }
    }
}

import Foundation
import SwiftUI
import UIKit
import Combine

struct AsyncImage2FromViewModel<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader2
    private var placeholder: Placeholder
    private let image: (UIImage) -> Image
    @ObservedObject private var SongVM: SongViewModel
    
    init(
        viewModel: SongViewModel,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ) {
        self.SongVM = viewModel
        let url = URL(string: viewModel.coverUrl)!
        self.placeholder = placeholder()
        self.image = image
        _loader = StateObject(wrappedValue: ImageLoader2(url: url, cache: Environment(\.imageCache).wrappedValue))
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            if loader.image != nil {
                image(loader.image!)
            } else {
                placeholder
            }
        }
    }
}

struct AsyncImage2<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader2
    private var placeholder: Placeholder
    private let image: (UIImage) -> Image
    
    init(
        url: URL,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ) {
        self.placeholder = placeholder()
        self.image = image
        _loader = StateObject(wrappedValue: ImageLoader2(url: url, cache: Environment(\.imageCache).wrappedValue))
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            if loader.image != nil {
                image(loader.image!)
            } else {
                placeholder
            }
        }
    }
}

protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}

struct TemporaryImageCache: ImageCache {
    private let cache = NSCache<NSURL, UIImage>()
    
    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}

class ImageLoader2: ObservableObject {
    @Published var image: UIImage?
    
    private(set) var isLoading = false
    
    private let url: URL
    private var cache: ImageCache?
    private var cancellable: AnyCancellable?
    
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
    
    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        guard !isLoading else { return }

        if let image = cache?[url] {
            self.image = image
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveOutput: { [weak self] in self?.cache($0) },
                          receiveCompletion: { [weak self] _ in self?.onFinish() },
                          receiveCancel: { [weak self] in self?.onFinish() })
            .subscribe(on: Self.imageProcessingQueue)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
    private func onStart() {
        isLoading = true
    }
    
    private func onFinish() {
        isLoading = false
    }
    
    private func cache(_ image: UIImage?) {
        image.map { cache?[url] = $0 }
    }
}

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
