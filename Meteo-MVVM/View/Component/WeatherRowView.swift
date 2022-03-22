//
//  WeatherRowView.swift
//  Meteo-MVVM
//
//  Created by Thomas George on 22/03/2022.
//

import SwiftUI

struct WeatherRowView: View {
    
    // MARK: - PROPERTIES
    
    
    
    // MARK: - VIEW MODELS
    
    @ObservedObject var imageViewModel: ImageViewModel
    private let weatherViewModel : WeatherViewModel
    
    // MARK: - STATE / BINDING
    
    
    
    // MARK: - INIT
    
    init(weatherViewModel: WeatherViewModel) {
        self.weatherViewModel = weatherViewModel
        self.imageViewModel = ImageViewModel(weatherViewModel.icon)
    }
    
    // MARK: - VIEW BODY
    
    var body: some View {
        VStack {
            HStack {
                Text(self.weatherViewModel.temperature)
                    .font(.title)
                
                Spacer()
                
                Text(self.weatherViewModel.date)
                    .font(.callout)
                    .foregroundColor(.blue)
            }
            
            VStack {
                if let image = self.imageViewModel.uiImage {
                    Image(uiImage: image)
                }
                
                Text(self.weatherViewModel.description)
            }
            
            HStack {
                Text(self.weatherViewModel.min)
                
                Spacer()
                
                Text(self.weatherViewModel.max)
            }
        }
    }
}
