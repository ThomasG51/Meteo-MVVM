//
//  ImageViewModel.swift
//  Meteo-MVVM
//
//  Created by Thomas George on 22/03/2022.
//

import SwiftUI
import Combine

class ImageViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
    
    @Published var uiImage: UIImage?
    
    var iconUrl: String
    var cancellable: AnyCancellable?
    
    // MARK: - INIT
    
    init(_ iconUrl: String) {
        self.iconUrl = iconUrl
        self.load()
    }
    
    // MARK: - DEINIT
    
    deinit {
        self.cancellable?.cancel()
    }
    
    // MARK: - FUNCTIONS
    
    func load() {
        let urlString = "http://openweathermap.org/img/wn/\(self.iconUrl).png"
        guard let url = URL(string: urlString) else { return }
        self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data:  $0.data)}
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                self?.uiImage = $0
            })
    }
    
}
