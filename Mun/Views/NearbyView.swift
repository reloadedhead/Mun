//
//  NearbyView.swift
//  Mun
//
//  Created by Tomás García Gobet on 15.09.23.
//

import SwiftUI
import MapKit

struct NearbyView: View {
    @State private var nearbyStops: [NearbyStop] = []
    @State private var isLoading = false
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @StateObject private var locationManager = LocationManager()
    
    private var cantLocate: Bool { locationManager.location == nil }
    private var noStops: Bool { nearbyStops.count == 0 }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Map(position: $position) {
                    ForEach(nearbyStops, id: \.divaId) { nearbyStop in
                        Marker(nearbyStop.name,
                               systemImage: nearbyStop.systemImage,
                               coordinate: nearbyStop.coordinate
                        )
                    }
                }
                .mapControls {
                    MapCompass()
                    MapUserLocationButton()
                }
                .frame(height: geometry.size.height * 1/3)
                if isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else if cantLocate {
                    ContentUnavailableView("Current location unavailable", systemImage: "mappin.slash", description: Text("Your current location is unavailable. Have you disabled location services for Mun?"))
                } else if noStops {
                    ContentUnavailableView("No stops near you", systemImage: "map", description: Text("There are no stops nearby."))
                } else {
                    List {
                        Section("Nearby stops") {
                            ForEach(nearbyStops, id: \.divaId) { nearbyStop in
                                    NearbyStopItemView(stop: nearbyStop)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Nearby stops")
        .navigationBarTitleDisplayMode(.inline)
        .task { await loadNearbyStops() }
    }
    
    private func loadNearbyStops() async {
        do {
            if let currentLocation = locationManager.location {
                isLoading.toggle()
                nearbyStops = try await Fetch().load(NearbyStop.near(currentLocation))
                isLoading.toggle()
            }
        } catch {
            print(error)
        }
    }
}

#Preview {
    NavigationStack {
        NearbyView()
    }
}
