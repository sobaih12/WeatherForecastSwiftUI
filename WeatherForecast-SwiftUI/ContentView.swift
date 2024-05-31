//
//  ContentView.swift
//  WeatherForecast-SwiftUI
//
//  Created by Mostfa Sobaih on 12/05/2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var locationViewModel = LocationViewModel()

    var body: some View {
        HomeScreen()
            .onAppear{
                locationViewModel.requestLocation()
            }
    }
}

#Preview {
    ContentView()
}
