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
    
    @ObservedObject var viewModel: UserLocationViewModel
    
    // MARK: - STATE / BINDING
    
    @State private var newCity: String = ""
    
    // MARK: - INIT
    
    init() {
        self.viewModel = UserLocationViewModel()
    }
    
    // MARK: - VIEW BODY
    
    var body: some View {
        if let userLocation = self.viewModel.userLocation {
            GeometryReader { geo in
                NavigationView {
                    List {
                        MapView(region: .constant(self.viewModel.setRegion(userLocation: userLocation)))
                            .frame(width: geo.size.width / 3, height: geo.size.width / 3)
                            .cornerRadius(10)
                        
                        HStack {
                            TextField("Add new city", text: self.$newCity)
                            
                            Button(action: {
                                self.viewModel.convertAddress(address: self.newCity)
                            }, label: {
                                Image(systemName: "mappin.circle")
                            })
                        }
                    }
                    .navigationTitle(userLocation.city)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                self.viewModel.toggleLocation()
                            }, label: {
                                Image(systemName: self.viewModel.isLocatingMe ? "location.fill" : "location.slash.fill")
                            })
                        }
                    }
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
