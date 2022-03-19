//
//  WeatherAPI.swift
//  Meteo-MVVM
//
//  Created by Thomas George on 19/03/2022.
//

import Foundation
import Combine

class WeatherApi: ObservableObject {
    
    func parseWeather(urlComponents: URLComponents) -> AnyPublisher<WeatherResponse, WeatherError> {
        guard let url = urlComponents.url else {
            let urlError = WeatherError.connection(desc: "Invalid URL")
            return Fail(error: urlError).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { error in
                WeatherError.connection(desc: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { output in
                self.decode(output.data)
            }
            .eraseToAnyPublisher()
    }
    
    func getUrlComponents(latitude: Double, longitude: Double) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/forecast"
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude)),
            URLQueryItem(name: "mode", value: "json"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "fr"),
            URLQueryItem(name: "appid", value: key)
        ]
        return urlComponents
    }
    
    func decode(_ data: Data) -> AnyPublisher<WeatherResponse, WeatherError> {
        return Just(data)
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .mapError { error in
                WeatherError.json(desc: "Invalid JSON : \(error.localizedDescription)")
            }
            .eraseToAnyPublisher()
            
    }
    
}

// MARK: - WEATHER PROTOCOL

extension WeatherApi: WeatherProtocol {
    
    func getWeather(userLocation: UserLocation) -> AnyPublisher<WeatherResponse, WeatherError> {
        return self.parseWeather(urlComponents: self.getUrlComponents(latitude: userLocation.latitude, longitude: userLocation.longitude))
    }
    
}
