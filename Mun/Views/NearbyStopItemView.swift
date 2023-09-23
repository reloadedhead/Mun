//
//  StopItemView.swift
//  Mun
//
//  Created by Tomás García Gobet on 16.09.23.
//

import SwiftUI

struct NearbyStopItemView: View {
    var stop: NearbyStop
    
    var availableTransports: String {
        "\(self.joinTransports())."
    }
    
    var body: some View {
        HStack {
            TransportTypeIcon(transports: stop.transportTypes)
            VStack(alignment: .leading) {
                Text(stop.name)
                Text(availableTransports)
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Text("\(stop.distanceInMeters) meters").foregroundStyle(.gray)
        }
    }
    
    private func joinTransports() -> String {
        stop.transportTypes.map { $0.description }.joined(separator: ", ")
    }
}

private struct TransportTypeIcon: View {
    var transports: [Transport]
    var isMultiTransport: Bool { self.transports.count > 1 }
    
    var body: some View {
        if isMultiTransport {
            Image(systemName: "circle.hexagongrid.fill")
                .symbolRenderingMode(.multicolor)
        } else {
            if let transport = transports.first {
                transport.icon
            }
        }
    }
}

//private let mockStop = NearbyStop(name: "Pasing", place: "Munchen", id: "id", divaId: 1, abbreviation: "PA", tariffZones: "m", products: [.SBAHN, .UBAHN], latitude: 10.1, longitude: 10.0)
//
//#Preview {
//    NearbyStopItemView(stop: mockStop, distance: 10)
//}
