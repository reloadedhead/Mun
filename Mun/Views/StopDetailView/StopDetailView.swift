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
                if (departures.isEmpty) {
                    ContentUnavailableView("No departures", systemImage: "clock.badge.xmark", description: Text("There is nothing departing from \(stop.name) right now."))
                } else {
                    List {
                        Section("Departures") {
                            ForEach(departures, id: \.self) { departure in
                                DepartureItemView(departure: departure)
                            }
                        }
                    }.refreshable { await self.loadDepartures() }
                }
            }
        }
        .navigationTitle(stop.name)
        .task {
            isLoading.toggle()
            await self.loadDepartures()
            isLoading.toggle()
        }
    }
    
    private func loadDepartures() async {
        do {
            departures = try await Fetch().load(Departure.from(stopId: stop.globalId)).sorted { $0.realDeparture < $1.realDeparture }
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
