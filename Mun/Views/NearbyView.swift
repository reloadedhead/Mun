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
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Map(interactionModes: [.all]) {
                    ForEach(nearbyStops, id: \.divaId) { nearbyStop in
                        Marker(nearbyStop.name, coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(nearbyStop.latitude), longitude: CLLocationDegrees(nearbyStop.longitude)))
                    }
                }
                .mapControls {
                    MapUserLocationButton()
                }
                .frame(height: geometry.size.height * 1/3)

                List {
                    Section("Nearby stops") {
                        ForEach(nearbyStops, id: \.divaId) { nearbyStop in
                                NearbyStopItemView(stop: nearbyStop)
                        }
                    }
                }
            }
        }
        .navigationTitle("Nearby stops")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            do {
                nearbyStops = try await Fetch().load(NearbyStop.near(latitude: 48.14726, longitude: 11.46482))
            } catch {
                print(error)
            }
        }
    }
    
    private mutating func loadNearbyStops() {
        
    }
}

#Preview {
    NavigationStack {
        NearbyView()
    }
}
