//
//  WeatherResponse.swift
//  Meteo-MVVM
//
//  Created by Thomas George on 19/03/2022.
//

import Foundation

// MARK: - WEATHER RESPONSE

struct WeatherResponse: Decodable {
    var list: [Forecast]
}

// MARK: - FORECAST

struct Forecast: Decodable {
    
    var dt: Double
    
    // MARK: - MAIN
    
    var main: Main
    
    struct Main: Decodable {
        var temp: Double
        var temp_min: Double
        var temp_max: Double
    }
    
    // MARK: - WEATHER
    
    var weather: [Weather]
    
    struct Weather: Decodable {
        var main: String
        var description: String
        var icon: String
    }
    
}
