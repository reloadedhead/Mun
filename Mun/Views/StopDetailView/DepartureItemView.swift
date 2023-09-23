//
//  DepatureItemView.swift
//  Mun
//
//  Created by Tomás García Gobet on 17.09.23.
//

import SwiftUI

struct DepartureItemView: View {
    var departure: Departure
    
    var body: some View {
        HStack(alignment: .center) {
            departure.transportType.icon
            VStack(alignment: .leading) {
                Text(departure.label)
                Text("To \(departure.destination)")
                    .font(.footnote)
                    .foregroundStyle(.gray)
                if let platform = departure.platform {
                    Text("Platform \(platform)")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
            }
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(departure.plannedDeparture.formatted(date: .omitted, time: .shortened))
                if let delayInMinutes = departure.delayInMinutes {
                    if (delayInMinutes > 0) {
                        Text("+ \(delayInMinutes)m").foregroundStyle(.red)
                    } else {
                        Text("On time").foregroundStyle(.green)
                    }
                }
            }
        }
    }
}

#Preview {
    DepartureItemView(departure: Departure(plannedDepartureTime: 1694973120000, realtime: true, delayInMinutes: 1, realtimeDepartureTime: 1694973180000, transportType: .SBAHN, label: "S6", divaId: "1", network: "ddb", trainType: "", destination: "Ebersberg", cancelled: false, sev: false, bannerHash: "", occupancy: "UNKNOWN", stopPointGlobalId: ""))
}

#Preview {
    DepartureItemView(departure: Departure(plannedDepartureTime: 1694973120000, realtime: true, delayInMinutes: 1, realtimeDepartureTime: 1694973180000, transportType: .SBAHN, label: "S6", divaId: "1", network: "ddb", trainType: "", destination: "Ebersberg", cancelled: false, sev: false, platform: 10, bannerHash: "", occupancy: "UNKNOWN", stopPointGlobalId: ""))
}
