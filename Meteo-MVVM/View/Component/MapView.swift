//
//  MapView.swift
//  Meteo-MVVM
//
//  Created by Thomas George on 19/03/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    // MARK: - STATE / BINDING

    @Binding var region: MKCoordinateRegion

    // MARK: - VIEW BODY
    
    var body: some View {
        HStack {
            Map(coordinateRegion: self.$region)
        }
    }
}
