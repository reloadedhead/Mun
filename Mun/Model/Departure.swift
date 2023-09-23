//
//  Departure.swift
//  Mun
//
//  Created by Tomás García Gobet on 17.09.23.
//

import Foundation

struct Departure: Codable, Hashable {
    var plannedDepartureTime: Double
    var realtime: Bool
    var delayInMinutes: Int?
    var realtimeDepartureTime: Double
    var transportType: Transport
    var label: String
    var divaId: String
    var network: String
    var trainType: String
    var destination: String
    var cancelled: Bool
    var sev: Bool
    var platform: Int?
    var stopPositionNumber: Int?
    var bannerHash: String
    var occupancy: String
    var stopPointGlobalId: String
}

extension Departure {
    var plannedDeparture: Date { Date(timeIntervalSince1970: self.plannedDepartureTime / 1000) }
    var realDeparture: Date { Date(timeIntervalSince1970: self.realtimeDepartureTime / 1000) }
}

extension Departure {
    static func from(stopId: String) -> Resource<[Departure]> {
        guard let url = URL.departuresFrom(stopId: stopId) else {
            fatalError("Whoops")
        }
        
        return Resource(url: url, method: .get([]))
    }
}

extension URL {
    static func departuresFrom(stopId: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.mvg.de"
        components.path = "/api/fib/v2/departure?globalId=\(stopId)"
        return components.url!
    }
}

