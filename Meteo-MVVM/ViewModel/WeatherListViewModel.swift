//
//  WeatherListViewModel.swift
//  Meteo-MVVM
//
//  Created by Thomas George on 22/03/2022.
//

import SwiftUI
import Combine

class WeatherListViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
    
    @ObservedObject var api = WeatherApi()
    @Published var weatherList: [WeatherViewModel] = []
    
    var cancellable = Set<AnyCancellable>()
    
    // MARK: - FUNCTIONS
    
    func requestForecast(userLocation: UserLocation) {
        self.api.getWeather(userLocation: userLocation)
            .map { weatherResponse in
                weatherResponse.list.map { forecast in
                    WeatherViewModel(forecast: forecast)
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] response in
                switch response {
                case .failure: self?.weatherList = []
                case.finished: break
                }
            }) { [weak self] result in
                guard let self = self else { return }
                self.weatherList = result
            }
            .store(in: &self.cancellable)
    }
    
}
