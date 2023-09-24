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
    @State private var selectedTransport: Transport
    
    var stop: Stop
    
    init(stop: Stop) {
        self.departures = []
        self.isLoading = false
        self.stop = stop
        self.selectedTransport = stop.products.first!
    }
    
    private var filteredDepartures: [Departure] { departures.filter { $0.transportType == selectedTransport } }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if isLoading {
                Spacer()
                ProgressView()
                Spacer()
            } else {
                if (departures.isEmpty) {
                    ContentUnavailableView("No departures", systemImage: "clock.badge.xmark", description: Text("There is nothing departing from \(stop.name) right now."))
                } else {
                    if stop.products.count > 1 {
                        Picker("", selection: $selectedTransport) {
                            ForEach(stop.products, id: \.self) { transport in
                                HStack {
                                    Label(transport.description, systemImage: transport.systemImage).labelStyle(.titleAndIcon)
                                }.tag(transport)
                            }
                        }.pickerStyle(.palette).padding()
                    }
                    
                    if filteredDepartures.isEmpty {
                        ContentUnavailableView("No departures",
                            systemImage: selectedTransport.systemImage,
                            description: Text("There are no \(selectedTransport.description) departures.")
                        )
                    } else {
                        List {
                            Section("Departures") {
                                ForEach(filteredDepartures, id: \.self) { departure in
                                    DepartureItemView(departure: departure)
                                }
                            }
                        }.refreshable { await self.loadDepartures() }
                    }
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
            departures = try await Fetch().load(Departure.from(stopId: stop.id)).sorted { $0.realDeparture < $1.realDeparture }
        } catch {
            print(error)
        }
    }
}

#Preview {
    NavigationStack {
        StopDetailView(stop: Stop(name: "Marienplatz", place: "München", id: "de:09162:100", divaId: 2, abbreviation: "", tariffZones: "m", products: [.ubahn, .sbahn, .bus], latitude: 48.13725, longitude: 11.57542))
    }
    
}
