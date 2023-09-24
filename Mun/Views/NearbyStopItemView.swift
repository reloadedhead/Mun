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
            TransportsIconView(transports: stop.transportTypes)
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
