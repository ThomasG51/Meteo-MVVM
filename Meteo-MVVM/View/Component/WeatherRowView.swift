//
//  WeatherRowView.swift
//  Meteo-MVVM
//
//  Created by Thomas George on 22/03/2022.
//

import SwiftUI

struct WeatherRowView: View {
  
    // MARK: - VIEW MODELS
    
    @ObservedObject var imageViewModel: ImageViewModel
    private let weatherViewModel : WeatherViewModel

    // MARK: - INIT
    
    init(weatherViewModel: WeatherViewModel) {
        self.weatherViewModel = weatherViewModel
        self.imageViewModel = ImageViewModel(weatherViewModel.icon)
    }
    
    // MARK: - VIEW BODY
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(self.weatherViewModel.temperature)
                        .font(.title)
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    if let image = self.imageViewModel.uiImage {
                        Image(uiImage: image)
                        
                        
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(self.weatherViewModel.description)
                        .padding(.bottom, 10)
                    
                    Spacer()
                    
                    Text(self.weatherViewModel.min)
                        .foregroundColor(.blue)
                    
                    Text(self.weatherViewModel.max)
                        .foregroundColor(.red)
                }
            }
        }
    }
}
