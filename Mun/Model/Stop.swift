//
//  Stop.swift
//  Mun
//
//  Created by Tomás García Gobet on 23.09.23.
//

import Foundation

struct Stop: Codable, Hashable {
    var name: String
    var place: String
    var id: String
    var divaId: Int
    var abbreviation: String?
    var tariffZones: String
    var products: [Transport]
    var latitude: Double
    var longitude: Double
}

extension Stop {
    static func all() -> Resource<[Stop]> {
        guard let url = URL.stops() else { fatalError() }
        
        return Resource(url: url, method: .get([]))
    }
}

extension Stop {
    init(using nearbyStopModel: NearbyStop) {
        self.name = nearbyStopModel.name
        self.place = nearbyStopModel.place
        self.id = nearbyStopModel.globalId
        self.divaId = nearbyStopModel.divaId
        self.abbreviation = nearbyStopModel.aliases
        self.tariffZones = nearbyStopModel.tariffZones
        self.products = nearbyStopModel.transportTypes
        self.latitude = nearbyStopModel.latitude
        self.longitude = nearbyStopModel.longitude
    }
}

extension URL {
    static func stops() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.mvg.de"
        components.path = "/.rest/zdm/stations"
        return components.url!
    }
}
