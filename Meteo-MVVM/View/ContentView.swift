//
//  ContentView.swift
//  Meteo-MVVM
//
//  Created by Thomas George on 19/03/2022.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTIES
    
    
    
    // MARK: - VIEW MODELS
    
    @ObservedObject var userLocationViewModel: UserLocationViewModel
    @ObservedObject var weatherListViewModel: WeatherListViewModel
    
    // MARK: - STATE / BINDING
    
    @State private var newCity = ""
    
    // MARK: - INIT
    
    init() {
        self.userLocationViewModel = UserLocationViewModel()
        self.weatherListViewModel = WeatherListViewModel()
    }
    
    // MARK: - VIEW BODY
    
    var body: some View {
        if let userLocation = self.userLocationViewModel.userLocation {
            GeometryReader { geo in
                NavigationView {
                    List {
                        MapView(region: .constant(self.userLocationViewModel.setRegion(userLocation: userLocation)))
                            .frame(width: geo.size.width / 3, height: geo.size.width / 3)
                            .cornerRadius(10)
                        
                        HStack {
                            TextField("Choisir une ville", text: self.$newCity)
                            
                            Button(action: {
                                self.userLocationViewModel.convertAddress(address: self.newCity)
                            }, label: {
                                Image(systemName: "mappin.circle")
                            })
                        }
                        
                        Section(header: Text("Prévisions")) {
                            ForEach (self.weatherListViewModel.weatherList) { viewModel in
                                WeatherRowView(weatherViewModel: viewModel)
                            }
                        }
                    }
                    .navigationTitle(userLocation.city)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                self.userLocationViewModel.toggleLocation()
                                self.newCity = ""
                            }, label: {
                                Image(systemName: self.userLocationViewModel.isLocatingMe ? "location.fill" : "location.slash.fill")
                            })
                        }
                    }
                }
                .onAppear() {
                    if let userLocation = self.userLocationViewModel.userLocation {
                        self.weatherListViewModel.requestForecast(userLocation: userLocation)
                    }
                }
            }
            .onChange(of: self.userLocationViewModel.userLocation?.city) { value in
                if let userLocation = self.userLocationViewModel.userLocation {
                    self.weatherListViewModel.requestForecast(userLocation: userLocation)
                }
            }
        } else {
            ProgressView()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
