//
//  NearbyStop.swift
//  Mun
//
//  Created by Tomás García Gobet on 17.09.23.
//

import Foundation

struct NearbyStop: Codable {
    var latitude: Float
    var longitude: Float
    var place: String
    var name: String
    var globalId: String
    var divaId: Int
    var hasZoomData: Bool
    var transportTypes: Array<Transport>
    var aliases: String
    var surroundingPlanLink: String
    var tariffZones: String
    var distanceInMeters: Int
}

extension NearbyStop {
    static func near(latitude: Float, longitude: Float) -> Resource<[NearbyStop]> {
        guard let url = URL.nearbyStops(latitude: latitude, longitude: longitude) else {
            fatalError("Whoops")
        }
        
        return Resource(url: url, method: .get([]))
    }
}

extension URL {
    static func nearbyStops(latitude: Float, longitude: Float) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.mvg.de"
        components.path = "/api/fib/v2/station/nearby?latitude=\(latitude)&longitude=\(longitude)"
        print(components.url!)
        return components.url!
    }
}

