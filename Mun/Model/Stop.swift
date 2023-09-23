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

extension URL {
    static func stops() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.mvg.de"
        components.path = "/.rest/zdm/stations"
        return components.url!
    }
}
