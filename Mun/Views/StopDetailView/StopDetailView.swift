//
//  StopDetailView.swift
//  Mun
//
//  Created by Tomás García Gobet on 17.09.23.
//

import SwiftUI

struct StopDetailView: View {
    @State private var departures = [Departure]()
    @State private var isLoading = false
    var stop: NearbyStop
    
    var body: some View {
        ZStack {
            if isLoading {
                Spacer()
                ProgressView()
                Spacer()
            } else {
                List {
                    Section("Departures") {
                        ForEach(departures, id: \.divaId) { departure in
                            DepartureItemView(departure: departure)
                        }
                    }
                }
            }
        }
        .navigationTitle(stop.name)
        .task { await self.loadDepartures() }
    }
    
    private func loadDepartures() async {
        do {
            isLoading.toggle()
            departures = try await Fetch().load(Departure.from(stopId: stop.globalId))
            isLoading.toggle()
        } catch {
            print(error)
        }
    }
}

#Preview {
    NavigationStack {
        StopDetailView(stop: NearbyStop(latitude: 48.13725, longitude: 11.57542, place: "München", name: "Marienplatz", globalId: "de:09162:2", divaId: 2, hasZoomData: true, transportTypes: [.UBAHN, .SBAHN, .BUS], aliases: "", surroundingPlanLink: "MP", tariffZones: "m", distanceInMeters: 153))
    }
    
}
