//
//  StopSearchView.swift
//  Mun
//
//  Created by Tomás García Gobet on 23.09.23.
//

import SwiftUI

struct StopSearchView: View {
    @Environment(StopsManager.self) private var stopManager
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    
    var stops: [Stop] {
        if searchText.isEmpty {
            stopManager.stops
        } else {
            stopManager.stops.filter { $0.name.contains(searchText) }
        }
    }
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(stops, id: \.self) { stop in
                    NavigationLink(destination: StopDetailView(stop: stop)) {
                        HStack {
                            TransportsIconView(transports: stop.products)
                            VStack(alignment: .leading) {
                                Text(stop.name)
                                Text(stop.products.join()).font(.footnote).foregroundStyle(.gray)
                            }
                        }
                    }
                }
            }.toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }.navigationTitle("Search stop")
        }.searchable(text: $searchText, placement: .automatic, prompt: "Search a stop or station")
    }
}

#Preview {
    StopSearchView().environment(StopsManager())
}
