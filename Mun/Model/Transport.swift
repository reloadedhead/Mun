//
//  Transport.swift
//  Mun
//
//  Created by Tomás García Gobet on 17.09.23.
//

import Foundation

enum Transport: String, CustomStringConvertible, Codable {
    case SBAHN = "SBAHN"
    case UBAHN = "UBAHN"
    case BUS = "BUS"
    case TRAM = "TRAM"
    case BAHN = "BAHN"
    
    var description: String {
        switch self {
        case .SBAHN:
            "S-Bahn"
        case .UBAHN:
            "U-Bahn"
        case .BUS:
            "Bus"
        case .TRAM:
            "Tram"
        case .BAHN:
            "Train"
        }
    }
}
