//
//  WeatherError.swift
//  Meteo-MVVM
//
//  Created by Thomas George on 19/03/2022.
//

import Foundation

enum WeatherError:  Error {
    case json(desc: String)
    case connection(desc: String)
}
