//
//  WeatherProtocol.swift
//  Meteo-MVVM
//
//  Created by Thomas George on 19/03/2022.
//

import Foundation
import Combine

protocol WeatherProtocol {
    func getWeather(userLocation: UserLocation) -> AnyPublisher<WeatherResponse, WeatherError>
}
