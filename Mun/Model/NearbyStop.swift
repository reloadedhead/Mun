//
//  NearbyStop.swift
//  Mun
//
//  Created by Tomás García Gobet on 17.09.23.
//

import Foundation
import CoreLocation

struct NearbyStop: Codable {
    var latitude: Double
    var longitude: Double
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
    var systemImage: String {
        if self.transportTypes.count > 1 {
            return "circle.hexagongrid.fill"
        } else {
            if let transport = self.transportTypes.first {
                switch (transport) {
                case .bus:
                    return "bus"
                case .sbahn:
                    return "tram"
                case .ubahn:
                    return "tram.fill.tunnel"
                case .tram:
                    return "cablecar"
                case .bahn:
                    return "tram"
                case .regionalBus:
                    return "bus"
                case .ferry:
                    return "ferry"
                }
            } else {
                return ""
            }
        }
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}

extension NearbyStop {
    static func near(latitude: Double, longitude: Double) -> Resource<[NearbyStop]> {
        guard let url = URL.nearbyStops(latitude: latitude, longitude: longitude) else {
            fatalError("Whoops")
        }
        
        return Resource(url: url, method: .get([]))
    }
    
    static func near(_ location: CLLocationCoordinate2D) -> Resource<[NearbyStop]> {
        guard let url = URL.nearbyStops(latitude: location.latitude, longitude: location.longitude) else {
            fatalError("Whoops")
        }
        
        return Resource(url: url, method: .get([]))
    }
}

extension URL {
    static func nearbyStops(latitude: Double, longitude: Double) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.mvg.de"
        components.path = "/api/fib/v2/station/nearby?latitude=\(latitude)&longitude=\(longitude)"
        return components.url!
    }
}

