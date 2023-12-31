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
        HStack(alignment: .center, spacing: 8) {
            departure.transportType.icon
            VStack(alignment: .leading) {
                HStack {
                    Text(departure.label)
                    if departure.sev {
                        Text("(SEV)")
                    }
                }
                Text("To \(departure.destination)")
                    .font(.footnote)
                    .foregroundStyle(.gray)
                
                if let message = departure.messages.first {
                    Text(message).font(.footnote).foregroundStyle(.gray)
                }
            }
            Spacer()
            
            VStack(alignment: .trailing) {
                if let delayInMinutes = departure.delayInMinutes {
                    if delayInMinutes > 0 {
                        Text(departure.realDeparture.formatted(date: .omitted, time: .shortened))
                            .foregroundStyle(.red)
                    } else {
                        Text(departure.realDeparture.formatted(date: .omitted, time: .shortened))
                    }
                } else if departure.cancelled {
                    Text(departure.plannedDeparture.formatted(date: .omitted, time: .shortened))
                        .strikethrough(departure.cancelled, color: .red)
                } else {
                    Text(departure.realDeparture.formatted(date: .omitted, time: .shortened))
                }
                if departure.cancelled {
                    Text("Cancelled").font(.footnote).foregroundStyle(.red)
                } else {
                    if let platform = departure.platform {
                        switch departure.transportType {
                        case .sbahn:
                            Text("Platform \(platform)")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        case .ubahn:
                            Text("Platform \(platform)")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        case .bus:
                            Text("Stop \(platform)")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        case .regionalBus:
                            Text("Stop \(platform)")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        case .tram:
                            Text("Stop \(platform)")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        case .bahn:
                            Text("Platform \(platform)")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        case .ferry:
                            Text("Pier \(platform)")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    DepartureItemView(departure: Departure(plannedDepartureTime: 1694973120000, realtime: true, delayInMinutes: 1, realtimeDepartureTime: 1694973180000, transportType: .sbahn, label: "S6", divaId: "1", network: "ddb", trainType: "", destination: "Ebersberg", cancelled: false, sev: false, bannerHash: "", occupancy: "UNKNOWN", stopPointGlobalId: "", messages: []))
}

#Preview {
    DepartureItemView(departure: Departure(plannedDepartureTime: 1694973120000, realtime: true, delayInMinutes: 0, realtimeDepartureTime: 1694973180000, transportType: .sbahn, label: "S6", divaId: "1", network: "ddb", trainType: "", destination: "Ebersberg", cancelled: false, sev: false, platform: 10, bannerHash: "", occupancy: "UNKNOWN", stopPointGlobalId: "", messages: []))
}

#Preview {
    DepartureItemView(departure: Departure(plannedDepartureTime: 1694973120000, realtime: true, delayInMinutes: 1, realtimeDepartureTime: 1694973180000, transportType: .sbahn, label: "S6", divaId: "1", network: "ddb", trainType: "", destination: "Ebersberg", cancelled: true, sev: false, platform: 10, bannerHash: "", occupancy: "UNKNOWN", stopPointGlobalId: "", messages: []))
}
