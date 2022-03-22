//
//  WeatherViewModel.swift
//  Meteo-MVVM
//
//  Created by Thomas George on 19/03/2022.
//

import Foundation

class WeatherViewModel: Identifiable {
    
    // MARK: - PROPERTIES
    
    private let forecast: Forecast
    
    var id = UUID()
    
    var timestamp: TimeInterval {
        return TimeInterval(self.forecast.dt)
    }
    
    var temperature: String {
        return self.forecast.main.temp.tempToString()
    }
    
    var min: String {
        return self.forecast.main.temp_min.tempToStringWithLabel(label: "min: ")
    }
    
    var max: String {
        return self.forecast.main.temp_max.tempToStringWithLabel(label: "max: ")
    }
    
    var main: String {
        return self.forecast.weather.first?.main ?? ""
    }
    
    var description: String {
        return self.forecast.weather.first?.description ?? ""
    }
    
    var icon: String {
        return self.forecast.weather.first?.icon ?? ""
    }
    
    var date: String {
        let formatter = DateFormatter()
        let date = Date(timeIntervalSince1970: self.timestamp)
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    // MARK: - INIT
    
    init(forecast: Forecast) {
        self.forecast = forecast
    }
    
    // MARK: - FUNCTIONS
    
    
    
    
}

// MARK: - EXTENSION DOUBLE

extension Double {
    
    func tempToString() -> String {
        let int = Int(self)
        let celcius = "°C"
        return String(int) + celcius
    }
    
    func tempToStringWithLabel(label: String) -> String {
        return label + self.tempToString()
    }
    
}
